// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_read_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeReadModel _$EmployeeReadModelFromJson(Map<String, dynamic> json) =>
    EmployeeReadModel(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String,
      displayName: json['displayName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      nationality: json['nationality'] as String?,
      religion: json['religion'] as String?,
      fatherName: json['fatherName'] as String?,
      spouseName: json['spouseName'] as String?,
      panNumber: json['panNumber'] as String?,
      aadhaarNumber: json['aadhaarNumber'] as String?,
      passportNumber: json['passportNumber'] as String?,
      passportExpiry: json['passportExpiry'] as String?,
      voterId: json['voterId'] as String?,
      drivingLicense: json['drivingLicense'] as String?,
      dlExpiry: json['dlExpiry'] as String?,
      uanNumber: json['uanNumber'] as String?,
      esiNumber: json['esiNumber'] as String?,
      personalEmail: json['personalEmail'] as String?,
      workEmail: json['workEmail'] as String,
      mobileNumber: json['mobileNumber'] as String,
      alternatePhone: json['alternatePhone'] as String?,
      departmentId: json['departmentId'] as String?,
      departmentName: json['departmentName'] as String?,
      designationId: json['designationId'] as String?,
      designation: json['designation'] == null
          ? null
          : Designation.fromJson(json['designation'] as Map<String, dynamic>),
      gradeId: json['gradeId'] as String?,
      workLocationId: json['workLocationId'] as String?,
      costCenterId: json['costCenterId'] as String?,
      reportingManagerId: json['reportingManagerId'] as String?,
      reportingManager: json['reportingManager'] == null
          ? null
          : EmployeeRefModel.fromJson(
              json['reportingManager'] as Map<String, dynamic>,
            ),
      dateOfJoining: json['dateOfJoining'] as String?,
      dateOfConfirmation: json['dateOfConfirmation'] as String?,
      probationEndDate: json['probationEndDate'] as String?,
      noticePeriodDays: (json['noticePeriodDays'] as num?)?.toInt() ?? 0,
      employmentType: json['employmentType'] as String?,
      employmentStatus: json['employmentStatus'] as String? ?? 'Active',
      lastWorkingDate: json['lastWorkingDate'] as String?,
      separationDate: json['separationDate'] as String?,
      separationReason: json['separationReason'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
    );

Map<String, dynamic> _$EmployeeReadModelToJson(EmployeeReadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'displayName': instance.displayName,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'bloodGroup': instance.bloodGroup,
      'maritalStatus': instance.maritalStatus,
      'nationality': instance.nationality,
      'religion': instance.religion,
      'fatherName': instance.fatherName,
      'spouseName': instance.spouseName,
      'panNumber': instance.panNumber,
      'aadhaarNumber': instance.aadhaarNumber,
      'passportNumber': instance.passportNumber,
      'passportExpiry': instance.passportExpiry,
      'voterId': instance.voterId,
      'drivingLicense': instance.drivingLicense,
      'dlExpiry': instance.dlExpiry,
      'uanNumber': instance.uanNumber,
      'esiNumber': instance.esiNumber,
      'personalEmail': instance.personalEmail,
      'workEmail': instance.workEmail,
      'mobileNumber': instance.mobileNumber,
      'alternatePhone': instance.alternatePhone,
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'designationId': instance.designationId,
      'designation': instance.designation,
      'gradeId': instance.gradeId,
      'workLocationId': instance.workLocationId,
      'costCenterId': instance.costCenterId,
      'reportingManagerId': instance.reportingManagerId,
      'reportingManager': instance.reportingManager,
      'dateOfJoining': instance.dateOfJoining,
      'dateOfConfirmation': instance.dateOfConfirmation,
      'probationEndDate': instance.probationEndDate,
      'noticePeriodDays': instance.noticePeriodDays,
      'employmentType': instance.employmentType,
      'employmentStatus': instance.employmentStatus,
      'lastWorkingDate': instance.lastWorkingDate,
      'separationDate': instance.separationDate,
      'separationReason': instance.separationReason,
      'profilePhotoUrl': instance.profilePhotoUrl,
    };

Designation _$DesignationFromJson(Map<String, dynamic> json) =>
    Designation(name: json['name'] as String);

Map<String, dynamic> _$DesignationToJson(Designation instance) =>
    <String, dynamic>{'name': instance.name};

EmployeeRefModel _$EmployeeRefModelFromJson(Map<String, dynamic> json) =>
    EmployeeRefModel(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      displayName: json['displayName'] as String?,
    );

Map<String, dynamic> _$EmployeeRefModelToJson(EmployeeRefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'displayName': instance.displayName,
    };

OnboardingTemplateReadModel _$OnboardingTemplateReadModelFromJson(
  Map<String, dynamic> json,
) => OnboardingTemplateReadModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  departmentId: json['departmentId'] as String?,
  departmentName: json['departmentName'] as String?,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$OnboardingTemplateReadModelToJson(
  OnboardingTemplateReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'departmentId': instance.departmentId,
  'departmentName': instance.departmentName,
  'isActive': instance.isActive,
};

OnboardingTaskReadModel _$OnboardingTaskReadModelFromJson(
  Map<String, dynamic> json,
) => OnboardingTaskReadModel(
  id: json['id'] as String,
  templateId: json['templateId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  assignedToRole: json['assignedToRole'] as String?,
  dueDaysAfterJoining: (json['dueDaysAfterJoining'] as num?)?.toInt() ?? 0,
  isMandatory: json['isMandatory'] as bool? ?? false,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$OnboardingTaskReadModelToJson(
  OnboardingTaskReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'templateId': instance.templateId,
  'title': instance.title,
  'description': instance.description,
  'assignedToRole': instance.assignedToRole,
  'dueDaysAfterJoining': instance.dueDaysAfterJoining,
  'isMandatory': instance.isMandatory,
  'sortOrder': instance.sortOrder,
  'isActive': instance.isActive,
};

SeparationReadModel _$SeparationReadModelFromJson(Map<String, dynamic> json) =>
    SeparationReadModel(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      separationType: json['separationType'] as String,
      resignationDate: json['resignationDate'] as String?,
      lastWorkingDate: json['lastWorkingDate'] as String?,
      noticePeriodDays: (json['noticePeriodDays'] as num?)?.toInt(),
      noticeShortfallDays: (json['noticeShortfallDays'] as num?)?.toInt() ?? 0,
      noticePeriodServed: (json['noticePeriodServed'] as num?)?.toInt() ?? 0,
      exitInterviewDate: json['exitInterviewDate'] as String?,
      exitInterviewNotes: json['exitInterviewNotes'] as String?,
      fnfStatus: json['fnfStatus'] as String? ?? 'Pending',
      status: json['status'] as String? ?? 'Initiated',
      employee: json['employee'] == null
          ? null
          : EmployeeRefModel.fromJson(json['employee'] as Map<String, dynamic>),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$SeparationReadModelToJson(
  SeparationReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'employeeId': instance.employeeId,
  'separationType': instance.separationType,
  'resignationDate': instance.resignationDate,
  'lastWorkingDate': instance.lastWorkingDate,
  'noticePeriodDays': instance.noticePeriodDays,
  'noticeShortfallDays': instance.noticeShortfallDays,
  'noticePeriodServed': instance.noticePeriodServed,
  'exitInterviewDate': instance.exitInterviewDate,
  'exitInterviewNotes': instance.exitInterviewNotes,
  'fnfStatus': instance.fnfStatus,
  'status': instance.status,
  'employee': instance.employee,
  'isActive': instance.isActive,
};
