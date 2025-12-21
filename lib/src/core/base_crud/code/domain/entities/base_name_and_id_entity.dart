// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../base_domain_imports.dart';

String getBaseIdAndNameEntityApi<T extends BaseEntity>(
  GetBaseEntityParams? params,
) {
  final Map<Type, String Function(GetBaseEntityParams?)> apiPaths = {
    CountryEntity: (_) => 'countries',
  };
  if (T == BaseEntity) {
    throw UnsupportedError(
      'Cannot call API for the base class BaseIdAndNameEntity. Use a concrete subclass instead.',
    );
  }

  final pathBuilder = apiPaths[T];
  if (pathBuilder == null) {
    log('Type passed: $T'); // Debugging output
    throw UnsupportedError(
      'API path for type $T is not defined in apiPaths map.',
    );
  }
  return pathBuilder(params);
}

T baseIdAndNameEntityFromJson<T>(Map<String, dynamic> json) {
  if (T == CountryEntity) {
    return CountryEntity.fromJson(json) as T;
  }
  log('Type passed: $T'); // Debugging output
  throw UnsupportedError(
    'Type $T is not supported plaese add from json function',
  );
}

class BaseEntity extends Equatable {
  final int id;

  const BaseEntity({required this.id});

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toJson() => {'id': id};

  BaseEntity copyWith({int? id}) {
    return BaseEntity(id: id ?? this.id);
  }

  factory BaseEntity.fromJson(Map<String, dynamic> json) =>
      BaseEntity(id: json['id']);
}

class BaseIdAndNameEntity extends BaseEntity {
  final String name;

  const BaseIdAndNameEntity({required super.id, required this.name});
  @override
  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BaseIdAndNameEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
  @override
  List<Object> get props => [id, name];
}
