import 'package:json_annotation/json_annotation.dart';

part 'dashboard_summary_models.g.dart';

@JsonSerializable()
class DimensionCount {
  final String label;
  final int count;

  DimensionCount({required this.label, required this.count});

  factory DimensionCount.fromJson(Map<String, dynamic> json) => _$DimensionCountFromJson(json);
  Map<String, dynamic> toJson() => _$DimensionCountToJson(this);
}

@JsonSerializable()
class HeadcountSummary {
  final int totalActive;
  final int totalOnNotice;
  final List<DimensionCount> byDepartment;
  final List<DimensionCount> byLocation;
  final List<DimensionCount> byGrade;
  final List<DimensionCount> byGender;

  HeadcountSummary({
    this.totalActive = 0,
    this.totalOnNotice = 0,
    this.byDepartment = const [],
    this.byLocation = const [],
    this.byGrade = const [],
    this.byGender = const [],
  });

  factory HeadcountSummary.fromJson(Map<String, dynamic> json) => _$HeadcountSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$HeadcountSummaryToJson(this);
}

@JsonSerializable()
class AttendanceSummary {
  final String date;
  final int present;
  final int absent;
  final int onLeave;
  final int wfh;
  final int halfDay;
  final int holiday;
  final int total;

  AttendanceSummary({
    required this.date,
    this.present = 0,
    this.absent = 0,
    this.onLeave = 0,
    this.wfh = 0,
    this.halfDay = 0,
    this.holiday = 0,
    this.total = 0,
  });

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) => _$AttendanceSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceSummaryToJson(this);
}

@JsonSerializable()
class LeaveTypeSummary {
  final String typeName;
  final double totalQuota;
  final double used;
  final double available;

  LeaveTypeSummary({
    required this.typeName,
    this.totalQuota = 0,
    this.used = 0,
    this.available = 0,
  });

  factory LeaveTypeSummary.fromJson(Map<String, dynamic> json) => _$LeaveTypeSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveTypeSummaryToJson(this);
}

@JsonSerializable()
class LeaveSummary {
  final int pendingRequests;
  final List<LeaveTypeSummary> byType;

  LeaveSummary({
    this.pendingRequests = 0,
    this.byType = const [],
  });

  factory LeaveSummary.fromJson(Map<String, dynamic> json) => _$LeaveSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveSummaryToJson(this);
}

@JsonSerializable()
class MonthlyPayrollTrend {
  final int month;
  final int year;
  final double totalGross;
  final double totalNet;

  MonthlyPayrollTrend({
    required this.month,
    required this.year,
    this.totalGross = 0,
    this.totalNet = 0,
  });

  factory MonthlyPayrollTrend.fromJson(Map<String, dynamic> json) => _$MonthlyPayrollTrendFromJson(json);
  Map<String, dynamic> toJson() => _$MonthlyPayrollTrendToJson(this);
}

@JsonSerializable()
class PayrollSummary {
  final int lastRunMonth;
  final int lastRunYear;
  final double totalGross;
  final double totalDeductions;
  final double totalNet;
  final int employeeCount;
  final List<MonthlyPayrollTrend> monthlyTrend;

  PayrollSummary({
    required this.lastRunMonth,
    required this.lastRunYear,
    this.totalGross = 0,
    this.totalDeductions = 0,
    this.totalNet = 0,
    this.employeeCount = 0,
    this.monthlyTrend = const [],
  });

  factory PayrollSummary.fromJson(Map<String, dynamic> json) => _$PayrollSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$PayrollSummaryToJson(this);
}

@JsonSerializable()
class RecentSeparation {
  final String employeeName;
  final String? department;
  final String separationType;
  final String lastWorkingDate;

  RecentSeparation({
    required this.employeeName,
    this.department,
    required this.separationType,
    required this.lastWorkingDate,
  });

  factory RecentSeparation.fromJson(Map<String, dynamic> json) => _$RecentSeparationFromJson(json);
  Map<String, dynamic> toJson() => _$RecentSeparationToJson(this);
}

@JsonSerializable()
class AttritionSummary {
  final double monthlyRate;
  final double quarterlyRate;
  final double annualRate;
  final List<RecentSeparation> recentSeparations;

  AttritionSummary({
    this.monthlyRate = 0,
    this.quarterlyRate = 0,
    this.annualRate = 0,
    this.recentSeparations = const [],
  });

  factory AttritionSummary.fromJson(Map<String, dynamic> json) => _$AttritionSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$AttritionSummaryToJson(this);
}

@JsonSerializable()
class HeadcountTrend {
  final int month;
  final int year;
  final int count;

  HeadcountTrend({
    required this.month,
    required this.year,
    required this.count,
  });

  factory HeadcountTrend.fromJson(Map<String, dynamic> json) => _$HeadcountTrendFromJson(json);
  Map<String, dynamic> toJson() => _$HeadcountTrendToJson(this);
}
