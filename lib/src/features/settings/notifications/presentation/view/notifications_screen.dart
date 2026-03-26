part of '../imports/view_imports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<NotificationsCubit>()..fetchInitialData(),
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (_) => DeleteNotificationCubit(
              context.read<NotificationsCubit>(),
            ),
            child: DefaultScaffold(
              title: LocaleKeys.notificationsTitle,
              body: const _NotificationBody(),
            ),
          );
        },
      ),
    );
  }
}
