part of '../imports/view_imports.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: LocaleKeys.subscriptionsScreenTitle,
      body: const _SubscriptionsBody(),
    );
  }
}
