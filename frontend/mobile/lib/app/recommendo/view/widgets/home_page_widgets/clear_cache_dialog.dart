import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recommendo/app/recommendo/service/recommendations_service.dart';
import 'package:recommendo/common/localized_error_text.dart';
import 'package:recommendo/l10n/l10n.dart';
import 'package:recommendo/service_locator/service_locator.dart';

class ClearCacheDialog extends StatelessWidget {
  const ClearCacheDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final content = FutureBuilder(
      future: getIt<RecommendationService>().getCacheSize(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data.error != null) {
            final errorMsg = localizedErrorText(data.error!.code, l10n);
            return Text(errorMsg);
          } else {
            final size = formatBytes(data.result!, 2);
            return Text(l10n.clearCacheDialogContent(size));
          }
        } else if (snapshot.hasError) {
          return Text(l10n.clearCacheDialogContentError);
        } else {
          return Text(l10n.clearCacheDialogContentLoading);
        }
      },
    );

    return AlertDialog(
      title: Text(l10n.clearCacheDialogTitle),
      content: content,
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(l10n.clearFormDialogCancel),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(
            l10n.clearFormDialogConfirm,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ],
    );
  }

  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
