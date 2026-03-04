import 'package:json_annotation/json_annotation.dart';
import 'package:spacelinx_hr/data/models/employee_read_model.dart';
import 'package:spacelinx_hr/data/models/organization_models.dart';

part 'leave_models.g.dart';

@JsonSerializable()
class LeaveTypeReadModel {
  final String id;  
  final String name;
  final String code;
  final String? description;
  final bool isPaid;
  final bool isCarryForward;
  final double maxCarryForward;
  final bool isEncashable;
  final double maxEncashment;

  LeaveTypeReadModel({
    required this.id,
    required this.name,
    required this.code,
    this.description,
    required this.isPaid,
    required this.isCarryForward,
    required this.maxCarryForward,
    required this.isEncashable,
    required this.maxEncashment,
  });

  factory LeaveTypeReadModel.fromJson(Map<String, dynamic> json) => _$LeaveTypeReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveTypeReadModelToJson(this);
}

@JsonSerializable()
class LeaveTypeRefModel {
  final String id;
  final String code;
  final String name;

  LeaveTypeRefModel({
    required this.id,
    required this.code,
    required this.name,
  });

  factory LeaveTypeRefModel.fromJson(Map<String, dynamic> json) => _$LeaveTypeRefModelFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveTypeRefModelToJson(this);
}

@JsonSerializable()
class LeavePolicyReadModel {
  final String id;
  final String name;
  final String? description;
  final String effectiveFrom;
  final String? effectiveTo;

  LeavePolicyReadModel({
    required this.id,
    required this.name,
    this.description,
    required this.effectiveFrom,
    this.effectiveTo,
  });

  factory LeavePolicyReadModel.fromJson(Map<String, dynamic> json) => _$LeavePolicyReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$LeavePolicyReadModelToJson(this);
}

@JsonSerializable()
class LeavePolicyDetailReadModel {
  final String id;
  final String leavePolicyId;
  final String leaveTypeId;
  final double annualQuota;
  final String? accrualType;
  final double? maxConsecutive;
  final int minDaysBefore;
  final String? applicableGender;
  final LeaveTypeRefModel? leaveType;

  LeavePolicyDetailReadModel({
    required this.id,
    required this.leavePolicyId,
    required this.leaveTypeId,
    required this.annualQuota,
    this.accrualType,
    this.maxConsecutive,
    required this.minDaysBefore,
    this.applicableGender,
    this.leaveType,
  });

  factory LeavePolicyDetailReadModel.fromJson(Map<String, dynamic> json) => _$LeavePolicyDetailReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$LeavePolicyDetailReadModelToJson(this);
}

@JsonSerializable()
class LeaveBalanceReadModel {
  final String id;
  final String employeeId;
  final String leaveTypeId;
  final int year;
  final double openingBalance;
  final double accrued;
  final double taken;
  final double adjusted;
  final double carryForward;
  final double closingBalance;
  final EmployeeRefModel? employee;
  final LeaveTypeRefModel? leaveType;

  LeaveBalanceReadModel({
    required this.id,
    required this.employeeId,
    required this.leaveTypeId,
    required this.year,
    required this.openingBalance,
    required this.accrued,
    required this.taken,
    required this.adjusted,
    required this.carryForward,
    required this.closingBalance,
    this.employee,
    this.leaveType,
  });

  factory LeaveBalanceReadModel.fromJson(Map<String, dynamic> json) => _$LeaveBalanceReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveBalanceReadModelToJson(this);
}

@JsonSerializable()
class LeaveRequestReadModel {
  final String id;
  final String employeeId;
  final String leaveTypeId;
  final String fromDate;
  final String toDate;
  final double numberOfDays;
  final bool isHalfDay;
  final String? halfDayType;
  final String reason;
  final String status;
  final String? approvedBy;
  final String? approvedAt;
  final String? rejectionReason;
  final EmployeeRefModel? employee;
  final LeaveTypeRefModel? leaveType;

  LeaveRequestReadModel({
    required this.id,
    required this.employeeId,
    required this.leaveTypeId,
    required this.fromDate,
    required this.toDate,
    required this.numberOfDays,
    required this.isHalfDay,
    this.halfDayType,
    required this.reason,
    required this.status,
    this.approvedBy,
    this.approvedAt,
    this.rejectionReason,
    this.employee,
    this.leaveType,
  });

  factory LeaveRequestReadModel.fromJson(Map<String, dynamic> json) => _$LeaveRequestReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveRequestReadModelToJson(this);
}

@JsonSerializable()
class HolidayCalendarReadModel {
  final String id;
  final String name;
  final int year;
  final String? locationId;
  final WorkLocationRefModel? location;

  HolidayCalendarReadModel({
    required this.id,
    required this.name,
    required this.year,
    this.locationId,
    this.location,
  });

  factory HolidayCalendarReadModel.fromJson(Map<String, dynamic> json) => _$HolidayCalendarReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$HolidayCalendarReadModelToJson(this);
}

@JsonSerializable()
class HolidayReadModel {
  final String id;
  final String holidayCalendarId;
  final String name;
  final String holidayDate;
  final String type;
  final bool isOptional;

  HolidayReadModel({
    required this.id,
    required this.holidayCalendarId,
    required this.name,
    required this.holidayDate,
    required this.type,
    required this.isOptional,
  });

  factory HolidayReadModel.fromJson(Map<String, dynamic> json) => _$HolidayReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$HolidayReadModelToJson(this);
}
