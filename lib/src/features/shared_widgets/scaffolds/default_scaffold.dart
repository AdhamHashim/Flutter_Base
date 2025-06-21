part of '../imports/shared_widgets_imports.dart';

class DefaultScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final void Function()? onTap;
  final Widget? trailing;

  const DefaultScaffold({
    super.key,
    this.title,
    required this.body,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: AppPadding.pH4,
                  horizontal: AppPadding.pH12,
                ),
                child: Column(
                  spacing: AppMargin.mH14,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: onTap ?? () => Go.back(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: AppMargin.mH10,
                            children: [
                              // AppAssets.svg.arrowback.svg(
                              //   height: AppSize.sH14,
                              //   width: AppSize.sH14,
                              // ),
                              Text(
                                title!,
                                style:
                                    const TextStyle().setPrimaryColor.s16.bold,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: trailing != null,
                          replacement: SizedBox(height: AppSize.sH18),
                          child: trailing ?? SizedBox(height: AppSize.sH18),
                        ),
                      ],
                    ).paddingTop(AppPadding.pH12),
                  ],
                ),
              ),
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}
