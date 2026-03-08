import 'package:spacelinx_hr/data/models/organization_models.dart';
import 'package:spacelinx_hr/core/api/api_client.dart';

class OrganizationRepository {
  final ApiClient _apiClient;

  OrganizationRepository(this._apiClient);

  Future<List<DepartmentRefModel>> getDepartmentLookup() async {
    final response = await _apiClient.get('/Department/Lookup');
    return (response.data as List).map((e) => DepartmentRefModel.fromJson(e)).toList();
  }

  Future<List<DesignationRefModel>> getDesignationLookup() async {
    final response = await _apiClient.get('/Designation/Lookup');
    return (response.data as List).map((e) => DesignationRefModel.fromJson(e)).toList();
  }

  Future<List<GradeRefModel>> getGradeLookup() async {
    final response = await _apiClient.get('/Grade/Lookup');
    return (response.data as List).map((e) => GradeRefModel.fromJson(e)).toList();
  }

  Future<List<CostCenterRefModel>> getCostCenterLookup() async {
    final response = await _apiClient.get('/CostCenter/Lookup');
    return (response.data as List).map((e) => CostCenterRefModel.fromJson(e)).toList();
  }

  Future<List<WorkLocationRefModel>> getWorkLocationLookup() async {
    final response = await _apiClient.get('/WorkLocation/Lookup');
    return (response.data as List).map((e) => WorkLocationRefModel.fromJson(e)).toList();
  }
}
