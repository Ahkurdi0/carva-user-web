import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/core/utils/pagination.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:sizer/sizer.dart';

class PagingListView<T> extends StatelessWidget {
  final PagingState<T> state;
  final Future<void> Function()? onRefresh;
  final VoidCallback? onLoadMore;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? loadingWidget;
  final Widget? initalLoadingWidget;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final EdgeInsets? padding;
  final Widget? postfixWidget;
  final Widget? suffixWidget;
  final bool shirkWrap;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  const PagingListView({
    super.key,
    required this.state,
    this.onLoadMore,
    required this.itemBuilder,
    this.onRefresh,
    this.loadingWidget,
    this.initalLoadingWidget,
    this.emptyWidget,
    this.errorWidget,
    this.padding,
    this.postfixWidget,
    this.suffixWidget,
    this.shirkWrap = false,
    this.scrollDirection = Axis.vertical,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    // Initial loading
    if (state.initalLoading && state.items.isEmpty) {
      return initalLoadingWidget ?? Text("Loading...");
    }

    // Initial error
    if (state.error != null && state.items.isEmpty) {
      return errorWidget ?? Center(child: Text('Error: ${state.error}'));
    }

    // Empty data
    if (state.isEmpty) {
      return emptyWidget ?? const Center(child: Text("No data found"));
    }

    final items = state.items;
    final showLoadMoreIndicator =
        state.isLoading && items.isNotEmpty && state.hasNextPage;

    final showErrorBelowList =
        state.error != null && items.isNotEmpty; // Error while loading more

    final showEndOfListMessage =
        !state.hasNextPage && !state.isLoading && items.isNotEmpty;

    final listView = NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (onLoadMore == null) return false;
        final direction = notification.direction;
        if (direction == ScrollDirection.reverse &&
            notification.metrics.extentAfter == 0 &&
            state.hasNextPage &&
            !state.isLoading) {
          onLoadMore?.call();
        }
        return false;
      },
      child: ListView.builder(
        shrinkWrap: shirkWrap,
        physics: physics,
        scrollDirection: scrollDirection,
        padding: padding,
        itemCount:
            items.length +
            1 + // One for footer
            (postfixWidget != null ? 1 : 0) +
            (suffixWidget != null ? 1 : 0),

        itemBuilder: (context, index) {
          int postfixOffset = postfixWidget != null ? 1 : 0;
          int totalItemCount = items.length;

          // 1. Postfix widget at the top
          if (postfixWidget != null && index == 0) {
            return postfixWidget!;
          }

          // 2. Regular list items
          if (index >= postfixOffset &&
              index < totalItemCount + postfixOffset) {
            return itemBuilder(
              context,
              items[index - postfixOffset],
              index - postfixOffset,
            );
          }

          // 3. Footer indicators
          final footerIndex = totalItemCount + postfixOffset;
          if (index == footerIndex) {
            if (showLoadMoreIndicator) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: Text("Loading more...")),
              );
            } else if (showErrorBelowList) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(child: Text('${state.error}')),
              );
            } else if (showEndOfListMessage) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: Text("You've reached the end")),
              );
            }
            return const SizedBox.shrink(); // fallback
          }

          if (suffixWidget != null) {
            return suffixWidget!;
          }

          return const SizedBox.shrink();
        },
      ),
    );

    return onRefresh != null
        ? RefreshIndicator(onRefresh: onRefresh!, child: listView)
        : listView;
  }
}

