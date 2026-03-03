// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_record_read_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceRecordReadModel _$AttendanceRecordReadModelFromJson(
  Map<String, dynamic> json,
) => AttendanceRecordReadModel(
  id: json['id'] as String,
  employeeId: json['employeeId'] as String,
  attendanceDate: json['attendanceDate'] as String,
  checkIn: json['checkIn'] as String?,
  checkOut: json['checkOut'] as String?,
  status: json['status'] as String,
  totalHours: (json['totalHours'] as num?)?.toDouble(),
);

Map<String, dynamic> _$AttendanceRecordReadModelToJson(
  AttendanceRecordReadModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'employeeId': instance.employeeId,
  'attendanceDate': instance.attendanceDate,
  'checkIn': instance.checkIn,
  'checkOut': instance.checkOut,
  'status': instance.status,
  'totalHours': instance.totalHours,
};
