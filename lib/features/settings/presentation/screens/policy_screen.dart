import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/di/injection.dart';
import '../../../../l10n/app_localizations.dart';

class PolicyScreen extends StatefulWidget {
  final String title;
  final String endpoint;

  const PolicyScreen({
    super.key,
    required this.title,
    required this.endpoint,
  });

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  String? _content;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchContent();
  }

  Future<void> _fetchContent() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      final response = await getIt<ApiClient>().get(widget.endpoint);
      final data = response.data['data'] as Map<String, dynamic>?;
      setState(() {
        _content = data?['content'] as String? ?? '';
        _isLoading = false;
      });
    } on DioException {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(child: _buildBody(l10n)),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded,
                  size: 48, color: AppColors.error),
              const SizedBox(height: 12),
              Text(l10n.failedToLoad,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _fetchContent,
                child: Text(l10n.tryAgain),
              ),
            ],
          ),
        ),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Text(
        _content ?? '',
        style: AppTypography.bodyMedium.copyWith(height: 1.7),
      ),
    );
  }
}
