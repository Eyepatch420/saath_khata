import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../network/api_client.dart';

/// Compresses a local image and uploads it as a ledger attachment.
///
/// For the upload-first flow (no entry yet), pass [entryId] as null —
/// the backend stores it under a temp folder and returns the Cloudinary URL,
/// which Flutter then embeds in the POST /entries body.
///
/// For the attach-later flow, pass the known [entryId] — the backend overwrites
/// the entry's attachment_url and emits ledger:entry_updated via socket.
class LedgerAttachmentService {
  final ApiClient _api;

  LedgerAttachmentService(this._api);

  Future<String> uploadAttachment({
    required File imageFile,
    required String linkId,
    String? entryId,
  }) async {
    // Compress locally before upload — reduces data usage on slow connections
    final compressedBytes = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      quality: 75,
      minWidth: 100,
      minHeight: 100,
      keepExif: false,
    );

    if (compressedBytes == null) throw Exception('Image compression failed');

    final filename = entryId != null
        ? 'entry_$entryId.jpg'
        : 'temp_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        compressedBytes,
        filename: filename,
        contentType: DioMediaType('image', 'jpeg'),
      ),
    });

    final endpoint = entryId != null
        ? '/links/$linkId/entries/$entryId/attachment'
        : '/links/$linkId/entries/attachment/temp';

    final response = await _api.patch(endpoint, data: formData);
    final data = ApiClient.extractData(response);
    return data['attachmentUrl'] as String;
  }
}
