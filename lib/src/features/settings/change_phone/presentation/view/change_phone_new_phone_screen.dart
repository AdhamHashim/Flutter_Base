part of '../imports/view_imports.dart';

class ChangePhoneNewPhoneScreen extends StatelessWidget {
  const ChangePhoneNewPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<ChangePhoneSendSmsToNewCubit>(),
      child: DefaultScaffold(
        title: LocaleKeys.changePhoneNewScreenTitle,
        body: const _ChangePhoneNewPhoneBody(),
      ),
    );
  }
}
