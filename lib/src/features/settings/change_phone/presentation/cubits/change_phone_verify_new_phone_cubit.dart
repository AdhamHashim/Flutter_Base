part of '../imports/view_imports.dart';

@injectable
class ChangePhoneVerifyNewPhoneCubit extends AsyncCubit<UserModel> {
  ChangePhoneVerifyNewPhoneCubit() : super(UserModel.initial());

  Future<void> verify(ChangePhoneVerifyNewBody body) async {
    final previous = UserCubit.instance.user;
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.changePhoneVerifyNewPhoneCode,
          httpRequestType: HttpRequestType.post,
          body: body.toJson(),
          mapper: (json) {
            final data = json['data'];
            if (data is Map<String, dynamic>) {
              final phoneRaw =
                  data['phoneNumber']?.toString() ?? data['phone']?.toString();
              if (phoneRaw != null && phoneRaw.isNotEmpty) {
                return previous.copyWith(phoneNumber: phoneRaw);
              }
            }
            final fallback = '${body.countryCode}${body.phone}';
            return previous.copyWith(phoneNumber: fallback);
          },
        ),
      ),
    );
  }
}
