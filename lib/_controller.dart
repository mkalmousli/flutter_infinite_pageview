part of 'infinite_pageview.dart';

/// Same as a [ScrollController] except it provides [ScrollPosition] objects with infinite bounds.
class InfiniteScrollController extends ScrollController {
  /// Creates a new [InfiniteScrollController]
  InfiniteScrollController({
    double initialScrollOffset = 0.0,
    bool keepScrollOffset = true,
    String? debugLabel,
    this.viewportFraction = 1.0,
  }) : super(
          initialScrollOffset: initialScrollOffset,
          keepScrollOffset: keepScrollOffset,
          debugLabel: debugLabel,
        );

  final double viewportFraction;

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics,
      ScrollContext context, ScrollPosition? oldPosition) {
    return _InfiniteScrollPosition(
      physics: physics,
      context: context,
      initialPixels: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
    );
  }
}
