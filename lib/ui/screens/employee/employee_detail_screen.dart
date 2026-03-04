import 'package:flutter/material.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/employee_read_model.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final EmployeeReadModel employee;
  const EmployeeDetailScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Employee Details', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile header
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.2),
                    child: Text(
                      employee.firstName[0] + employee.lastName[0],
                      style: const TextStyle(color: Color(0xFF6366F1), fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(employee.fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(employee.employeeId, style: TextStyle(color: Colors.white.withValues(alpha: 0.5))),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _buildStatusChip(employee.employmentStatus),
                            if (employee.employmentType != null) ...[
                              const SizedBox(width: 6),
                              _buildChip(employee.employmentType!, Colors.blue),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Personal Information
            _buildSection(
              'Personal Information',
              Icons.person,
              [
                _buildInfoRow('Date of Birth', employee.dateOfBirth ?? '—'),
                _buildInfoRow('Gender', employee.gender ?? '—'),
                _buildInfoRow('Blood Group', employee.bloodGroup ?? '—'),
                _buildInfoRow('Marital Status', employee.maritalStatus ?? '—'),
                _buildInfoRow('Nationality', employee.nationality ?? '—'),
                _buildInfoRow('Religion', employee.religion ?? '—'),
                _buildInfoRow("Father's Name", employee.fatherName ?? '—'),
                _buildInfoRow('Spouse Name', employee.spouseName ?? '—'),
              ],
            ),
            const SizedBox(height: 16),

            // Employment Details
            _buildSection(
              'Employment Details',
              Icons.work,
              [
                _buildInfoRow('Department', employee.departmentName ?? '—'),
                _buildInfoRow('Designation', employee.designation?.name ?? '—'),
                _buildInfoRow('Date of Joining', employee.dateOfJoining ?? '—'),
                _buildInfoRow('Employment Type', employee.employmentType ?? '—'),
                _buildInfoRow('Notice Period', '${employee.noticePeriodDays} days'),
                _buildInfoRow('Confirmation Date', employee.dateOfConfirmation ?? '—'),
                _buildInfoRow('Probation End', employee.probationEndDate ?? '—'),
              ],
            ),
            const SizedBox(height: 16),

            // Contact Information
            _buildSection(
              'Contact Information',
              Icons.phone,
              [
                _buildInfoRow('Work Email', employee.workEmail),
                _buildInfoRow('Personal Email', employee.personalEmail ?? '—'),
                _buildInfoRow('Mobile', employee.mobileNumber),
                _buildInfoRow('Alternate Phone', employee.alternatePhone ?? '—'),
              ],
            ),
            const SizedBox(height: 16),

            // Identity Documents
            _buildSection(
              'Identity Documents',
              Icons.badge,
              [
                _buildInfoRow('PAN Number', employee.panNumber ?? '—'),
                _buildInfoRow('Aadhaar Number', employee.aadhaarNumber ?? '—'),
                _buildInfoRow('Passport', employee.passportNumber ?? '—'),
                _buildInfoRow('Passport Expiry', employee.passportExpiry ?? '—'),
                _buildInfoRow('Voter ID', employee.voterId ?? '—'),
                _buildInfoRow('Driving License', employee.drivingLicense ?? '—'),
                _buildInfoRow('DL Expiry', employee.dlExpiry ?? '—'),
                _buildInfoRow('UAN Number', employee.uanNumber ?? '—'),
                _buildInfoRow('ESI Number', employee.esiNumber ?? '—'),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF6366F1), size: 20),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          const Divider(height: 24, color: Colors.white12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.5))),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Active': color = Colors.green; break;
      case 'OnNotice': color = Colors.orange; break;
      case 'Terminated': color = Colors.red; break;
      default: color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6), border: Border.all(color: color.withValues(alpha: 0.5))),
      child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
