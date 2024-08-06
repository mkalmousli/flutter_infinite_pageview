part of 'infinite_pageview.dart';

class _InfinitePageViewState extends State<InfinitePageView> {
  int _lastReportedPage = 0;

  late InfiniteScrollController _controller;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _initController() {
    _controller = widget.controller ?? InfiniteScrollController();
  }

  @override
  void didUpdateWidget(InfinitePageView oldWidget) {
    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller == null) {
        _controller.dispose();
      }
      _initController();
    }
    super.didUpdateWidget(oldWidget);
  }

  AxisDirection _getDirection(BuildContext context) {
    switch (widget.scrollDirection) {
      case Axis.horizontal:
        assert(debugCheckHasDirectionality(context));
        final TextDirection textDirection = Directionality.of(context);
        final AxisDirection axisDirection =
            textDirectionToAxisDirection(textDirection);
        return axisDirection;

      case Axis.vertical:
        return AxisDirection.down;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (widget.onPageChanged != null &&
            notification is ScrollUpdateNotification) {
          final PageMetrics metrics = notification.metrics as PageMetrics;
          final int currentPage = metrics.page!.round();
          if (currentPage != _lastReportedPage) {
            _lastReportedPage = currentPage;
            widget.onPageChanged!(currentPage);
          }
        }
        return false;
      },
      child: _buildScrollable(),
    );
  }

  Scrollable _buildScrollable() {
    final List<Widget> slivers = _buildSlivers(context, negative: false);
    final List<Widget> negativeSlivers = _buildSlivers(context, negative: true);
    final AxisDirection axisDirection = _getDirection(context);
    final ScrollPhysics physics = _ForceImplicitScrollPhysics(
      allowImplicitScrolling: widget.allowImplicitScrolling,
    ).applyTo(
      widget.pageSnapping
          ? _kPagePhysics.applyTo(widget.physics ??
              widget.scrollBehavior?.getScrollPhysics(context))
          : widget.physics ?? widget.scrollBehavior?.getScrollPhysics(context),
    );

    return Scrollable(
      dragStartBehavior: widget.dragStartBehavior,
      axisDirection: axisDirection,
      controller: _controller,
      physics: physics,
      restorationId: widget.restorationId,
      scrollBehavior: widget.scrollBehavior ??
          ScrollConfiguration.of(context).copyWith(scrollbars: false),
      viewportBuilder: (BuildContext context, ViewportOffset offset) {
        return Builder(
          builder: (context) {
            /// Build negative [ScrollPosition] for the negative scrolling [Viewport].
            final state = Scrollable.of(context);
            final negativeOffset = _InfiniteScrollPosition(
              physics: physics,
              context: state,
              initialPixels: -offset.pixels,
              keepScrollOffset: _controller.keepScrollOffset,
              negativeScroll: true,
            );

            offset.addListener(() {
              negativeOffset._forceNegativePixels(offset.pixels);
            });

            return Stack(
              children: <Widget>[
                Viewport(
                  // TODO(dnfield): we should provide a way to set cacheExtent
                  // independent of implicit scrolling:
                  // https://github.com/flutter/flutter/issues/45632
                  cacheExtent: widget.allowImplicitScrolling ? 1.0 : 0.0,
                  cacheExtentStyle: CacheExtentStyle.viewport,
                  axisDirection: flipAxisDirection(axisDirection),
                  offset: negativeOffset,
                  clipBehavior: widget.clipBehavior,
                  slivers: negativeSlivers,
                ),
                Viewport(
                  // TODO(dnfield): we should provide a way to set cacheExtent
                  // independent of implicit scrolling:
                  // https://github.com/flutter/flutter/issues/45632
                  cacheExtent: widget.allowImplicitScrolling ? 1.0 : 0.0,
                  cacheExtentStyle: CacheExtentStyle.viewport,
                  axisDirection: axisDirection,
                  offset: offset,
                  clipBehavior: widget.clipBehavior,
                  slivers: slivers,
                )
              ],
            );
          },
        );
      },
    );
  }

  List<Widget> _buildSlivers(BuildContext context, {bool negative = false}) =>
      <Widget>[
        SliverFillViewport(
          viewportFraction: _controller.viewportFraction,
          delegate:
              negative ? negativeChildrenDelegate : positiveChildrenDelegate,
          padEnds: widget.padEnds,
        ),
      ];

  SliverChildDelegate get negativeChildrenDelegate {
    final itemCount = widget.itemCount;

    return SliverChildBuilderDelegate(
      (context, index) => widget.itemBuilder(context, -index),
      childCount: itemCount != null ? math.max(0, itemCount * 2 - 1) : null,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
    );
  }

  SliverChildDelegate get positiveChildrenDelegate {
    return SliverChildBuilderDelegate(
      widget.itemBuilder,
      childCount: widget.itemCount,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description
        .add(EnumProperty<Axis>('scrollDirection', widget.scrollDirection));
    description.add(DiagnosticsProperty<InfiniteScrollController>(
        'controller', _controller,
        showName: false));
    description.add(DiagnosticsProperty<ScrollPhysics>(
        'physics', widget.physics,
        showName: false));
    description.add(FlagProperty('pageSnapping',
        value: widget.pageSnapping, ifFalse: 'snapping disabled'));
    description.add(FlagProperty('allowImplicitScrolling',
        value: widget.allowImplicitScrolling,
        ifTrue: 'allow implicit scrolling'));
  }
}
