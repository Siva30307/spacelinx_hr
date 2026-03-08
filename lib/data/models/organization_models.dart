import 'package:json_annotation/json_annotation.dart';

part 'organization_models.g.dart';

@JsonSerializable()
class WorkLocationRefModel {
  final String id;
  final String name;

  WorkLocationRefModel({
    required this.id,
    required this.name,
  });

  factory WorkLocationRefModel.fromJson(Map<String, dynamic> json) => _$WorkLocationRefModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkLocationRefModelToJson(this);
}

@JsonSerializable()
class DepartmentRefModel {
  final String id;
  final String code;
  final String name;

  DepartmentRefModel({
    required this.id,
    required this.code,
    required this.name,
  });

  factory DepartmentRefModel.fromJson(Map<String, dynamic> json) => _$DepartmentRefModelFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentRefModelToJson(this);
}

@JsonSerializable()
class GradeRefModel {
  final String id;
  final String code;
  final String name;

  GradeRefModel({
    required this.id,
    required this.code,
    required this.name,
  });

  factory GradeRefModel.fromJson(Map<String, dynamic> json) => _$GradeRefModelFromJson(json);
  Map<String, dynamic> toJson() => _$GradeRefModelToJson(this);
}

@JsonSerializable()
class DesignationRefModel {
  final String id;
  final String name;

  DesignationRefModel({
    required this.id,
    required this.name,
  });

  factory DesignationRefModel.fromJson(Map<String, dynamic> json) => _$DesignationRefModelFromJson(json);
  Map<String, dynamic> toJson() => _$DesignationRefModelToJson(this);
}

@JsonSerializable()
class CostCenterRefModel {
  final String id;
  final String code;
  final String name;

  CostCenterRefModel({
    required this.id,
    required this.code,
    required this.name,
  });

  factory CostCenterRefModel.fromJson(Map<String, dynamic> json) => _$CostCenterRefModelFromJson(json);
  Map<String, dynamic> toJson() => _$CostCenterRefModelToJson(this);
}
