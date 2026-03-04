// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypeReadModel _$LeaveTypeReadModelFromJson(Map<String, dynamic> json) =>
    LeaveTypeReadModel(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      description: json['description'] as String?,
      isPaid: json['isPaid'] as bool,
      isCarryForward: json['isCarryForward'] as bool,
      maxCarryForward: (json['maxCarryForward'] as num).toDouble(),
      isEncashable: json['isEncashable'] as bool,
      maxEncashment: (json['maxEncashment'] as num).toDouble(),
    );

Map<String, dynamic> _$LeaveTypeReadModelToJson(LeaveTypeReadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'isPaid': instance.isPaid,
      'isCarryForward': instance.isCarryForward,
      'maxCarryForward': instance.maxCarryForward,
      'isEncashable': instance.isEncashable,
      'maxEncashment': instance.maxEncashment,
    };

LeaveTypeRefModel _$LeaveTypeRefModelFromJson(Map<String, dynamic> json) =>
    LeaveTypeRefModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$LeaveTypeRefModelToJson(LeaveTypeRefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };

LeavePolicyReadModel _$LeavePolicyReadModelFromJson(
  Map<String, dynamic> json,
) => LeavePolicyReadModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  effectiveFrom: json['effectiveFrom'] as String,
  effectiveTo: json['effectiveTo'] as String?,
);

Map<String, dynamic> _$LeavePolicyReadModelToJson(
  LeavePolicyReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'effectiveFrom': instance.effectiveFrom,
  'effectiveTo': instance.effectiveTo,
};

LeavePolicyDetailReadModel _$LeavePolicyDetailReadModelFromJson(
  Map<String, dynamic> json,
) => LeavePolicyDetailReadModel(
  id: json['id'] as String,
  leavePolicyId: json['leavePolicyId'] as String,
  leaveTypeId: json['leaveTypeId'] as String,
  annualQuota: (json['annualQuota'] as num).toDouble(),
  accrualType: json['accrualType'] as String?,
  maxConsecutive: (json['maxConsecutive'] as num?)?.toDouble(),
  minDaysBefore: (json['minDaysBefore'] as num).toInt(),
  applicableGender: json['applicableGender'] as String?,
  leaveType: json['leaveType'] == null
      ? null
      : LeaveTypeRefModel.fromJson(json['leaveType'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LeavePolicyDetailReadModelToJson(
  LeavePolicyDetailReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'leavePolicyId': instance.leavePolicyId,
  'leaveTypeId': instance.leaveTypeId,
  'annualQuota': instance.annualQuota,
  'accrualType': instance.accrualType,
  'maxConsecutive': instance.maxConsecutive,
  'minDaysBefore': instance.minDaysBefore,
  'applicableGender': instance.applicableGender,
  'leaveType': instance.leaveType,
};

LeaveBalanceReadModel _$LeaveBalanceReadModelFromJson(
  Map<String, dynamic> json,
) => LeaveBalanceReadModel(
  id: json['id'] as String,
  employeeId: json['employeeId'] as String,
  leaveTypeId: json['leaveTypeId'] as String,
  year: (json['year'] as num).toInt(),
  openingBalance: (json['openingBalance'] as num).toDouble(),
  accrued: (json['accrued'] as num).toDouble(),
  taken: (json['taken'] as num).toDouble(),
  adjusted: (json['adjusted'] as num).toDouble(),
  carryForward: (json['carryForward'] as num).toDouble(),
  closingBalance: (json['closingBalance'] as num).toDouble(),
  employee: json['employee'] == null
      ? null
      : EmployeeRefModel.fromJson(json['employee'] as Map<String, dynamic>),
  leaveType: json['leaveType'] == null
      ? null
      : LeaveTypeRefModel.fromJson(json['leaveType'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LeaveBalanceReadModelToJson(
  LeaveBalanceReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'employeeId': instance.employeeId,
  'leaveTypeId': instance.leaveTypeId,
  'year': instance.year,
  'openingBalance': instance.openingBalance,
  'accrued': instance.accrued,
  'taken': instance.taken,
  'adjusted': instance.adjusted,
  'carryForward': instance.carryForward,
  'closingBalance': instance.closingBalance,
  'employee': instance.employee,
  'leaveType': instance.leaveType,
};

LeaveRequestReadModel _$LeaveRequestReadModelFromJson(
  Map<String, dynamic> json,
) => LeaveRequestReadModel(
  id: json['id'] as String,
  employeeId: json['employeeId'] as String,
  leaveTypeId: json['leaveTypeId'] as String,
  fromDate: json['fromDate'] as String,
  toDate: json['toDate'] as String,
  numberOfDays: (json['numberOfDays'] as num).toDouble(),
  isHalfDay: json['isHalfDay'] as bool,
  halfDayType: json['halfDayType'] as String?,
  reason: json['reason'] as String,
  status: json['status'] as String,
  approvedBy: json['approvedBy'] as String?,
  approvedAt: json['approvedAt'] as String?,
  rejectionReason: json['rejectionReason'] as String?,
  employee: json['employee'] == null
      ? null
      : EmployeeRefModel.fromJson(json['employee'] as Map<String, dynamic>),
  leaveType: json['leaveType'] == null
      ? null
      : LeaveTypeRefModel.fromJson(json['leaveType'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LeaveRequestReadModelToJson(
  LeaveRequestReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'employeeId': instance.employeeId,
  'leaveTypeId': instance.leaveTypeId,
  'fromDate': instance.fromDate,
  'toDate': instance.toDate,
  'numberOfDays': instance.numberOfDays,
  'isHalfDay': instance.isHalfDay,
  'halfDayType': instance.halfDayType,
  'reason': instance.reason,
  'status': instance.status,
  'approvedBy': instance.approvedBy,
  'approvedAt': instance.approvedAt,
  'rejectionReason': instance.rejectionReason,
  'employee': instance.employee,
  'leaveType': instance.leaveType,
};

HolidayCalendarReadModel _$HolidayCalendarReadModelFromJson(
  Map<String, dynamic> json,
) => HolidayCalendarReadModel(
  id: json['id'] as String,
  name: json['name'] as String,
  year: (json['year'] as num).toInt(),
  locationId: json['locationId'] as String?,
  location: json['location'] == null
      ? null
      : WorkLocationRefModel.fromJson(json['location'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HolidayCalendarReadModelToJson(
  HolidayCalendarReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'year': instance.year,
  'locationId': instance.locationId,
  'location': instance.location,
};

HolidayReadModel _$HolidayReadModelFromJson(Map<String, dynamic> json) =>
    HolidayReadModel(
      id: json['id'] as String,
      holidayCalendarId: json['holidayCalendarId'] as String,
      name: json['name'] as String,
      holidayDate: json['holidayDate'] as String,
      type: json['type'] as String,
      isOptional: json['isOptional'] as bool,
    );

Map<String, dynamic> _$HolidayReadModelToJson(HolidayReadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'holidayCalendarId': instance.holidayCalendarId,
      'name': instance.name,
      'holidayDate': instance.holidayDate,
      'type': instance.type,
      'isOptional': instance.isOptional,
    };
