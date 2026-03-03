// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_read_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequestReadModel _$LeaveRequestReadModelFromJson(
  Map<String, dynamic> json,
) => LeaveRequestReadModel(
  id: json['id'] as String,
  employeeId: json['employeeId'] as String,
  leaveTypeId: json['leaveTypeId'] as String,
  fromDate: json['fromDate'] as String,
  toDate: json['toDate'] as String,
  numberOfDays: (json['numberOfDays'] as num).toDouble(),
  status: json['status'] as String,
  reason: json['reason'] as String,
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
  'status': instance.status,
  'reason': instance.reason,
};
