// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftReadModel _$ShiftReadModelFromJson(Map<String, dynamic> json) =>
    ShiftReadModel(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      graceMinutes: (json['graceMinutes'] as num?)?.toInt() ?? 0,
      halfDayHours: (json['halfDayHours'] as num?)?.toInt() ?? 4,
      fullDayHours: (json['fullDayHours'] as num?)?.toInt() ?? 8,
      isNightShift: json['isNightShift'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$ShiftReadModelToJson(ShiftReadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'graceMinutes': instance.graceMinutes,
      'halfDayHours': instance.halfDayHours,
      'fullDayHours': instance.fullDayHours,
      'isNightShift': instance.isNightShift,
      'isActive': instance.isActive,
    };

ShiftRefModel _$ShiftRefModelFromJson(Map<String, dynamic> json) =>
    ShiftRefModel(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ShiftRefModelToJson(ShiftRefModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };

AttendanceRecordReadModel _$AttendanceRecordReadModelFromJson(
  Map<String, dynamic> json,
) => AttendanceRecordReadModel(
  id: json['id'] as String,
  employeeId: json['employeeId'] as String,
  attendanceDate: json['attendanceDate'] as String,
  checkIn: json['checkIn'] as String?,
  checkOut: json['checkOut'] as String?,
  shiftId: json['shiftId'] as String?,
  status: json['status'] as String? ?? 'Present',
  totalHours: (json['totalHours'] as num?)?.toDouble(),
  overtimeHours: (json['overtimeHours'] as num?)?.toDouble(),
  lateMinutes: (json['lateMinutes'] as num?)?.toInt() ?? 0,
  earlyLeaveMinutes: (json['earlyLeaveMinutes'] as num?)?.toInt() ?? 0,
  source: json['source'] as String?,
  remarks: json['remarks'] as String?,
  employee: json['employee'] == null
      ? null
      : EmployeeRefModel.fromJson(json['employee'] as Map<String, dynamic>),
  shift: json['shift'] == null
      ? null
      : ShiftRefModel.fromJson(json['shift'] as Map<String, dynamic>),
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$AttendanceRecordReadModelToJson(
  AttendanceRecordReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'employeeId': instance.employeeId,
  'attendanceDate': instance.attendanceDate,
  'checkIn': instance.checkIn,
  'checkOut': instance.checkOut,
  'shiftId': instance.shiftId,
  'status': instance.status,
  'totalHours': instance.totalHours,
  'overtimeHours': instance.overtimeHours,
  'lateMinutes': instance.lateMinutes,
  'earlyLeaveMinutes': instance.earlyLeaveMinutes,
  'source': instance.source,
  'remarks': instance.remarks,
  'employee': instance.employee,
  'shift': instance.shift,
  'isActive': instance.isActive,
};

ShiftAssignmentReadModel _$ShiftAssignmentReadModelFromJson(
  Map<String, dynamic> json,
) => ShiftAssignmentReadModel(
  id: json['id'] as String,
  employeeId: json['employeeId'] as String,
  shiftId: json['shiftId'] as String,
  effectiveFrom: json['effectiveFrom'] as String,
  effectiveTo: json['effectiveTo'] as String?,
  employee: json['employee'] == null
      ? null
      : EmployeeRefModel.fromJson(json['employee'] as Map<String, dynamic>),
  shift: json['shift'] == null
      ? null
      : ShiftRefModel.fromJson(json['shift'] as Map<String, dynamic>),
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$ShiftAssignmentReadModelToJson(
  ShiftAssignmentReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'employeeId': instance.employeeId,
  'shiftId': instance.shiftId,
  'effectiveFrom': instance.effectiveFrom,
  'effectiveTo': instance.effectiveTo,
  'employee': instance.employee,
  'shift': instance.shift,
  'isActive': instance.isActive,
};

AttendanceRegularizationReadModel _$AttendanceRegularizationReadModelFromJson(
  Map<String, dynamic> json,
) => AttendanceRegularizationReadModel(
  id: json['id'] as String,
  attendanceId: json['attendanceId'] as String,
  employeeId: json['employeeId'] as String,
  originalCheckIn: json['originalCheckIn'] as String?,
  originalCheckOut: json['originalCheckOut'] as String?,
  requestedCheckIn: json['requestedCheckIn'] as String?,
  requestedCheckOut: json['requestedCheckOut'] as String?,
  reason: json['reason'] as String,
  status: json['status'] as String? ?? 'Pending',
  approvedBy: json['approvedBy'] as String?,
  approvedAt: json['approvedAt'] as String?,
  employee: json['employee'] == null
      ? null
      : EmployeeRefModel.fromJson(json['employee'] as Map<String, dynamic>),
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$AttendanceRegularizationReadModelToJson(
  AttendanceRegularizationReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'attendanceId': instance.attendanceId,
  'employeeId': instance.employeeId,
  'originalCheckIn': instance.originalCheckIn,
  'originalCheckOut': instance.originalCheckOut,
  'requestedCheckIn': instance.requestedCheckIn,
  'requestedCheckOut': instance.requestedCheckOut,
  'reason': instance.reason,
  'status': instance.status,
  'approvedBy': instance.approvedBy,
  'approvedAt': instance.approvedAt,
  'employee': instance.employee,
  'isActive': instance.isActive,
};
