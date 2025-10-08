part of '../imports/view_imports.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _IntroView();
  }
}

class _IntroView extends StatelessWidget {
  const _IntroView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: _IntroBody()));
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
            title: LocaleKeys.intro_welcome.tr(),
            subtitle: LocaleKeys.intro_platformInfo.tr(),
            backGroundImagePath: AppAssets.svg.onboarding1.path,
            pointerImagePath: AppAssets.svg.carousel1Png.path,
          ),
        ),
        IntroSectionWidget(
          introDto: IntroDto(
            title: LocaleKeys.intro_explore.tr(),
            subtitle: LocaleKeys.intro_browse.tr(),
            backGroundImagePath: AppAssets.svg.onboarding2.path,
            pointerImagePath: AppAssets.svg.carousel2Png.path,
          ),
        ),
        IntroSectionWidget(
          introDto: IntroDto(
            title: LocaleKeys.intro_firstStep.tr(),
            subtitle: LocaleKeys.intro_overview.tr(),
            backGroundImagePath: AppAssets.svg.onboarding3.path,
            pointerImagePath: AppAssets.svg.carousel3Png.path,
          ),
        ),
      ],
    );
  }
}
