import 'package:flutter/material.dart';
import 'package:recommendo/common/localized_error_text.dart';
import 'package:recommendo/l10n/l10n.dart';

class RecommendationsListBottomFailure extends StatelessWidget {
  const RecommendationsListBottomFailure({
    this.code,
    super.key,
  });

  final LocalizedErrorMessage? code;

  @override
  Widget build(BuildContext context) {
    final errorMsg = localizedErrorText(
      code ?? LocalizedErrorMessage.defaultSearchErrorMsg,
      context.l10n,
    );
    return ListTile(
      title: Text(errorMsg),
    );
  }
}
