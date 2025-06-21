import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/assets.gen.dart';
import 'package:flutter_base/src/core/extensions/context_extension.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../config/res/app_sizes.dart';
import '../../../config/res/constants_manager.dart';
import '../../../core/widgets/not_contain_data.dart';

class PaginationGridView<T> extends StatefulWidget {
  final Widget Function(BuildContext, T, int) itemBuilder;
  final EdgeInsetsGeometry? padding;
  final PagingController<int, T> pagingController;
  final Future<List<T>> Function(int page) fetchItems;
  final double? margin;
  final bool shrinkWrap;
  final double? mainAxisExtent;
  final ScrollPhysics? physics;

  const PaginationGridView({
    super.key,
    required this.itemBuilder,
    this.margin,
    required this.fetchItems,
    required this.shrinkWrap,
    this.physics,
    this.padding,
    required this.pagingController,
    this.mainAxisExtent,
  });

  @override
  State<PaginationGridView<T>> createState() => _PaginationGridViewState<T>();
}

class _PaginationGridViewState<T> extends State<PaginationGridView<T>> {
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await widget.fetchItems(pageKey);
      final isLastPage = newItems.length < ConstantManager.pgSize;
      if (isLastPage) {
        widget.pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        widget.pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      widget.pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView(
      padding: widget.padding,
      pagingController: widget.pagingController,
      builderDelegate: PagedChildBuilderDelegate<T>(
        noItemsFoundIndicatorBuilder: (_) => Container(
          margin: EdgeInsets.symmetric(
            vertical: widget.margin ?? context.height * .2,
          ),
          child: const NotContainData(),
        ),
        firstPageProgressIndicatorBuilder: (_) => _indicator(),
        firstPageErrorIndicatorBuilder: (_) => _indicator(),
        newPageProgressIndicatorBuilder: (_) => _indicator(),
        itemBuilder: widget.itemBuilder,
      ),
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSize.sW8,
        crossAxisSpacing: AppSize.sW8,
        mainAxisExtent: widget.mainAxisExtent,
      ),
    );
  }

  Widget _indicator() {
    return GridView.builder(
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSize.sW8,
        crossAxisSpacing: AppSize.sW8,
        mainAxisExtent: widget.mainAxisExtent,
      ),
      itemBuilder: (context, index) =>
          AppAssets.lottie.loading.loading2.lottie(),
    );
  }
}
