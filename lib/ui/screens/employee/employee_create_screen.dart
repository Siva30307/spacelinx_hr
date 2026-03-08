import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/employee_provider.dart';
import 'package:spacelinx_hr/providers/organization_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/employee_read_model.dart';

class EmployeeCreateScreen extends StatefulWidget {
  final EmployeeReadModel? editEmployee;
  const EmployeeCreateScreen({super.key, this.editEmployee});

  @override
  State<EmployeeCreateScreen> createState() => _EmployeeCreateScreenState();
}

class _EmployeeCreateScreenState extends State<EmployeeCreateScreen> {
  int _activeStep = 0;
  final _formKey = GlobalKey<FormState>();
  bool get _isEdit => widget.editEmployee != null;

  // Step 1: Personal
  final _empIdCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _middleNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  String? _gender;
  String? _bloodGroup;
  String? _maritalStatus;
  final _nationalityCtrl = TextEditingController(text: 'Indian');
  final _religionCtrl = TextEditingController();
  final _fatherNameCtrl = TextEditingController();
  final _spouseNameCtrl = TextEditingController();

  // Step 2: Employment
  final _workEmailCtrl = TextEditingController();
  final _dojCtrl = TextEditingController();
  String? _employmentType = 'Permanent';
  String? _departmentId;
  String? _designationId;
  String? _gradeId;
  String? _workLocationId;
  String? _costCenterId;
  String? _reportingManagerId;

  // Step 3: Contact & Identity
  final _personalEmailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _altPhoneCtrl = TextEditingController();
  final _panCtrl = TextEditingController();
  final _aadhaarCtrl = TextEditingController();
  final _passportCtrl = TextEditingController();
  final _passportExpiryCtrl = TextEditingController();
  final _voterIdCtrl = TextEditingController();
  final _dlCtrl = TextEditingController();
  final _dlExpiryCtrl = TextEditingController();
  final _uanCtrl = TextEditingController();
  final _esiCtrl = TextEditingController();

  static const _steps = ['Personal Information', 'Employment Details', 'Contact & Identity'];
  static const _genders = ['Male', 'Female', 'Other'];
  static const _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  static const _maritalStatuses = ['Single', 'Married', 'Divorced', 'Widowed'];
  static const _empTypes = ['Permanent', 'Contract', 'Intern', 'Consultant', 'Probation'];

