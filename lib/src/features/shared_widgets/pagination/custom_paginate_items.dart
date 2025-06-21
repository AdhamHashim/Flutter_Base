import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/color_manager.dart';
import 'package:flutter_base/src/core/extensions/context_extension.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../config/res/app_sizes.dart';
import '../../../config/res/constants_manager.dart';
import '../../../core/widgets/not_contain_data.dart';

class PaginationListView<T> extends StatefulWidget {
  final Widget Function(BuildContext, T, int) itemBuilder;
  final double? margin;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final bool reverse;
  final PagingController<int, T> pagingController;
  final ScrollController? scrollController;
  final Future<List<T>> Function(int page) fetchItems;
  final ScrollPhysics? physics;

  const PaginationListView({
    super.key,
    required this.itemBuilder,
    this.margin,
    this.scrollController,
    required this.fetchItems,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.reverse = false,
    required this.pagingController,
  });

  @override
  State<PaginationListView<T>> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T> extends State<PaginationListView<T>> {
  @override
  void initState() {
    super.initState();
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await widget.fetchItems(pageKey);
      final isLastPage = newItems.length < ConstantManager.pgSize;
      if (isLastPage) {
        if (!mounted) return;
        widget.pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        if (!mounted) return;
        widget.pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      if (!mounted) return;

      widget.pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, T>(
      pagingController: widget.pagingController,
      scrollDirection: widget.scrollDirection,
      scrollController: widget.scrollController,
      padding: widget.padding,
      reverse: widget.reverse,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      builderDelegate: PagedChildBuilderDelegate<T>(
        noItemsFoundIndicatorBuilder: (_) => Container(
          margin: EdgeInsets.symmetric(
            vertical: widget.margin ?? context.height * .2,
          ),
          child: const NotContainData(),
        ),
        firstPageProgressIndicatorBuilder: (_) => indicator(),
        firstPageErrorIndicatorBuilder: (_) => indicator(),
        newPageProgressIndicatorBuilder: (_) => indicator(),
        itemBuilder: widget.itemBuilder,
      ),
    );
  }

  Widget indicator() {
    return Container(
      margin: widget.margin != null
          ? EdgeInsets.symmetric(vertical: widget.margin!)
          : null,
      child: SpinKitCircle(
        color: AppColors.main,
        size: AppSize.sH40,
      ),
    );
  }
}
