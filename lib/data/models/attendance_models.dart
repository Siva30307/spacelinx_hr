import 'package:json_annotation/json_annotation.dart';
import 'package:spacelinx_hr/data/models/employee_read_model.dart';

part 'attendance_models.g.dart';

// ── Shift ──
@JsonSerializable()
class ShiftReadModel {
  final String id;
  final String name;
  final String code;
  final String startTime;
  final String endTime;
  final int graceMinutes;
  final int halfDayHours;
  final int fullDayHours;
  final bool isNightShift;
  final bool isActive;

  ShiftReadModel({
    required this.id,
    required this.name,
    required this.code,
    required this.startTime,
    required this.endTime,
    this.graceMinutes = 0,
    this.halfDayHours = 4,
    this.fullDayHours = 8,
    this.isNightShift = false,
    this.isActive = true,
  });

  factory ShiftReadModel.fromJson(Map<String, dynamic> json) => _$ShiftReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShiftReadModelToJson(this);
}

@JsonSerializable()
class ShiftRefModel {
  final String id;
  final String code;
  final String name;

  ShiftRefModel({required this.id, required this.code, required this.name});

  factory ShiftRefModel.fromJson(Map<String, dynamic> json) => _$ShiftRefModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShiftRefModelToJson(this);
}

// ── Attendance Record (Daily Log) ──
@JsonSerializable()
class AttendanceRecordReadModel {
  final String id;
  final String employeeId;
  final String attendanceDate;
  final String? checkIn;
  final String? checkOut;
  final String? shiftId;
  final String status;
  final double? totalHours;
  final double? overtimeHours;
  final int lateMinutes;
  final int earlyLeaveMinutes;
  final String? source;
  final String? remarks;
  final EmployeeRefModel? employee;
  final ShiftRefModel? shift;
  final bool isActive;

  AttendanceRecordReadModel({
    required this.id,
    required this.employeeId,
    required this.attendanceDate,
    this.checkIn,
    this.checkOut,
    this.shiftId,
    this.status = 'Present',
    this.totalHours,
    this.overtimeHours,
    this.lateMinutes = 0,
    this.earlyLeaveMinutes = 0,
    this.source,
    this.remarks,
    this.employee,
    this.shift,
    this.isActive = true,
  });

  factory AttendanceRecordReadModel.fromJson(Map<String, dynamic> json) => _$AttendanceRecordReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceRecordReadModelToJson(this);
}

// ── Shift Assignment ──
@JsonSerializable()
class ShiftAssignmentReadModel {
  final String id;
  final String employeeId;
  final String shiftId;
  final String effectiveFrom;
  final String? effectiveTo;
  final EmployeeRefModel? employee;
  final ShiftRefModel? shift;
  final bool isActive;

  ShiftAssignmentReadModel({
    required this.id,
    required this.employeeId,
    required this.shiftId,
    required this.effectiveFrom,
    this.effectiveTo,
    this.employee,
    this.shift,
    this.isActive = true,
  });

  factory ShiftAssignmentReadModel.fromJson(Map<String, dynamic> json) => _$ShiftAssignmentReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShiftAssignmentReadModelToJson(this);
}

// ── Attendance Regularization ──
@JsonSerializable()
class AttendanceRegularizationReadModel {
  final String id;
  final String attendanceId;
  final String employeeId;
  final String? originalCheckIn;
  final String? originalCheckOut;
  final String? requestedCheckIn;
  final String? requestedCheckOut;
  final String reason;
  final String status;
  final String? approvedBy;
  final String? approvedAt;
  final EmployeeRefModel? employee;
  final bool isActive;

  AttendanceRegularizationReadModel({
    required this.id,
    required this.attendanceId,
    required this.employeeId,
    this.originalCheckIn,
    this.originalCheckOut,
    this.requestedCheckIn,
    this.requestedCheckOut,
    required this.reason,
    this.status = 'Pending',
    this.approvedBy,
    this.approvedAt,
    this.employee,
    this.isActive = true,
  });

  factory AttendanceRegularizationReadModel.fromJson(Map<String, dynamic> json) => _$AttendanceRegularizationReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceRegularizationReadModelToJson(this);
}
