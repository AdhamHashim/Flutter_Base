part of '../imports/contact_us_imports.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ContactUsCubit>(),
      child: DefaultScaffold(
        title: LocaleKeys.contactUsSupportTitle,
        body: const _ContactUsBody(),
      ),
    );
  }
}
