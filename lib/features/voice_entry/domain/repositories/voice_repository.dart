import '../models/voice_draft.dart';

abstract class VoiceRepository {
  /// Sends a spoken transcript to the backend, which uses an LLM to normalize it
  /// into a ledger draft for the given link. [language] is the app locale hint.
  Future<VoiceDraft> parse({
    required String linkId,
    required String transcript,
    String? language,
  });
}
