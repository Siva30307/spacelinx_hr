import 'package:json_annotation/json_annotation.dart';

part 'attendance_record_read_model.g.dart';

@JsonSerializable()
class AttendanceRecordReadModel {
  final String id;
  final String employeeId;
  final String attendanceDate; // yyyy-MM-dd
  final String? checkIn; // iso-8601
  final String? checkOut; // iso-8601
  final String status; // Present|Absent|OnLeave|WFH
  final double? totalHours;

  AttendanceRecordReadModel({
    required this.id,
    required this.employeeId,
    required this.attendanceDate,
    this.checkIn,
    this.checkOut,
    required this.status,
    this.totalHours,
  });

  factory AttendanceRecordReadModel.fromJson(Map<String, dynamic> json) => _$AttendanceRecordReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceRecordReadModelToJson(this);
}
