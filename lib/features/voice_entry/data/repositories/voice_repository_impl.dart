import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/models/voice_draft.dart';
import '../../domain/repositories/voice_repository.dart';

class VoiceRepositoryImpl implements VoiceRepository {
  final ApiClient _api;

  VoiceRepositoryImpl(this._api);

  @override
  Future<VoiceDraft> parse({
    required String linkId,
    required String transcript,
    String? language,
  }) async {
    try {
      final body = <String, dynamic>{'transcript': transcript};
      if (language != null && language.isNotEmpty) body['language'] = language;
      final response = await _api.post(
        ApiEndpoints.parseVoice(linkId),
        data: body,
      );
      return VoiceDraft.fromJson(ApiClient.extractData(response));
    } on DioException catch (e) {
      throw Exception(ApiClient.extractErrorMessage(e));
    }
  }
}
