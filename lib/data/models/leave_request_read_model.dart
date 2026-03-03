import 'package:json_annotation/json_annotation.dart';

part 'leave_request_read_model.g.dart';

@JsonSerializable()
class LeaveRequestReadModel {
  final String id;
  final String employeeId;
  final String leaveTypeId;
  final String fromDate; // yyyy-MM-dd
  final String toDate; // yyyy-MM-dd
  final double numberOfDays;
  final String status; // Pending|Approved|Rejected
  final String reason;

  LeaveRequestReadModel({
    required this.id,
    required this.employeeId,
    required this.leaveTypeId,
    required this.fromDate,
    required this.toDate,
    required this.numberOfDays,
    required this.status,
    required this.reason,
  });

  factory LeaveRequestReadModel.fromJson(Map<String, dynamic> json) => _$LeaveRequestReadModelFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveRequestReadModelToJson(this);
}