  @override
  void initState() {
    super.initState();
    if (_isEdit) _prefillForm();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmployeeProvider>().fetchEmployeeLookup();
    });
  }

  void _prefillForm() {
    final e = widget.editEmployee!;
    _empIdCtrl.text = e.employeeId;
    _firstNameCtrl.text = e.firstName;
    _middleNameCtrl.text = e.middleName ?? '';
    _lastNameCtrl.text = e.lastName;
    _dobCtrl.text = e.dateOfBirth ?? '';
    _gender = e.gender;
    _bloodGroup = e.bloodGroup;
    _maritalStatus = e.maritalStatus;
    _nationalityCtrl.text = e.nationality ?? 'Indian';
    _religionCtrl.text = e.religion ?? '';
    _fatherNameCtrl.text = e.fatherName ?? '';
    _spouseNameCtrl.text = e.spouseName ?? '';
    _workEmailCtrl.text = e.workEmail;
    _dojCtrl.text = e.dateOfJoining ?? '';
    _employmentType = e.employmentType ?? 'Permanent';
    _departmentId = e.departmentId;
    _designationId = e.designationId;
    _gradeId = e.gradeId;
    _workLocationId = e.workLocationId;
    _costCenterId = e.costCenterId;
    _reportingManagerId = e.reportingManagerId;
    _personalEmailCtrl.text = e.personalEmail ?? '';
    _mobileCtrl.text = e.mobileNumber;
    _altPhoneCtrl.text = e.alternatePhone ?? '';
    _panCtrl.text = e.panNumber ?? '';
    _aadhaarCtrl.text = e.aadhaarNumber ?? '';
    _passportCtrl.text = e.passportNumber ?? '';
    _passportExpiryCtrl.text = e.passportExpiry ?? '';
    _voterIdCtrl.text = e.voterId ?? '';
    _dlCtrl.text = e.drivingLicense ?? '';
    _dlExpiryCtrl.text = e.dlExpiry ?? '';
    _uanCtrl.text = e.uanNumber ?? '';
    _esiCtrl.text = e.esiNumber ?? '';
  }

  @override
  void dispose() {
    for (final c in [_empIdCtrl, _firstNameCtrl, _middleNameCtrl, _lastNameCtrl, _dobCtrl, _nationalityCtrl, _religionCtrl, _fatherNameCtrl, _spouseNameCtrl, _workEmailCtrl, _dojCtrl, _personalEmailCtrl, _mobileCtrl, _altPhoneCtrl, _panCtrl, _aadhaarCtrl, _passportCtrl, _passportExpiryCtrl, _voterIdCtrl, _dlCtrl, _dlExpiryCtrl, _uanCtrl, _esiCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  Map<String, dynamic> _buildPayload() {
    String? nullIfEmpty(String s) => s.isEmpty ? null : s;
    return {
      'employeeId': _empIdCtrl.text,
      'firstName': _firstNameCtrl.text,
      'middleName': nullIfEmpty(_middleNameCtrl.text),
      'lastName': _lastNameCtrl.text,
      'dateOfBirth': nullIfEmpty(_dobCtrl.text),
      'gender': _gender,
      'bloodGroup': _bloodGroup,
      'maritalStatus': _maritalStatus,
      'nationality': _nationalityCtrl.text,
      'religion': nullIfEmpty(_religionCtrl.text),
      'fatherName': nullIfEmpty(_fatherNameCtrl.text),
      'spouseName': nullIfEmpty(_spouseNameCtrl.text),
      'workEmail': _workEmailCtrl.text,
      'dateOfJoining': nullIfEmpty(_dojCtrl.text),
      'employmentType': _employmentType,
      'departmentId': _departmentId,
      'designationId': _designationId,
      'gradeId': _gradeId,
      'workLocationId': _workLocationId,
      'costCenterId': _costCenterId,
      'reportingManagerId': _reportingManagerId,
      'personalEmail': nullIfEmpty(_personalEmailCtrl.text),
      'mobileNumber': _mobileCtrl.text,
      'alternatePhone': nullIfEmpty(_altPhoneCtrl.text),
      'panNumber': nullIfEmpty(_panCtrl.text),
      'aadhaarNumber': nullIfEmpty(_aadhaarCtrl.text),
      'passportNumber': nullIfEmpty(_passportCtrl.text),
      'passportExpiry': nullIfEmpty(_passportExpiryCtrl.text),
      'voterId': nullIfEmpty(_voterIdCtrl.text),
      'drivingLicense': nullIfEmpty(_dlCtrl.text),
      'dlExpiry': nullIfEmpty(_dlExpiryCtrl.text),
      'uanNumber': nullIfEmpty(_uanCtrl.text),
      'esiNumber': nullIfEmpty(_esiCtrl.text),
    };
  }

  Future<void> _submit() async {
    final provider = Provider.of<EmployeeProvider>(context, listen: false);
    final data = _buildPayload();
    bool success;

    if (_isEdit) {
      data['id'] = widget.editEmployee!.id;
      success = await provider.updateEmployee(widget.editEmployee!.id, data);
    } else {
      success = await provider.createEmployee(data);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(success ? (_isEdit ? 'Employee updated!' : 'Employee created!') : 'Operation failed'),
        backgroundColor: success ? Colors.green : Colors.red,
      ));
      if (success) Navigator.pop(context);
    }
  }

  Future<void> _pickDate(TextEditingController ctrl) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2040),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(colorScheme: const ColorScheme.dark(primary: Color(0xFF6366F1), surface: Color(0xFF1E293B), onSurface: Colors.white)),
        child: child!,
      ),
    );
    if (picked != null) {
      ctrl.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(_isEdit ? 'Edit Employee' : 'Add New Employee', style: const TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Stepper header
            _buildStepperHeader(),
            // Form body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: _buildStepContent(),
                ),
              ),
            ),
            // Navigation buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: List.generate(_steps.length, (i) {
          final isActive = i == _activeStep;
          final isCompleted = i < _activeStep;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? const Color(0xFF22C55E) : isActive ? const Color(0xFF6366F1) : Colors.white.withValues(alpha: 0.1),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : Text('${i + 1}', style: TextStyle(color: isActive ? Colors.white : Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    _steps[i],
                    style: TextStyle(fontSize: 11, color: isActive ? Colors.white : Colors.white54, fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (i < _steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: isCompleted ? const Color(0xFF22C55E) : Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_activeStep) {
      case 0: return _buildPersonalInfo();
      case 1: return _buildEmploymentDetails();
      case 2: return _buildContactIdentity();
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildPersonalInfo() {
    return Column(
      children: [
        Row(children: [Expanded(child: _buildTextField(_empIdCtrl, 'Employee ID *')), const SizedBox(width: 12), Expanded(child: _buildTextField(_firstNameCtrl, 'First Name *'))]),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: _buildTextField(_middleNameCtrl, 'Middle Name')), const SizedBox(width: 12), Expanded(child: _buildTextField(_lastNameCtrl, 'Last Name *'))]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _buildDateField(_dobCtrl, 'Date of Birth')),
          const SizedBox(width: 12),
          Expanded(child: _buildDropdown('Gender *', _gender, _genders, (v) => setState(() => _gender = v))),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _buildDropdown('Blood Group', _bloodGroup, _bloodGroups, (v) => setState(() => _bloodGroup = v))),
          const SizedBox(width: 12),
          Expanded(child: _buildDropdown('Marital Status', _maritalStatus, _maritalStatuses, (v) => setState(() => _maritalStatus = v))),
        ]),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: _buildTextField(_nationalityCtrl, 'Nationality *')), const SizedBox(width: 12), Expanded(child: _buildTextField(_religionCtrl, 'Religion'))]),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: _buildTextField(_fatherNameCtrl, "Father's Name")), const SizedBox(width: 12), Expanded(child: _buildTextField(_spouseNameCtrl, 'Spouse Name'))]),
      ],
    );
  }

  Widget _buildEmploymentDetails() {
    return Consumer2<OrganizationProvider, EmployeeProvider>(
      builder: (context, org, emp, _) {
        return Column(
          children: [
            Row(children: [
              Expanded(child: _buildTextField(_workEmailCtrl, 'Work Email *')),
              const SizedBox(width: 12),
              Expanded(child: _buildDateField(_dojCtrl, 'Date of Joining *')),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _buildCustomDropdown('Department', _departmentId, org.departments.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name, overflow: TextOverflow.ellipsis))).toList(), (v) => setState(() => _departmentId = v))),
              const SizedBox(width: 12),
              Expanded(child: _buildCustomDropdown('Designation', _designationId, org.designations.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name, overflow: TextOverflow.ellipsis))).toList(), (v) => setState(() => _designationId = v))),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _buildCustomDropdown('Grade', _gradeId, org.grades.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name, overflow: TextOverflow.ellipsis))).toList(), (v) => setState(() => _gradeId = v))),
              const SizedBox(width: 12),
              Expanded(child: _buildCustomDropdown('Work Location', _workLocationId, org.workLocations.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name, overflow: TextOverflow.ellipsis))).toList(), (v) => setState(() => _workLocationId = v))),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _buildCustomDropdown('Cost Center', _costCenterId, org.costCenters.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name, overflow: TextOverflow.ellipsis))).toList(), (v) => setState(() => _costCenterId = v))),
              const SizedBox(width: 12),
              Expanded(child: _buildCustomDropdown('Reporting Manager', _reportingManagerId, emp.employeeLookup.map((d) => DropdownMenuItem(value: d.id, child: Text(d.displayName ?? '${d.firstName} ${d.lastName}', overflow: TextOverflow.ellipsis))).toList(), (v) => setState(() => _reportingManagerId = v))),
            ]),
            const SizedBox(height: 12),
            _buildDropdown('Employment Type *', _employmentType, _empTypes, (v) => setState(() => _employmentType = v)),
          ],
        );
      }
    );
  }

  Widget _buildContactIdentity() {
    return Column(
      children: [
        Row(children: [Expanded(child: _buildTextField(_personalEmailCtrl, 'Personal Email')), const SizedBox(width: 12), Expanded(child: _buildTextField(_mobileCtrl, 'Mobile Number *'))]),
        const SizedBox(height: 12),
        _buildTextField(_altPhoneCtrl, 'Alternate Phone'),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: _buildTextField(_panCtrl, 'PAN Number')), const SizedBox(width: 12), Expanded(child: _buildTextField(_aadhaarCtrl, 'Aadhaar Number'))]),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: _buildTextField(_passportCtrl, 'Passport Number')), const SizedBox(width: 12), Expanded(child: _buildDateField(_passportExpiryCtrl, 'Passport Expiry'))]),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: _buildTextField(_voterIdCtrl, 'Voter ID')), const SizedBox(width: 12), Expanded(child: _buildTextField(_dlCtrl, 'Driving License'))]),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: _buildDateField(_dlExpiryCtrl, 'DL Expiry')), const SizedBox(width: 12), Expanded(child: _buildTextField(_uanCtrl, 'UAN Number'))]),
        const SizedBox(height: 12),
        _buildTextField(_esiCtrl, 'ESI Number'),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: _activeStep > 0 ? () => setState(() => _activeStep--) : null,
            child: const Text('Back'),
          ),
          Row(
            children: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              const SizedBox(width: 8),
              if (_activeStep < _steps.length - 1)
                ElevatedButton(
                  onPressed: () => setState(() => _activeStep++),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('Next', style: TextStyle(fontWeight: FontWeight.bold)),
                )
              else
                Consumer<EmployeeProvider>(
                  builder: (context, provider, _) {
                    return ElevatedButton(
                      onPressed: provider.isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: provider.isLoading
                          ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : Text(_isEdit ? 'Update' : 'Create Employee', style: const TextStyle(fontWeight: FontWeight.bold)),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String label) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF6366F1))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Widget _buildDateField(TextEditingController ctrl, String label) {
    return TextField(
      controller: ctrl,
      readOnly: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
        suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF6366F1), size: 16),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF6366F1))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      onTap: () => _pickDate(ctrl),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items, ValueChanged<String?> onChanged) {
    return _buildCustomDropdown(
      label, 
      value, 
      items.map((s) => DropdownMenuItem(value: s, child: Text(s, overflow: TextOverflow.ellipsis))).toList(), 
      onChanged
    );
  }

  Widget _buildCustomDropdown(String label, String? value, List<DropdownMenuItem<String>> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: const Color(0xFF1E293B),
      style: const TextStyle(color: Colors.white, fontSize: 13),
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF6366F1))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: [
        const DropdownMenuItem<String>(value: null, child: Text('None', style: TextStyle(color: Colors.white54))),
        ...items,
      ],
      onChanged: onChanged,
    );
  }
}
