part of '../imports/profile_view_imports.dart';

class ProfileAccountScreen extends StatelessWidget {
  const ProfileAccountScreen({super.key, this.profile});

  final ProfileEntity? profile;

  @override
  Widget build(BuildContext context) {
    context.locale;
    final data = profile ?? ProfileEntity.uiMock;
    return DefaultScaffold(
      title: LocaleKeys.moreAccountData,
      trailing: Text(
        LocaleKeys.edit,
        style: const TextStyle().setMainTextColor.s13.semiBold,
      ).onClick(
        onTap: () => Go.to(ProfileEditScreen(initialProfile: data)),
      ),
      body: _ProfileAccountBody(profile: data),
    );
  }
}
