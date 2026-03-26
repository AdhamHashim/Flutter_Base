part of '../imports/profile_view_imports.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key, required this.initialProfile});

  final ProfileEntity initialProfile;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> with FormMixin {
  late final ProfileEditViewController _vc =
      ProfileEditViewController(initial: widget.initialProfile);

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return DefaultScaffold(
      title: LocaleKeys.settingsEditProfile,
      body: _ProfileEditBody(
        formKey: formKey,
        vc: _vc,
      ),
    );
  }
}
