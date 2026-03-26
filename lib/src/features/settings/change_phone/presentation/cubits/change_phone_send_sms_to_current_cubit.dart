part of '../imports/view_imports.dart';

@injectable
class ChangePhoneSendSmsToCurrentCubit extends AsyncCubit<BaseModel?> {
  ChangePhoneSendSmsToCurrentCubit() : super(null);

  Future<void> sendSmsToCurrentPhone() async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.changePhoneSendSmsToCurrentPhone,
          httpRequestType: HttpRequestType.post,
          body: <String, dynamic>{},
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
    );
  }
}
