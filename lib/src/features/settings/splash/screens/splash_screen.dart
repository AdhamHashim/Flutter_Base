part of '../imports/view_imports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(),
      child: _SplashView(),
    );
  }
}

class _SplashView extends StatefulWidget {
  @override
  State<_SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<_SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.read<SplashCubit>().initApp(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppAssets.svg.onboarding1.image(
        width: context.width,
        height: context.height,
        fit: BoxFit.fill,
        // controller: _controller,
        // onLoaded: (composition) {
        //   if (mounted) {
        //     _controller
        //       ..duration = composition.duration
        //       ..forward();
        //   }
        // },
      ),
    );
  }
}
