// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkLocationRefModel _$WorkLocationRefModelFromJson(
  Map<String, dynamic> json,
) => WorkLocationRefModel(
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$WorkLocationRefModelToJson(
  WorkLocationRefModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

DepartmentRefModel _$DepartmentRefModelFromJson(Map<String, dynamic> json) =>
    DepartmentRefModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$DepartmentRefModelToJson(DepartmentRefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };

GradeRefModel _$GradeRefModelFromJson(Map<String, dynamic> json) =>
    GradeRefModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$GradeRefModelToJson(GradeRefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };

DesignationRefModel _$DesignationRefModelFromJson(Map<String, dynamic> json) =>
    DesignationRefModel(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$DesignationRefModelToJson(
  DesignationRefModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

CostCenterRefModel _$CostCenterRefModelFromJson(Map<String, dynamic> json) =>
    CostCenterRefModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CostCenterRefModelToJson(CostCenterRefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };
