part of 'imports/contact_us_imports.dart';

class ContactUsViewController with FormMixin {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController requestTypeController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final ValueNotifier<String?> attachmentName = ValueNotifier<String?>(null);

  String composeHelpText() {
    final type = requestTypeController.text.trim();
    final details = detailsController.text.trim();
    final name = attachmentName.value;
    final buf = StringBuffer();
    if (type.isNotEmpty) {
      buf.writeln(type);
    }
    if (details.isNotEmpty) {
      if (buf.isNotEmpty) buf.writeln();
      buf.write(details);
    }
    if (name != null && name.isNotEmpty) {
      if (buf.isNotEmpty) buf.writeln();
      buf.write('[file: $name]');
    }
    return buf.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'text': composeHelpText(),
      if (UserCubit.instance.isUserLoggedIn) ...{
        'name': UserCubit.instance.user.fullName,
        'phone': UserCubit.instance.user.phoneNumber,
      } else ...{
        'name': fullNameController.text.trim(),
        'phone': phoneController.text.toEnglishNumbers().trim(),
      },
    };
  }

  Future<void> pickAttachment(BuildContext context) async {
    final file = await ImageHelper.getMedia();
    if (file == null) return;
    final length = await file.length();
    if (length > 5 * 1024 * 1024) {
      if (!context.mounted) return;
      MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: LocaleKeys.contactUsAttachmentTooLarge,
      );
      return;
    }
    attachmentName.value = file.path.split(Platform.pathSeparator).last;
  }

  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    requestTypeController.dispose();
    detailsController.dispose();
    attachmentName.dispose();
  }
}
