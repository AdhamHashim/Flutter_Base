part of 'imports/intro_imports.dart';

class IntroSectionWidget extends StatefulWidget {
  final IntroDto introDto;
  const IntroSectionWidget({super.key, required this.introDto});

  @override
  State<IntroSectionWidget> createState() => _IntroSectionWidgetState();
}

class _IntroSectionWidgetState extends State<IntroSectionWidget> {
  late Ticker _ticker;

  @override
  void initState() {
    _ticker = Ticker((d) {
      setState(() {});
    })..start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final time = DateTime.now().millisecondsSinceEpoch / 2000;
        final scaleX = 1.2 + sin(time) * .05;
        final scaleY = 1.2 + cos(time) * .07;
        final offsetY = 20 + cos(time) * 20;
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final overlay = widget.introDto.phoneOverlay;
        final radius = overlay == null
            ? 0.0
            : overlay.borderRadiusDesignPx * width / overlay.designFrameWidth;
        return Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Transform.translate(
              offset: Offset(
                -(scaleX - 1) / 2 * width,
                -(scaleY - 1) / 2 * height + offsetY,
              ),
              child: Transform(
                transform: Matrix4.diagonal3Values(scaleX, scaleY, 1),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      widget.introDto.backGroundImagePath,
                      fit: BoxFit.cover,
                    ),
                    if (overlay != null)
                      Positioned(
                        left: width * overlay.insetStart,
                        top: height * overlay.insetTop,
                        right: width * overlay.insetEnd,
                        bottom: height * overlay.insetBottom,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radius),
                          child: Image.asset(
                            overlay.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.black.withValues(alpha: 0.6),
                      AppColors.black.withValues(alpha: 0.3),
                      AppColors.black,
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.pW20,
                  vertical: AppPadding.pH20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.introDto.pointerImagePath != null) ...[
                      Image.asset(
                        widget.introDto.pointerImagePath!,
                        width: width * .35,
                        fit: BoxFit.contain,
                      ),
                      AppSize.sH16.szH,
                    ],
                    _ContentWidget(
                      title: widget.introDto.title,
                      subTitle: widget.introDto.subtitle,
                      subimagePath: widget.introDto.subimagePath,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ContentWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String subimagePath;
  const _ContentWidget({
    required this.title,
    required this.subTitle,
    required this.subimagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.pH60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (title.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle().setWhiteColor.s24.bold.setFontFamily,
                ),
                AppSize.sW8.szW,
                SvgPicture.asset(
                  subimagePath,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            AppSize.sH10.szH,
          ],
          if (subTitle.isNotEmpty) ...[
            Text(
              subTitle,
              textAlign: TextAlign.center,

              style: const TextStyle(
                height: 1.56,
              ).setWhiteColor.s16.regular.setFontFamily,
            ),
          ],
        ],
      ),
    );
  }
}
