import '../../../../core/shared/models/user_model.dart';

class ProfileEntity {
  final String phone;
  final String username;
  final String genderKey;
  final String nickname;

  const ProfileEntity({
    required this.phone,
    required this.username,
    required this.genderKey,
    required this.nickname,
  });

  static const ProfileEntity uiMock = ProfileEntity(
    phone: '05xxxxxxxx',
    username: 'فهد الشهري',
    genderKey: 'male',
    nickname: 'أبو محمد',
  );

  factory ProfileEntity.initial() => const ProfileEntity(
        phone: '',
        username: '',
        genderKey: 'male',
        nickname: '',
      );

  factory ProfileEntity.fromUserModel(UserModel user) => ProfileEntity(
        phone: user.phoneNumber,
        username: user.fullName,
        genderKey: 'male',
        nickname: '',
      );

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
        phone: json['phone']?.toString() ?? '',
        username: json['username']?.toString() ?? '',
        genderKey: json['gender']?.toString() ?? 'male',
        nickname: json['nickname']?.toString() ?? '',
      );
}
