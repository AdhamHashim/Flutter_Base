import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';

enum SettingsRowTrailing { chevron, notificationsSwitch, darkModeSwitch }

/// Identifies chevron rows for navigation (avoid comparing translated titles).
enum SettingsChevronKind { editProfile, changePhone }

/// Static rows for the general settings screen (Figma: الإعدادات العامة).
class SettingsRowSpec {
  final String title;
  final String iconPath;
  final SettingsRowTrailing trailing;
  final SettingsChevronKind? chevronKind;

  const SettingsRowSpec({
    required this.title,
    required this.iconPath,
    required this.trailing,
    this.chevronKind,
  });

  static List<SettingsRowSpec> get items => [
        SettingsRowSpec(
          title: LocaleKeys.settingsEditProfile,
          iconPath: AppAssets.svg.baseSvg.profile.path,
          trailing: SettingsRowTrailing.chevron,
          chevronKind: SettingsChevronKind.editProfile,
        ),
        SettingsRowSpec(
          title: LocaleKeys.changePhone,
          iconPath: AppAssets.svg.baseSvg.changeEmail.path,
          trailing: SettingsRowTrailing.chevron,
          chevronKind: SettingsChevronKind.changePhone,
        ),
        SettingsRowSpec(
          title: LocaleKeys.settingsNotifications,
          iconPath: AppAssets.svg.baseSvg.notify.path,
          trailing: SettingsRowTrailing.notificationsSwitch,
        ),
        SettingsRowSpec(
          title: LocaleKeys.settingsBackground,
          iconPath: AppAssets.svg.wzeinIcons.file.path,
          trailing: SettingsRowTrailing.darkModeSwitch,
        ),
      ];
}
