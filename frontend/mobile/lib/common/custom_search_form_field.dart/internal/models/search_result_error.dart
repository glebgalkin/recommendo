import 'package:recommendo/l10n/l10n.dart';

abstract class SearchResultError implements Exception {
  const SearchResultError();
  String localizedError(AppLocalizations l10n);
}