class PagingSliverList<T> extends StatelessWidget {
  final PagingState<T> state;
  final VoidCallback? onLoadMore;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? loadingWidget;
  final Widget? initalLoadingWidget;
  final ScrollController? controller;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final Future<void> Function()? onRefresh;
  final EdgeInsets? padding;
  final Widget? suffixWidget;
  final Widget? postfixWidget;
  final String? emptyMessage;
  const PagingSliverList({
    super.key,
    required this.state,
    this.onLoadMore,
    required this.itemBuilder,
    this.loadingWidget,
    this.initalLoadingWidget,
    this.controller,
    this.emptyWidget,
    this.errorWidget,
    this.onRefresh,
    this.padding,
    this.suffixWidget,
    this.postfixWidget,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (state.initalLoading) {
      return initalLoadingWidget ?? Center(child: CircleLoading());
    }

    if (state.error != null && state.items.isEmpty) {
      return errorWidget ?? Center(child: Text('${state.error}'));
    }

    final items = state.items;
    final showLoadMoreIndicator =
        state.isLoading &&
        items.isNotEmpty &&
        state.hasNextPage &&
        !state.isRefreshing;
    final showErrorBelowList = state.error != null && items.isNotEmpty;
    final showEndOfListMessage =
        !state.hasNextPage && !state.isLoading && items.isNotEmpty;

    final listView = NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (onLoadMore == null || items.isEmpty) return false;
        final direction = notification.direction;
        if (direction == ScrollDirection.reverse &&
            notification.metrics.extentAfter == 0 &&
            state.hasNextPage &&
            !state.isLoading) {
          onLoadMore?.call();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          if (onRefresh != null) await onRefresh!();
        },
        child: CustomScrollView(
          slivers: [
            if (suffixWidget != null) SliverToBoxAdapter(child: suffixWidget),
            if (state.isEmpty && !state.isLoading && suffixWidget == null)
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 20.w),
                  child:
                      emptyWidget ??
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          EmptyState(),
                          Positioned(
                            bottom: 20.w,
                            child: Text(
                              emptyMessage ?? LocaleKeys.empty_noData.tr(),
                              style: context.caption,
                            ),
                          ),
                        ],
                      ),
                ),
              ),
            SliverPadding(
              padding: padding ?? const EdgeInsets.all(0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index < items.length) {
                    return itemBuilder(context, items[index], index);
                  }
                  if (showLoadMoreIndicator) {
                    return loadingWidget ??
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircleLoading()),
                        );
                  } else if (showErrorBelowList) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: Text('${state.error}')),
                    );
                  } else if (showEndOfListMessage) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          LocaleKeys.empty_reachEnd.tr(),
                          style: context.caption.copyWith(
                            color: context.outline,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }, childCount: items.length + 1),
              ),
            ),
            if (postfixWidget != null) SliverToBoxAdapter(child: postfixWidget),
          ],
        ),
      ),
    );

    return listView;
  }
}

class GridPagingSliverList<T> extends StatelessWidget {
  final PagingState<T> state;
  final VoidCallback? onLoadMore;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? loadingWidget;
  final Widget? initalLoadingWidget;
  final ScrollController? controller;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final Future<void> Function()? onRefresh;
  final EdgeInsets? padding;
  final Widget? suffixWidget;
  final Widget? postfixWidget;
  final String? emptyMessage;

  const GridPagingSliverList({
    super.key,
    required this.state,
    this.onLoadMore,
    required this.itemBuilder,
    this.loadingWidget,
    this.initalLoadingWidget,
    this.controller,
    this.emptyWidget,
    this.errorWidget,
    this.onRefresh,
    this.padding,
    this.suffixWidget,
    this.postfixWidget,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (state.initalLoading) {
      return initalLoadingWidget ?? const Center(child: CircleLoading());
    }

    if (state.error != null && state.items.isEmpty) {
      return errorWidget ?? Center(child: Text('${state.error}'));
    }

    final items = state.items;
    final showLoadMoreIndicator =
        state.isLoading &&
        items.isNotEmpty &&
        state.hasNextPage &&
        !state.isRefreshing;
    final showErrorBelowList = state.error != null && items.isNotEmpty;
    final showEndOfListMessage =
        !state.hasNextPage && !state.isLoading && items.isNotEmpty;

    final listView = NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (onLoadMore == null || items.isEmpty) return false;
        final direction = notification.direction;
        if (direction == ScrollDirection.reverse &&
            notification.metrics.extentAfter == 0 &&
            state.hasNextPage &&
            !state.isLoading) {
          onLoadMore?.call();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          if (onRefresh != null) await onRefresh!();
        },
        child: CustomScrollView(
          controller: controller,
          slivers: [
            if (suffixWidget != null) SliverToBoxAdapter(child: suffixWidget),

            if (state.isEmpty && !state.isLoading && suffixWidget == null)
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 20.w),
                  child:
                      emptyWidget ??
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          EmptyState(),
                          Positioned(
                            bottom: 20.w,
                            child: Text(
                              emptyMessage ?? LocaleKeys.empty_noData.tr(),
                              style: context.caption,
                            ),
                          ),
                        ],
                      ),
                ),
              ),

            // 🟦 Grid only has items
            SliverPadding(
              padding: padding ?? EdgeInsets.zero,
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.w,
                  crossAxisSpacing: 6.w,
                  childAspectRatio: 0.95,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => itemBuilder(context, items[index], index),
                  childCount: items.length,
                ),
              ),
            ),

            if (showLoadMoreIndicator)
              SliverToBoxAdapter(
                child:
                    loadingWidget ??
                    Padding(
                      padding: EdgeInsets.only(bottom: 40.w),
                      child: Center(child: CircleLoading()),
                    ),
              ),

            if (showErrorBelowList)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40.w),
                  child: Center(child: Text('${state.error}')),
                ),
              ),

            if (showEndOfListMessage)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40.w),
                  child: Center(
                    child: Text(
                      LocaleKeys.empty_reachEnd.tr(),
                      style: context.caption.copyWith(color: context.outline),
                    ),
                  ),
                ),
              ),

            if (postfixWidget != null) SliverToBoxAdapter(child: postfixWidget),
          ],
        ),
      ),
    );

    return listView;
  }
}
