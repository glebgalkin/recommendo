import 'package:recommendo/common/custom_search_form_field.dart/internal/models/search_result_error.dart';
import 'package:recommendo/l10n/l10n.dart';

class GoogleAutoCompleteError extends SearchResultError {
  final String code;

  const GoogleAutoCompleteError(this.code);

  @override
  String localizedError(AppLocalizations l10n) {
    return switch (code) {
      invalidRequest => l10n.autoCompleteErrorInvalidRequest,
      overQueryLimit => l10n.autoCompleteErrorOverQueryLimit,
      requestDenied => l10n.autoCompleteErrorRequestDenied,
      googleUnknown => l10n.autoCompleteErrorUnknownError,
      networkError => l10n.autoCompleteNetworkError,
      unknown => l10n.autoCompleteUnknownError,
      _ => l10n.autoCompleteUnknownError,
    };
  }
}

const invalidRequest = 'auto-complete-error-invalid-request';
const overQueryLimit = 'auto-complete-error-over-query-limit';
const requestDenied = 'auto-complete-error-request-denied';
const googleUnknown = 'auto-complete-error-unknown-error';
const networkError = 'auto-complete-network-error';
const unknown = 'auto-complete-unknown-error';
