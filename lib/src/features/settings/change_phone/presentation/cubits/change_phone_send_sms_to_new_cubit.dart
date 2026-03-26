part of '../imports/view_imports.dart';

@injectable
class ChangePhoneSendSmsToNewCubit extends AsyncCubit<BaseModel?> {
  ChangePhoneSendSmsToNewCubit() : super(null);

  Future<void> sendSmsToNewPhone(ChangePhoneSmsBody body) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.changePhoneSendSmsToNewPhone,
          httpRequestType: HttpRequestType.post,
          body: body.toJson(),
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
    );
  }
}
