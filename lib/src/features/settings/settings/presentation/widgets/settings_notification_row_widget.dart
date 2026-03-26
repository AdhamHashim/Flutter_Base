part of '../imports/view_imports.dart';

class SettingsNotificationRowWidget extends StatefulWidget {
  const SettingsNotificationRowWidget({
    super.key,
    required this.title,
    required this.iconPath,
  });

  final String title;
  final String iconPath;

  @override
  State<SettingsNotificationRowWidget> createState() =>
      _SettingsNotificationRowWidgetState();
}

class _SettingsNotificationRowWidgetState
    extends State<SettingsNotificationRowWidget> {
  late final _SettingsNotificationsViewController _vc =
      _SettingsNotificationsViewController();

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SettingsLeadingIcon(iconPath: widget.iconPath),
        AppMargin.mW12.szW,
        Expanded(
          child: Text(
            widget.title,
            textAlign: TextAlign.start,
            style: const TextStyle().setSecondryColor.s14.medium,
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _vc.enabled,
          builder: (context, value, _) {
            return BlocBuilder<NotifiyCubit, AsyncState<BaseModel?>>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: LoadingIndicator(color: AppColors.main),
                  );
                }
                return Switch(
                  value: value,
                  onChanged: (v) async {
                    _vc.enabled.value = v;
                    await context.read<NotifiyCubit>().switchNotifiy(_vc.enabled);
                  },
                  activeTrackColor: AppColors.success,
                  activeColor: AppColors.white,
                );
              },
            );
          },
        ),
      ],
    ).paddingSymmetric(vertical: AppPadding.pH12);
  }
}

class _SettingsNotificationsViewController {
  _SettingsNotificationsViewController() {
    enabled.value = UserCubit.instance.user.allowNotify;
  }

  final ValueNotifier<bool> enabled = ValueNotifier<bool>(false);

  void dispose() {
    enabled.dispose();
  }
}
