import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../external/provider_ext.dart';

Widget Function(Object error, StackTrace _) showError(
  WidgetRef ref,
  ProviderBase<Object> provider,
) =>
    (e, _) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(e.toString()),
          TextButton(
            onPressed: () =>
                ProviderScope.containerOf(ref.context, listen: false).retryFailures(provider),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
