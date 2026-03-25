part of '../imports/view_imports.dart';

class _BillsSearchFieldController {
  _BillsSearchFieldController(this._onQuery) {
    _subscription = _subject
        .stream
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen(_onQuery);
    textController.addListener(_onTextChanged);
  }

  final TextEditingController textController = TextEditingController();
  final PublishSubject<String> _subject = PublishSubject<String>();
  late final StreamSubscription<String> _subscription;
  final void Function(String) _onQuery;

  void _onTextChanged() {
    _subject.add(textController.text);
  }

  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    _subscription.cancel();
    _subject.close();
  }
}

class _BillsSearchField extends StatefulWidget {
  const _BillsSearchField();

  @override
  State<_BillsSearchField> createState() => _BillsSearchFieldState();
}

class _BillsSearchFieldState extends State<_BillsSearchField> {
  late final _BillsSearchFieldController _vc;

  @override
  void initState() {
    super.initState();
    _vc = _BillsSearchFieldController(
      (q) {
        if (!mounted) return;
        context.read<BillsCubit>().setSearchQuery(q);
      },
    );
  }

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      controller: _vc.textController,
      title: LocaleKeys.billsSearchHint.tr(),
      inputType: TextInputType.text,
      action: TextInputAction.search,
      fillColor: AppColors.cardFill,
      borderColor: AppColors.border,
      borderRadius: BorderRadius.circular(AppCircular.r12),
      prefixIcon: Padding(
        padding: EdgeInsetsDirectional.only(
          start: AppPadding.pW12,
          end: AppPadding.pW8,
        ),
        child: IconWidget(
          icon: AppAssets.svg.baseSvg.search.path,
          height: AppSize.sH20,
          width: AppSize.sW20,
          color: AppColors.hintText,
        ),
      ),
      style: const TextStyle().setPrimaryColor.s12.regular,
      onChanged: (_) {},
    );
  }
}
