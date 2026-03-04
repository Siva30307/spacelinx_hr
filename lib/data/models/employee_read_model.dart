import 'package:json_annotation/json_annotation.dart';

part 'employee_read_model.g.dart';

@JsonSerializable()
class EmployeeReadModel {
  final String id;
  final String employeeId;
  final String? userId;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? displayName;
  final String? dateOfBirth;
  final String? gender;
  final String? bloodGroup;
  final String? maritalStatus;
  final String? nationality;
  final String? religion;
  final String? fatherName;
  final String? spouseName;
  final String? panNumber;
  final String? aadhaarNumber;
  final String? passportNumber;
  final String? passportExpiry;
  final String? voterId;
  final String? drivingLicense;
  final String? dlExpiry;
  final String? uanNumber;
  final String? esiNumber;
  final String? personalEmail;
  final String workEmail;
  final String mobileNumber;
  final String? alternatePhone;
  final String? departmentId;
  final String? departmentName;
  final String? designationId;
  final Designation? designation;
  final String? gradeId;
  final String? workLocationId;
  final String? costCenterId;
  final String? reportingManagerId;
  final EmployeeRefModel? reportingManager;
  final String? dateOfJoining;
  final String? dateOfConfirmation;
  final String? probationEndDate;
  final int noticePeriodDays;
  final String? employmentType;
  final String employmentStatus;
  final String? lastWorkingDate;
  final String? separationDate;
  final String? separationReason;
  final String? profilePhotoUrl;

  EmployeeReadModel({
    required this.id,
    required this.employeeId,
    this.userId,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.displayName,
    this.dateOfBirth,
    this.gender,
    this.bloodGroup,
    this.maritalStatus,
    this.nationality,
    this.religion,
    this.fatherName,
    this.spouseName,
    this.panNumber,
    this.aadhaarNumber,
    this.passportNumber,
    this.passportExpiry,
    this.voterId,
    this.drivingLicense,
    this.dlExpiry,
    this.uanNumber,
    this.esiNumber,
    this.personalEmail,
    required this.workEmail,
    required this.mobileNumber,
    this.alternatePhone,
    this.departmentId,
    this.departmentName,
    this.designationId,
    this.designation,
    this.gradeId,
    this.workLocationId,
    this.costCenterId,
    this.reportingManagerId,
    this.reportingManager,
    this.dateOfJoining,
    this.dateOfConfirmation,
    this.probationEndDate,
    this.noticePeriodDays = 0,
    this.employmentType,
    this.employmentStatus = 'Active',
    this.lastWorkingDate,
    this.separationDate,
    this.separationReason,
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

@JsonSerializable()
class EmployeeRefModel {
  final String id;
  final String? employeeId;
  final String firstName;
  final String lastName;
  final String? displayName;

  EmployeeRefModel({
    required this.id,
    this.employeeId,
    required this.firstName,
    required this.lastName,
    this.displayName,
  });

  factory EmployeeRefModel.fromJson(Map<String, dynamic> json) => _$EmployeeRefModelFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeRefModelToJson(this);

  String get fullName => displayName ?? '$firstName $lastName';
}

// ── Onboarding Template ──
@JsonSerializable()
class OnboardingTemplateReadModel {
  final String id;
  final String name;
  final String? description;
  final String? departmentId;
  final String? departmentName;
  final bool isActive;

  OnboardingTemplateReadModel({
    required this.id,
    required this.name,
    this.description,
    this.departmentId,
    this.departmentName,
    this.isActive = true,
  });

  factory OnboardingTemplateReadModel.fromJson(Map<String, dynamic> json) => _$OnboardingTemplateReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$OnboardingTemplateReadModelToJson(this);
}

// ── Onboarding Task ──
@JsonSerializable()
class OnboardingTaskReadModel {
  final String id;
  final String templateId;
  final String title;
  final String? description;
  final String? assignedToRole;
  final int dueDaysAfterJoining;
  final bool isMandatory;
  final int sortOrder;
  final bool isActive;

  OnboardingTaskReadModel({
    required this.id,
    required this.templateId,
    required this.title,
    this.description,
    this.assignedToRole,
    this.dueDaysAfterJoining = 0,
    this.isMandatory = false,
    this.sortOrder = 0,
    this.isActive = true,
  });

  factory OnboardingTaskReadModel.fromJson(Map<String, dynamic> json) => _$OnboardingTaskReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$OnboardingTaskReadModelToJson(this);
}

// ── Separation ──
@JsonSerializable()
class SeparationReadModel {
  final String id;
  final String employeeId;
  final String separationType;
  final String? resignationDate;
  final String? lastWorkingDate;
  final int? noticePeriodDays;
  final int noticeShortfallDays;
  final int noticePeriodServed;
  final String? exitInterviewDate;
  final String? exitInterviewNotes;
  final String fnfStatus;
  final String status;
  final EmployeeRefModel? employee;
  final bool isActive;

  SeparationReadModel({
    required this.id,
    required this.employeeId,
    required this.separationType,
    this.resignationDate,
    this.lastWorkingDate,
    this.noticePeriodDays,
    this.noticeShortfallDays = 0,
    this.noticePeriodServed = 0,
    this.exitInterviewDate,
    this.exitInterviewNotes,
    this.fnfStatus = 'Pending',
    this.status = 'Initiated',
    this.employee,
    this.isActive = true,
  });

  factory SeparationReadModel.fromJson(Map<String, dynamic> json) => _$SeparationReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeparationReadModelToJson(this);
}
