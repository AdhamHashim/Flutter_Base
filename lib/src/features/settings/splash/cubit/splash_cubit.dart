part of '../imports/view_imports.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial());

  void initApp() async {
    Helpers.changeStatusbarColor(
      statusBarColor: AppColors.main.withAlpha(50),
    );
    _notificationNavigator();
    await injector<NotificationService>().setupNotifications();
    Future.delayed(const Duration(milliseconds: ConstantManager.splashTimer),
        () async {
      if (!Go.context.mounted) return;
      await Go.context.read<UserCubit>().init();
      // Go.offAll(const HomeScreen());
    });
  }

  NotificationNavigator _notificationNavigator() {
    return NotificationNavigator(
      onRoutingMessage: (message) {
        NotificationRoutes.navigateByType(message.data);
      },
      onNoInitialMessage: () {
        // Go.offAll(const NotificationScreen());
      },
    );
  }
}
