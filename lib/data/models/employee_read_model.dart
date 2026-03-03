import 'package:json_annotation/json_annotation.dart';

part 'employee_read_model.g.dart';

@JsonSerializable()
class EmployeeReadModel {
  final String id;
  final String employeeId;
  final String firstName;
  final String lastName;
  final String workEmail;
  final String mobileNumber;
  final String departmentName;
  final Designation designation;
  final String employmentStatus; // Active|OnNotice|Terminated
  final String? profilePhotoUrl;

  EmployeeReadModel({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.workEmail,
    required this.mobileNumber,
    required this.departmentName,
    required this.designation,
    required this.employmentStatus,
    this.profilePhotoUrl,
  });

  factory EmployeeReadModel.fromJson(Map<String, dynamic> json) => _$EmployeeReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeReadModelToJson(this);

  String get fullName => '$firstName $lastName';
}

@JsonSerializable()
class Designation {
  final String name;

  Designation({required this.name});

  factory Designation.fromJson(Map<String, dynamic> json) => _$DesignationFromJson(json);
  Map<String, dynamic> toJson() => _$DesignationToJson(this);
}
