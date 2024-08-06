import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

part '_scroll_position.dart';
part '_physics.dart';
part '_controller.dart';
part '_state.dart';

/// A scrollable list that works page by page.
class InfinitePageView extends StatefulWidget {
  const InfinitePageView({
    super.key,
    this.scrollDirection = Axis.horizontal,
    this.controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    List<Widget> children = const <Widget>[],
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.scrollBehavior,
    this.padEnds = true,
    required this.itemBuilder,
    this.itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  });

  /// See [PageView.allowImplicitScrolling]
  final bool allowImplicitScrolling;

  /// See [PageView.restorationId]
  final String? restorationId;

  /// See [PageView.scrollDirection]
  final Axis scrollDirection;

  /// See: [ScrollView.controller]
  final InfiniteScrollController? controller;

  /// See: [PageView.physics]
  final ScrollPhysics? physics;

  /// See: [PageView.pageSnapping]
  final bool pageSnapping;

  /// See: [PageView.onPageChanged]
  final ValueChanged<int>? onPageChanged;

  /// See: [PageView.dragStartBehavior]
  final DragStartBehavior dragStartBehavior;

  /// See: [PageView.clipBehavior]
  final Clip clipBehavior;

  /// See: [PageView.scrollBehavior]
  final ScrollBehavior? scrollBehavior;

  /// See: [PageView.padEnds]
  final bool padEnds;

  /// See: [PageView.builder]
  final IndexedWidgetBuilder itemBuilder;

  /// See: [SliverChildBuilderDelegate.childCount]
  final int? itemCount;

  /// See: [SliverChildBuilderDelegate.addAutomaticKeepAlives]
  final bool addAutomaticKeepAlives;

  /// See: [SliverChildBuilderDelegate.addRepaintBoundaries]
  final bool addRepaintBoundaries;

  /// See: [SliverChildBuilderDelegate.addSemanticIndexes]
  final bool addSemanticIndexes;

  @override
  State<InfinitePageView> createState() => _InfinitePageViewState();
}
