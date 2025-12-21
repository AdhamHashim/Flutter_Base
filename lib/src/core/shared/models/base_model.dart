class BaseModel<T> {
  final String message;
  final T data;

  BaseModel({required this.message, required this.data});

  factory BaseModel.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic json)? jsonToModel,
  }) {
    return BaseModel(
      message: json['msg'] ?? '',
      data: jsonToModel != null
          ? json['data'] == null
                ? jsonToModel({'msg': json['msg'] ?? json['message'] ?? ""})
                : jsonToModel(json['data'])
          : json['key'] ?? json['msg'] ?? '',
    );
  }
}
