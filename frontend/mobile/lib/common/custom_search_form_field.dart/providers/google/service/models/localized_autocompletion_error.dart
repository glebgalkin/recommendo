import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recommendo/common/custom_search_form_field.dart/internal/models/search_result_error.dart';

class LocalizedAutocompletionError extends SearchResultError {
  final String? code;

  const LocalizedAutocompletionError({this.code});

  @override
  String localizedError(AppLocalizations l10n) {
    return switch (code) {
      invalidRequest => l10n.autoCompleteErrorInvalidRequest,
      overQueryLimit => l10n.autoCompleteErrorOverQueryLimit,
      requestDenied => l10n.autoCompleteErrorRequestDenied,
      googleUnknown => l10n.autoCompleteErrorUnknownError,
      networkError => l10n.defaultNetworErrorMessage,
      unknown => l10n.defaultErrorMessage,
      _ => l10n.defaultErrorMessage,
    };
  }
}

const invalidRequest = 'invalidRequest';
const overQueryLimit = 'overQueryLimit';
const requestDenied = 'requestDenied';
const googleUnknown = 'googleUnknown';
const networkError = 'networkError';
const unknown = 'unknown';
