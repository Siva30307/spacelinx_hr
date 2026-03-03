import '../../core/api/api_client.dart';

abstract class BaseRepository {
  final ApiClient apiClient;

  BaseRepository(this.apiClient);
}
