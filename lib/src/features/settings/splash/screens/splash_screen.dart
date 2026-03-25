part of '../imports/view_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<BaseUrlCubit>()),
        BlocProvider(create: (_) => injector<SplashCubit>()),
      ],
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatefulWidget {
  const _SplashView();

  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView> {
  @override
  void initState() {
    super.initState();
    Helpers.changeStatusbarColor(
      statusBarColor: AppColors.forth,
      statusBarIconBrightness: Brightness.light,
    );
    context.read<SplashCubit>().initApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.forth,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppAssets.svg.appSvg.appLogo.image(
                width: context.width * .35,
                height: context.height * .18,
                // color: AppColors.white,
              ),
              AppSize.sH22.szH,
              Text(
                LocaleKeys.splashAppNameLatin,
                style:
                    const TextStyle().setWhiteColor.s20.semiBold.setFontFamily,
              ),
              AppSize.sH10.szH,
              Text(
                LocaleKeys.splashAppNameAr,
                style: const TextStyle().setWhiteColor.s16.medium.setFontFamily,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
