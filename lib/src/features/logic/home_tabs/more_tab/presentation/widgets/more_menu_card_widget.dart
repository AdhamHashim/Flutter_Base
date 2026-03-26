part of '../imports/view_imports.dart';

class MoreMenuCardWidget extends StatelessWidget {
  const MoreMenuCardWidget({super.key, required this.menuItem});

  final MoreItemEntity menuItem;

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textDirection: context.isArabic
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      children: [
        Container(
          width: AppSize.sH40,
          height: AppSize.sH40,
          decoration: const BoxDecoration(
            color: AppColors.selectedButton,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconWidget(
              icon: menuItem.icon,
              width: AppSize.sW18,
              height: AppSize.sH18,
            ),
          ),
        ),
        AppMargin.mW12.szW,
        Expanded(
          child: menuItem.useSwitch
              ? Row(
                  textDirection: context.isArabic
                      ? ui.TextDirection.rtl
                      : ui.TextDirection.ltr,
                  children: [
                    Expanded(
                      child: Text(
                        menuItem.title,
                        textAlign: TextAlign.start,
                        textDirection: context.isArabic
                            ? ui.TextDirection.rtl
                            : ui.TextDirection.ltr,
                        style: const TextStyle()
                            .setSecondryColor
                            .s14
                            .medium
                            .setFontFamily,
                      ),
                    ),
                    const _SwitchNotifyWidget(),
                  ],
                )
              : Text(
                  menuItem.title,
                  textAlign: TextAlign.start,
                  textDirection: context.isArabic
                      ? ui.TextDirection.rtl
                      : ui.TextDirection.ltr,
                  style: const TextStyle()
                      .setSecondryColor
                      .s14
                      .medium
                      .setFontFamily,
                ),
        ),
        if (!menuItem.useSwitch && !menuItem.disableArrow) ...[
          AppMargin.mW12.szW,
          Transform(
            alignment: Alignment.center,
            transform: context.isRight
                ? Matrix4.rotationY(math.pi)
                : Matrix4.identity(),
            child: IconWidget(
              icon: AppAssets.svg.baseSvg.arrowBack.path,
              width: AppSize.sH20,
              height: AppSize.sH20,
            ),
          ),
        ],
      ],
    )
        .paddingSymmetric(vertical: AppPadding.pH12)
        .onClick(onTap: menuItem.onTap);
  }
}

class _SwitchNotifyWidget extends StatefulWidget {
  const _SwitchNotifyWidget();

  @override
  State<_SwitchNotifyWidget> createState() => _SwitchNotifyWidgetState();
}

class _SwitchNotifyWidgetState extends State<_SwitchNotifyWidget> {
  final ValueNotifier<bool> switchNotifier = ValueNotifier<bool>(
    UserCubit.instance.user.allowNotify,
  );

  @override
  void dispose() {
    switchNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotifiyCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<NotifiyCubit>();
          return ValueListenableBuilder(
            valueListenable: switchNotifier,
            builder: (context, value, child) {
              return BlocBuilder<NotifiyCubit, AsyncState<BaseModel?>>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: LoadingIndicator(color: AppColors.main),
                    );
                  } else {
                    return Switch(
                      value: value,
                      onChanged: (value) async {
                        switchNotifier.value = value;
                        await cubit.switchNotifiy(switchNotifier);
                      },
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
