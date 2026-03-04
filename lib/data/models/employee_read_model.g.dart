// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_read_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeReadModel _$EmployeeReadModelFromJson(Map<String, dynamic> json) =>
    EmployeeReadModel(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      workEmail: json['workEmail'] as String,
      mobileNumber: json['mobileNumber'] as String,
      departmentName: json['departmentName'] as String,
      designation: Designation.fromJson(
        json['designation'] as Map<String, dynamic>,
      ),
      employmentStatus: json['employmentStatus'] as String,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
    );

Map<String, dynamic> _$EmployeeReadModelToJson(EmployeeReadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'workEmail': instance.workEmail,
      'mobileNumber': instance.mobileNumber,
      'departmentName': instance.departmentName,
      'designation': instance.designation,
      'employmentStatus': instance.employmentStatus,
      'profilePhotoUrl': instance.profilePhotoUrl,
    };

Designation _$DesignationFromJson(Map<String, dynamic> json) =>
    Designation(name: json['name'] as String);

Map<String, dynamic> _$DesignationToJson(Designation instance) =>
    <String, dynamic>{'name': instance.name};

EmployeeRefModel _$EmployeeRefModelFromJson(Map<String, dynamic> json) =>
    EmployeeRefModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      displayName: json['displayName'] as String?,
    );

Map<String, dynamic> _$EmployeeRefModelToJson(EmployeeRefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'displayName': instance.displayName,
    };
