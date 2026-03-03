class DimensionCount {
  final String label;
  final int count;

  DimensionCount({required this.label, required this.count});

  factory DimensionCount.fromJson(Map<String, dynamic> json) {
    return DimensionCount(
      label: json['label'] as String? ?? '',
      count: json['count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'count': count,
      };
}

class HeadcountSummary {
  final int totalActive;
  final int totalOnNotice;
  final List<DimensionCount> byDepartment;
  final List<DimensionCount> byLocation;
  final List<DimensionCount> byGrade;
  final List<DimensionCount> byGender;

  HeadcountSummary({
    required this.totalActive,
    required this.totalOnNotice,
    required this.byDepartment,
    required this.byLocation,
    required this.byGrade,
    required this.byGender,
  });

  factory HeadcountSummary.fromJson(Map<String, dynamic> json) {
    return HeadcountSummary(
      totalActive: json['totalActive'] as int? ?? 0,
      totalOnNotice: json['totalOnNotice'] as int? ?? 0,
      byDepartment: (json['byDepartment'] as List?)
              ?.map((e) => DimensionCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      byLocation: (json['byLocation'] as List?)
              ?.map((e) => DimensionCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      byGrade: (json['byGrade'] as List?)
              ?.map((e) => DimensionCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      byGender: (json['byGender'] as List?)
              ?.map((e) => DimensionCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'totalActive': totalActive,
        'totalOnNotice': totalOnNotice,
        'byDepartment': byDepartment.map((e) => e.toJson()).toList(),
        'byLocation': byLocation.map((e) => e.toJson()).toList(),
        'byGrade': byGrade.map((e) => e.toJson()).toList(),
        'byGender': byGender.map((e) => e.toJson()).toList(),
      };
}

class AttendanceSummary {
  final String? date;
  final int present;
  final int absent;
  final int onLeave;
  final int wfh;
  final int halfDay;
  final int holiday;
  final int total;

  AttendanceSummary({
    this.date,
    required this.present,
    required this.absent,
    required this.onLeave,
    required this.wfh,
    required this.halfDay,
    required this.holiday,
    required this.total,
  });

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) {
    return AttendanceSummary(
      date: json['date'] as String?,
      present: json['present'] as int? ?? 0,
      absent: json['absent'] as int? ?? 0,
      onLeave: json['onLeave'] as int? ?? 0,
      wfh: json['wfh'] as int? ?? 0,
      halfDay: json['halfDay'] as int? ?? 0,
      holiday: json['holiday'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'present': present,
        'absent': absent,
        'onLeave': onLeave,
        'wfh': wfh,
        'halfDay': halfDay,
        'holiday': holiday,
        'total': total,
      };
}

class HeadcountTrend {
  final int month;
  final int year;
  final int count;

  HeadcountTrend({
    required this.month,
    required this.year,
    required this.count,
  });

  factory HeadcountTrend.fromJson(Map<String, dynamic> json) {
    return HeadcountTrend(
      month: json['month'] as int? ?? 0,
      year: json['year'] as int? ?? 0,
      count: json['count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'month': month,
        'year': year,
        'count': count,
      };
}
