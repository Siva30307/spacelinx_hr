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
