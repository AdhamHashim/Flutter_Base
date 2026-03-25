part of '../imports/view_imports.dart';

class _BillsBody extends StatelessWidget {
  const _BillsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillsCubit, BillsState>(
      builder: (context, state) {
        final visible = state.visibleBills;
        final empty = visible.isEmpty;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!empty) const _BillsSearchField(),
            if (!empty) AppMargin.mH12.szH,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    if (empty)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: _BillsEmptyContent(),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsetsDirectional.only(
                          start: AppPadding.pW16,
                          end: AppPadding.pW16,
                          bottom: AppPadding.pH12,
                        ),
                        sliver: SliverList.separated(
                          itemCount: visible.length,
                          separatorBuilder: (context, index) =>
                              AppMargin.mH12.szH,
                          itemBuilder: (context, i) {
                            return _BillCardWidget(
                              bill: visible[i],
                              onEdit: () => _BillFormSheet.show(
                                context,
                                mode: BillFormMode.edit,
                                bill: visible[i],
                              ),
                              onDelete: () => context
                                  .read<BillsCubit>()
                                  .removeBill(visible[i].id),
                            );
                          },
                        ),
                      ),
                    SliverToBoxAdapter(child: AppSize.sH20.szH),
                  ],
                ),
              ),
            ),
            if (!empty)
              _BillsAddButtonSection(
                onPressed: () => _BillFormSheet.show(
                  context,
                  mode: BillFormMode.add,
                ),
              ),
          ],
        ).paddingSymmetric(horizontal: AppPadding.pW12);
      },
    );
  }
}
