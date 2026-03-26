part of '../imports/view_imports.dart';

class _SubscriptionsFeatureRow extends StatelessWidget {
  const _SubscriptionsFeatureRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: AppSize.sH20,
          height: AppSize.sH20,
          decoration: const BoxDecoration(
            color: AppColors.forth,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconWidget(
              icon: AppAssets.svg.baseSvg.correct.path,
              height: AppSize.sH12,
              width: AppSize.sW12,
              color: AppColors.white,
            ),
          ),
        ),
        AppMargin.mW8.szW,
        Expanded(
          child: Text(
            label,
            style: const TextStyle().setPrimaryColor.s12.regular,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
