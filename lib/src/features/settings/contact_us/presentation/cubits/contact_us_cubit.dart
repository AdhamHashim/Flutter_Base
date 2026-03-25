part of '../imports/contact_us_imports.dart';

@injectable
class ContactUsCubit extends AsyncCubit<BaseModel?> {
  ContactUsCubit() : super(null);

  Future<void> contactUs(ContactUsViewController vc) async {
    if (!vc.validateAndScroll()) return;
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.contactUs,
          body: vc.toJson(),
          httpRequestType: HttpRequestType.post,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (_) {
        Go.back();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showContactUsSuccessBottomSheet();
        });
      },
    );
  }
}
