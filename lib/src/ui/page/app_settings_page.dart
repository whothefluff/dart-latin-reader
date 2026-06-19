import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../component/settings/app_settings_api.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the [AppSettingsNotifier] is updated and
/// Widgets that listen to [appSettingsNotifierProvider] are rebuilt.
class AppSettingsPage extends ConsumerWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: ref
        .watch(appSettingsNotifierProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (settings) => Padding(
            padding: const EdgeInsets.all(16),
            // Glue the appSettingsNotifierProvider to the theme selection DropdownButton.
            //
            // When a user selects a theme from the dropdown list, the
            // AppSettingsNotifier is updated, which  rebuilds the MaterialApp.
            child: DropdownButton<ThemeMode>(
              // Read the selected themeMode from the provider's state
              value: settings.themeMode,
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: (mode) async {
                if (mode != null) {
                  await ref.read(appSettingsNotifierProvider.notifier).updateThemeMode(mode);
                }
              },
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('System Theme')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light Theme')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark Theme')),
              ],
            ),
          ),
        ),
  );
}
