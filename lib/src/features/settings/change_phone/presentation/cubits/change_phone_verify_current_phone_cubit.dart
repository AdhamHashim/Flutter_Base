part of '../imports/view_imports.dart';

@injectable
class ChangePhoneVerifyCurrentPhoneCubit extends AsyncCubit<BaseModel?> {
  ChangePhoneVerifyCurrentPhoneCubit() : super(null);

  Future<void> verify(String code) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.changePhoneVerifyCurrentPhoneCode,
          httpRequestType: HttpRequestType.post,
          body: <String, dynamic>{'code': code},
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
    );
  }
}
