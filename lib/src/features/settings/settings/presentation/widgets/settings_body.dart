part of '../imports/view_imports.dart';

class _SettingsTabBody extends StatefulWidget {
  const _SettingsTabBody();

  @override
  State<_SettingsTabBody> createState() => _SettingsTabBodyState();
}

class _SettingsTabBodyState extends State<_SettingsTabBody> {
  late final SettingsScreenViewController _vc = SettingsScreenViewController();

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    final rows = SettingsRowSpec.items;
    return BlocProvider(
      create: (_) => injector<NotifiyCubit>(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppPadding.pH12.szH,
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardFill,
                borderRadius: BorderRadius.circular(AppCircular.r15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < rows.length; i++) ...[
                    if (i > 0) AppPadding.pH12.szH,
                    _SettingsRowDispatcher(spec: rows[i], vc: _vc),
                  ],
                ],
              ).paddingSymmetric(
                horizontal: AppPadding.pW20,
                vertical: AppPadding.pH20,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: AppPadding.pW20),
      ),
    );
  }
}

class _SettingsRowDispatcher extends StatelessWidget {
  const _SettingsRowDispatcher({
    required this.spec,
    required this.vc,
  });

  final SettingsRowSpec spec;
  final SettingsScreenViewController vc;

  @override
  Widget build(BuildContext context) {
    switch (spec.trailing) {
      case SettingsRowTrailing.chevron:
        return SettingsChevronRowWidget(
          title: spec.title,
          iconPath: spec.iconPath,
          onTap: () {
            switch (spec.chevronKind) {
              case SettingsChevronKind.editProfile:
                final u = UserCubit.instance.user;
                Go.to(
                  ProfileEditScreen(
                    initialProfile: ProfileEntity.fromUserModel(u),
                  ),
                );
              case SettingsChevronKind.changePhone:
                Go.to(const ChangePhoneScreen());
              case null:
                break;
            }
          },
        );
      case SettingsRowTrailing.notificationsSwitch:
        return SettingsNotificationRowWidget(
          title: spec.title,
          iconPath: spec.iconPath,
        );
      case SettingsRowTrailing.darkModeSwitch:
        return SettingsBackgroundRowWidget(
          title: spec.title,
          iconPath: spec.iconPath,
          viewController: vc,
        );
    }
  }
}
