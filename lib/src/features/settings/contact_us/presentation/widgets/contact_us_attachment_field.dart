part of '../imports/contact_us_imports.dart';

class _ContactUsAttachmentField extends StatelessWidget {
  const _ContactUsAttachmentField({required this.vc});

  final ContactUsViewController vc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMargin.mH8,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              LocaleKeys.contactUsAttachmentTitle,
              style: const TextStyle().setSecondryColor.s14.semiBold,
            ),
            AppMargin.mW4.szW,
            Text(
              LocaleKeys.contactUsAttachmentOptional,
              style: const TextStyle().setHintColor.s12.regular,
            ),
          ],
        ),
        ValueListenableBuilder<String?>(
          valueListenable: vc.attachmentName,
          builder: (context, attach, _) {
            return GestureDetector(
              onTap: () => vc.pickAttachment(context),
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(AppCircular.r15),
                  color: AppColors.grey2,
                  strokeWidth: 2,
                  dashPattern: const [6, 4],
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(minHeight: AppSize.sH70),
                  padding: EdgeInsets.symmetric(
                    vertical: AppPadding.pH16,
                    horizontal: AppPadding.pW12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppCircular.r15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.contactUsTapAddImage,
                              textAlign: TextAlign.center,
                              style: const TextStyle().setPrimaryColor.s13.medium,
                            ),
                            AppMargin.mH4.szH,
                            Text(
                              LocaleKeys.contactUsAttachmentFormats,
                              textAlign: TextAlign.center,
                              style: const TextStyle().setHintColor.s12.regular,
                            ),
                            if (attach != null && attach.isNotEmpty) ...[
                              AppMargin.mH4.szH,
                              Text(
                                attach,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle().setMainTextColor.s11.regular,
                              ),
                            ],
                          ],
                        ),
                      ),
                      Container(
                        width: AppSize.sH40,
                        height: AppSize.sH40,
                        decoration: const BoxDecoration(
                          color: AppColors.selectedButton,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconWidget(
                            icon: AppAssets.svg.wzeinIcons.add01.path,
                            height: AppSize.sH20,
                            width: AppSize.sW20,
                            color: AppColors.hintText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
