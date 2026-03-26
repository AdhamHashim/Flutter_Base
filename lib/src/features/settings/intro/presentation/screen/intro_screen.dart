part of '../imports/view_imports.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _IntroView();
  }
}

class _IntroView extends StatefulWidget {
  const _IntroView();

  @override
  State<_IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<_IntroView> {
  @override
  void initState() {
    super.initState();
    Helpers.changeStatusbarColor(
      statusBarColor: AppColors.black,
      statusBarIconBrightness: Brightness.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: AppColors.black, body: _IntroBody());
  }
}

class _IntroBody extends StatelessWidget {
  const _IntroBody();

  @override
  Widget build(BuildContext context) {
    return IntroCarouselWidget(
      children: [
        IntroSectionWidget(
          introDto: IntroDto(
            title: LocaleKeys.introWelcome,
            subimagePath: AppAssets.svg.appSvg.logo.path,
            subtitle: LocaleKeys.introPlatforminfo,
            backGroundImagePath: AppAssets.images.intro.onboardingSlide1Bg.path,
            pointerImagePath: null,
            phoneOverlay: IntroPhoneOverlay(
              imagePath: AppAssets.images.intro.onboardingSlide1Phone.path,
              insetTop: 0.0845,
              insetEnd: 0.2213,
              insetBottom: 0.338,
              insetStart: 0.2196,
            ),
          ),
        ),
        IntroSectionWidget(
          introDto: IntroDto(
            subimagePath: AppAssets.svg.wzeinIcons.group1219826119.path,

            title: LocaleKeys.introBudgetGoals,
            subtitle: LocaleKeys.introPlatforminfo,
            backGroundImagePath: AppAssets.images.intro.onboardingSlide2Bg.path,
            pointerImagePath: null,
            phoneOverlay: IntroPhoneOverlay(
              imagePath: AppAssets.images.intro.onboardingSlide2Phone.path,
              insetTop: 0.0845,
              insetEnd: 0.2747,
              insetBottom: 0.338,
              insetStart: 0.1661,
            ),
          ),
        ),
        IntroSectionWidget(
          introDto: IntroDto(
            subimagePath: AppAssets.svg.wzeinIcons.icon3.path,

            title: LocaleKeys.introBillsGuarantees,
            subtitle: LocaleKeys.introPlatforminfo,
            backGroundImagePath: AppAssets.images.intro.onboardingSlide3Bg.path,
            pointerImagePath: null,
            phoneOverlay: IntroPhoneOverlay(
              imagePath: AppAssets.images.intro.onboardingSlide3Phone.path,
              insetTop: 0.0845,
              insetEnd: 0.2213,
              insetBottom: 0.338,
              insetStart: 0.2196,
            ),
          ),
        ),
      ],
    );
  }
}
