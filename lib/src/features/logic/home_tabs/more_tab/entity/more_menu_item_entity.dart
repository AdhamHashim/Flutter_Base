import 'package:flutter/material.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/shared/cubits/user_cubit/user_cubit.dart';
import '../../../../settings/contact_us/presentation/imports/contact_us_imports.dart';
import '../../../../settings/profile/presentation/imports/profile_view_imports.dart';
import '../../../../settings/profile/entity/profile_entity.dart';
import '../../../../settings/settings/presentation/imports/view_imports.dart';
import '../../../../settings/static_pages/entity/static_pages_enum.dart';
import '../../../../settings/static_pages/presentation/imports/view_imports.dart';
class MoreItemEntity {
  MoreItemEntity({
    required this.title,
    required this.icon,
    required this.onTap,
    this.disableArrow = false,
    this.useSwitch = false,
  });

  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool disableArrow;
  final bool useSwitch;

  static List<MoreItemEntity> get accountItems => [
        MoreItemEntity(
          title: LocaleKeys.moreAccountData,
          icon: AppAssets.svg.wzeinIcons.div28.path,
          onTap: () {
            final u = UserCubit.instance.user;
            Go.to(
              ProfileAccountScreen(
                profile: ProfileEntity.fromUserModel(u),
              ),
            );
          },
        ),
        MoreItemEntity(
          title: LocaleKeys.moreGeneralSettings,
          icon: AppAssets.svg.wzeinIcons.circlePassword.path,
          onTap: () => Go.to(const SettingsScreen()),
        ),
      ];

  static List<MoreItemEntity> get appItems => [
        MoreItemEntity(
          title: LocaleKeys.moreBudgetGoalsSetup,
          icon: AppAssets.svg.wzeinIcons.button40.path,
          onTap: () {},
        ),
      ];

  static List<MoreItemEntity> get supportItems => [
        MoreItemEntity(
          title: LocaleKeys.moreTechnicalSupport,
          icon: AppAssets.svg.baseSvg.notify.path,
          onTap: () => Go.to(const ContactUsScreen()),
        ),
        MoreItemEntity(
          title: LocaleKeys.terms,
          icon: AppAssets.svg.wzeinIcons.file.path,
          onTap: () => Go.to(
            const StaticPagesScreen(
              pageType: StaticPageTypeEnum.termsAndConditions,
            ),
          ),
        ),
        MoreItemEntity(
          title: LocaleKeys.whoUs,
          icon: AppAssets.svg.wzeinIcons.div2842.path,
          onTap: () => Go.to(
            const StaticPagesScreen(pageType: StaticPageTypeEnum.aboutRita),
          ),
        ),
      ];

  static List<MoreItemEntity> get guestSupportItems => [
        MoreItemEntity(
          title: LocaleKeys.moreTechnicalSupport,
          icon: AppAssets.svg.baseSvg.notify.path,
          onTap: () => Go.to(const ContactUsScreen()),
        ),
        MoreItemEntity(
          title: LocaleKeys.terms,
          icon: AppAssets.svg.wzeinIcons.file.path,
          onTap: () => Go.to(
            const StaticPagesScreen(
              pageType: StaticPageTypeEnum.termsAndConditions,
            ),
          ),
        ),
        MoreItemEntity(
          title: LocaleKeys.whoUs,
          icon: AppAssets.svg.wzeinIcons.div2842.path,
          onTap: () => Go.to(
            const StaticPagesScreen(pageType: StaticPageTypeEnum.aboutRita),
          ),
        ),
      ];
}
