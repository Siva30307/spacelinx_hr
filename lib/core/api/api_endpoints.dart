class ApiEndpoints {
  static const String baseUrl = 'https://spacelinx-hr-api-dev.azurewebsites.net/api/v1/';
  // Auth (Placeholder if using Azure AD via MSAL)
  static const String login = 'auth/login';

  // Dashboard
  static const String headcountSummary = 'HRDashboard/headcount-summary';
  static const String attendanceSummary = 'HRDashboard/attendance-summary';
  static const String leaveSummary = 'HRDashboard/leave-summary';
  static const String payrollSummary = 'HRDashboard/payroll-summary';
  static const String attritionSummary = 'HRDashboard/attrition-summary';
  static const String headcountTrend = 'HRDashboard/headcount-trend';

  // Employees
  static const String employees = 'Employee';
  static String employeeDetails(String id) => 'Employee/$id';

  // Attendance
  static const String attendanceRecord = 'AttendanceRecord';
  static String attendanceByEmployee(String id) => 'AttendanceRecord/ByEmployee/$id';
  static const String attendanceRegularization = 'AttendanceRegularization';

  // Leave
  static const String leaveRequest = 'LeaveRequest';
  static String leaveByEmployee(String id) => 'LeaveRequest/ByEmployee/$id';
  static const String leaveBalance = 'LeaveBalance';
}
