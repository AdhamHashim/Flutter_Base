import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../shared/base_state.dart';
import '../widgets/exeption_view.dart';
import '../widgets/not_contain_data.dart';

class StatusBuilder<T> extends StatelessWidget {
  final BaseStatus status;
  final T placeHolder;
  final Function(T placeHolder, bool isLoading) builder;
  final bool? isSliver;
  final bool isEmpty;
  final bool ignoreContainers;
  final bool circularLoading;

  const StatusBuilder({
    super.key,
    required this.status,
    required this.placeHolder,
    this.ignoreContainers = false,
    this.isEmpty = false,
    required this.builder,
  })  : isSliver = false,
        circularLoading = false;

  const StatusBuilder.circularLoading({
    super.key,
    required this.status,
    required this.placeHolder,
    this.ignoreContainers = false,
    this.isEmpty = false,
    required this.builder,
  })  : isSliver = true,
        circularLoading = true;

  const StatusBuilder.sliver({
    super.key,
    required this.status,
    required this.placeHolder,
    this.ignoreContainers = false,
    this.isEmpty = false,
    required this.builder,
  })  : isSliver = true,
        circularLoading = false;

  Widget _buildShimmerLoading() {
    return isSliver!
        ? Skeletonizer.sliver(
            ignoreContainers: ignoreContainers,
            enabled: true,
            child: builder(
              placeHolder,
              status.isLoading,
            ),
          )
        : Skeletonizer(
            ignoreContainers: ignoreContainers,
            enabled: true,
            child: builder(
              placeHolder,
              status.isLoading,
            ),
          );
  }

  Widget _buildCircularLoading() {
    return isSliver!
        ? const SliverFillRemaining(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : const Center(
            child: CupertinoActivityIndicator(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return status.when(
      onLoading: () =>
          circularLoading ? _buildCircularLoading() : _buildShimmerLoading(),
      onSuccess: () => isEmpty
          ? !isSliver!
              ? const NotContainData()
              : const SliverFillRemaining(child: NotContainData())
          : builder(
              placeHolder,
              status.isLoading,
            ),
      onError: () => isSliver!
          ? const SliverFillRemaining(child: ExceptionView())
          : const Expanded(
              child: ExceptionView(),
            ),
      onLoadingMore: () {
        return circularLoading
            ? _buildCircularLoading()
            : _buildShimmerLoading();
      },
    );
  }
}
