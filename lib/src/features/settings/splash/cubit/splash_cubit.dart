part of '../imports/view_imports.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial());

  void initApp(BuildContext context) async {
    final baseUrlCubit = context.read<BaseUrlCubit>();
    final result = await baseUrlCubit.fetchBaseUrl();
    if (result) {
      // Inject BaseUrl To Dio Service after Fetching it form FireBase DataBase
      await injector<NetworkService>().updateBaseUrl();
      if (!context.mounted) return;
      await initUserData(context);
    }
  }
}

Future<void> initUserData(BuildContext context) async {
  Future.delayed(
    const Duration(milliseconds: ConstantManager.splashTimer),
  ).then((value) async {
    final result = await UserCubit.instance.init();
    await setUpNotifications();
    if (result) {
    } else {}
  });
}

Future<void> setUpNotifications() async {
  _notificationNavigator();
  await injector<NotificationService>().setupNotifications();
}

NotificationNavigator _notificationNavigator() {
  return NotificationNavigator(
    onNoInitialMessage: () {},
    onRoutingMessage: (message) =>
        NotificationRoutes.navigateByType(message.data),
  );
}
