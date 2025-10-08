part of '../imports/view_imports.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial());

  void initApp(BuildContext context) async {
    _notificationNavigator();
    await injector<NotificationService>().setupNotifications();
    if (!context.mounted) return;
    await context.read<UserCubit>().init();
    Go.offAll(const IntroScreen());
  }
}

NotificationNavigator _notificationNavigator() {
  return NotificationNavigator(
    onNoInitialMessage: () {},
    onRoutingMessage: (message) =>
        NotificationRoutes.navigateByType(message.data),
  );
}
