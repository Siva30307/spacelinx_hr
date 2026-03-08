// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DimensionCount _$DimensionCountFromJson(Map<String, dynamic> json) =>
    DimensionCount(
      label: json['label'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$DimensionCountToJson(DimensionCount instance) =>
    <String, dynamic>{'label': instance.label, 'count': instance.count};

HeadcountSummary _$HeadcountSummaryFromJson(Map<String, dynamic> json) =>
    HeadcountSummary(
      totalActive: (json['totalActive'] as num?)?.toInt() ?? 0,
      totalOnNotice: (json['totalOnNotice'] as num?)?.toInt() ?? 0,
      byDepartment:
          (json['byDepartment'] as List<dynamic>?)
              ?.map((e) => DimensionCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      byLocation:
          (json['byLocation'] as List<dynamic>?)
              ?.map((e) => DimensionCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      byGrade:
          (json['byGrade'] as List<dynamic>?)
              ?.map((e) => DimensionCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      byGender:
          (json['byGender'] as List<dynamic>?)
              ?.map((e) => DimensionCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HeadcountSummaryToJson(HeadcountSummary instance) =>
    <String, dynamic>{
      'totalActive': instance.totalActive,
      'totalOnNotice': instance.totalOnNotice,
      'byDepartment': instance.byDepartment,
      'byLocation': instance.byLocation,
      'byGrade': instance.byGrade,
      'byGender': instance.byGender,
    };

AttendanceSummary _$AttendanceSummaryFromJson(Map<String, dynamic> json) =>
    AttendanceSummary(
      date: json['date'] as String,
      present: (json['present'] as num?)?.toInt() ?? 0,
      absent: (json['absent'] as num?)?.toInt() ?? 0,
      onLeave: (json['onLeave'] as num?)?.toInt() ?? 0,
      wfh: (json['wfh'] as num?)?.toInt() ?? 0,
      halfDay: (json['halfDay'] as num?)?.toInt() ?? 0,
      holiday: (json['holiday'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AttendanceSummaryToJson(AttendanceSummary instance) =>
    <String, dynamic>{
      'date': instance.date,
      'present': instance.present,
      'absent': instance.absent,
      'onLeave': instance.onLeave,
      'wfh': instance.wfh,
      'halfDay': instance.halfDay,
      'holiday': instance.holiday,
      'total': instance.total,
    };

LeaveTypeSummary _$LeaveTypeSummaryFromJson(Map<String, dynamic> json) =>
    LeaveTypeSummary(
      typeName: json['typeName'] as String,
      totalQuota: (json['totalQuota'] as num?)?.toDouble() ?? 0,
      used: (json['used'] as num?)?.toDouble() ?? 0,
      available: (json['available'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$LeaveTypeSummaryToJson(LeaveTypeSummary instance) =>
    <String, dynamic>{
      'typeName': instance.typeName,
      'totalQuota': instance.totalQuota,
      'used': instance.used,
      'available': instance.available,
    };

LeaveSummary _$LeaveSummaryFromJson(Map<String, dynamic> json) => LeaveSummary(
  pendingRequests: (json['pendingRequests'] as num?)?.toInt() ?? 0,
  byType:
      (json['byType'] as List<dynamic>?)
          ?.map((e) => LeaveTypeSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$LeaveSummaryToJson(LeaveSummary instance) =>
    <String, dynamic>{
      'pendingRequests': instance.pendingRequests,
      'byType': instance.byType,
    };

MonthlyPayrollTrend _$MonthlyPayrollTrendFromJson(Map<String, dynamic> json) =>
    MonthlyPayrollTrend(
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      totalGross: (json['totalGross'] as num?)?.toDouble() ?? 0,
      totalNet: (json['totalNet'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$MonthlyPayrollTrendToJson(
  MonthlyPayrollTrend instance,
) => <String, dynamic>{
  'month': instance.month,
  'year': instance.year,
  'totalGross': instance.totalGross,
  'totalNet': instance.totalNet,
};

PayrollSummary _$PayrollSummaryFromJson(Map<String, dynamic> json) =>
    PayrollSummary(
      lastRunMonth: (json['lastRunMonth'] as num).toInt(),
      lastRunYear: (json['lastRunYear'] as num).toInt(),
      totalGross: (json['totalGross'] as num?)?.toDouble() ?? 0,
      totalDeductions: (json['totalDeductions'] as num?)?.toDouble() ?? 0,
      totalNet: (json['totalNet'] as num?)?.toDouble() ?? 0,
      employeeCount: (json['employeeCount'] as num?)?.toInt() ?? 0,
      monthlyTrend:
          (json['monthlyTrend'] as List<dynamic>?)
              ?.map(
                (e) => MonthlyPayrollTrend.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PayrollSummaryToJson(PayrollSummary instance) =>
    <String, dynamic>{
      'lastRunMonth': instance.lastRunMonth,
      'lastRunYear': instance.lastRunYear,
      'totalGross': instance.totalGross,
      'totalDeductions': instance.totalDeductions,
      'totalNet': instance.totalNet,
      'employeeCount': instance.employeeCount,
      'monthlyTrend': instance.monthlyTrend,
    };

RecentSeparation _$RecentSeparationFromJson(Map<String, dynamic> json) =>
    RecentSeparation(
      employeeName: json['employeeName'] as String,
      department: json['department'] as String?,
      separationType: json['separationType'] as String,
      lastWorkingDate: json['lastWorkingDate'] as String,
    );

Map<String, dynamic> _$RecentSeparationToJson(RecentSeparation instance) =>
    <String, dynamic>{
      'employeeName': instance.employeeName,
      'department': instance.department,
      'separationType': instance.separationType,
      'lastWorkingDate': instance.lastWorkingDate,
    };

AttritionSummary _$AttritionSummaryFromJson(Map<String, dynamic> json) =>
    AttritionSummary(
      monthlyRate: (json['monthlyRate'] as num?)?.toDouble() ?? 0,
      quarterlyRate: (json['quarterlyRate'] as num?)?.toDouble() ?? 0,
      annualRate: (json['annualRate'] as num?)?.toDouble() ?? 0,
      recentSeparations:
          (json['recentSeparations'] as List<dynamic>?)
              ?.map((e) => RecentSeparation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AttritionSummaryToJson(AttritionSummary instance) =>
    <String, dynamic>{
      'monthlyRate': instance.monthlyRate,
      'quarterlyRate': instance.quarterlyRate,
      'annualRate': instance.annualRate,
      'recentSeparations': instance.recentSeparations,
    };

HeadcountTrend _$HeadcountTrendFromJson(Map<String, dynamic> json) =>
    HeadcountTrend(
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$HeadcountTrendToJson(HeadcountTrend instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'count': instance.count,
    };
