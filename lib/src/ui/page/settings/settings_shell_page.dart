import 'package:flutter/material.dart';

import '../../router/config.dart';
import '../../widget/custom_adaptive_scaffold.dart';
import 'general_settings_page.dart';
import 'library_settings_page.dart';

class SettingsShellPage extends StatefulWidget {
  const SettingsShellPage({
    super.key,
    required this.tab,
  });

  final String tab;

  @override
  State<SettingsShellPage> createState() => _SettingsShellPageState();
  //
}

class _SettingsShellPageState extends State<SettingsShellPage> {
  //
  late int _currentIndex;
  late final List<String> _tabIds;
  static const Map<String, Widget> implementedPages = {
    SettingsTab.library: LibrarySettingsPage(),
  };

  /// Translates the overall shell index into the inner NavigationBar's index space.
  ///
  /// NavigationBar asserts selectedIndex >= 0. We map "General" (shell 0) to bar 0,
  /// creating a phantom selection hidden by the transparent-indicator trick below.
  int _barIndexFromShell(int shellIndex) => shellIndex <= 0 ? 0 : shellIndex - 1;

  /// Translates the inner NavigationBar's index back to the overall shell index space.
  ///
  /// The bar skips the 0th item ("General"), so its index 0 is our shell index 1.
  int _shellIndexFromBar(int barIndex) => barIndex + 1;

  List<NavigationDestination> get _destinations => [
    const NavigationDestination(icon: Icon(Icons.settings), label: 'General'),
    ...mainBranches.map((b) {
      final id = _extractId(b.id);
      final isEnabled = implementedPages.containsKey(id);
      return NavigationDestination(
        icon: b.navDest.icon,
        selectedIcon: b.navDest.selectedIcon,
        label: b.navDest.label,
        tooltip: isEnabled ? b.navDest.tooltip : 'Not available',
        enabled: isEnabled,
      );
    }),
  ];

  @override
  void initState() {
    super.initState();
    _tabIds = [
      'general',
      ...mainBranches.map((b) => _extractId(b.id)),
    ];
    _currentIndex = _tabIds.indexOf(widget.tab).clamp(0, _tabIds.length - 1);
  }

  String _extractId(String path) => path.replaceAll('/', '');

  @override
  Widget build(context) => CustomAdaptiveScaffold(
    useDrawer: false,
    selectedIndex: _currentIndex,
    onSelectedIndexChange: (i) => setState(() => _currentIndex = i),
    destinations: _destinations,
    bottomNavigationBarBuilder: _bottomBar,
    body: (ctx) => _buildBody(ctx, _tabIds[_currentIndex]),
  );

  Widget _bottomBar(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final navTheme = Theme.of(context).navigationBarTheme;
    final generalSelected = _currentIndex == 0;
    return IntrinsicHeight(
      child: Material(
        color: navTheme.backgroundColor ?? cs.surfaceContainer,
        child: SafeArea(
          child: Row(
            children: [
              // Bespoke item (icon + label to the right, always visible)
              _generalItem(
                cs,
                _destinations.first,
                selected: generalSelected,
                onTap: () => setState(() => _currentIndex = 0),
              ),
              // Mirrored tabs, drawn by the real NavigationBar
              Expanded(
                child: NavigationBarTheme(
                  data: navTheme.copyWith(
                    // The NavigationBar asserts that selectedIndex is >= 0, so we can't
                    // just pass -1 when the bespoke "General" item is active. Instead, we
                    // pass 0 (via _barIndexFromShell) and set the indicator to transparent
                    // to suppress the phantom selection.
                    indicatorColor: generalSelected ? Colors.transparent : navTheme.indicatorColor,
                  ),
                  child: NavigationBar(
                    selectedIndex: _barIndexFromShell(_currentIndex),
                    destinations: _destinations.skip(1).toList(),
                    onDestinationSelected: (i) => setState(
                      () => _currentIndex = _shellIndexFromBar(i),
                    ),
                    // Hide the selected label when General is active.
                    labelBehavior: generalSelected
                        ? NavigationDestinationLabelBehavior.alwaysHide
                        : NavigationDestinationLabelBehavior.onlyShowSelected,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _generalItem(
    ColorScheme cs,
    NavigationDestination d, {
    required bool selected,
    required VoidCallback onTap,
  }) {
    final fg = selected ? cs.onSecondaryContainer : cs.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Material(
          color: selected ? cs.secondaryContainer : Colors.transparent,
          shape: const StadiumBorder(),
          clipBehavior: Clip.antiAlias, // ripple clipped to the pill
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconTheme.merge(
                    data: IconThemeData(color: fg),
                    child: d.icon,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    d.label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: fg,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, String tabId) => (tabId == 'general')
      ? const GeneralSettingsPage()
      : implementedPages[tabId] ?? _unimplementedPage(tabId);

  Widget _unimplementedPage(String tabId) {
    final branch = mainBranches.where((b) => _extractId(b.id) == tabId).firstOrNull;
    final title = branch?.navDest.label ?? 'Settings';
    return Scaffold(
      appBar: AppBar(title: Text('$title Settings')),
      body: Center(child: Text('$title not implemented')),
    );
  }

  //
}

abstract final class SettingsTab {
  //
  static const general = 'general';

  static const String library = libraryId;

  static const String dictionaries = dictionariesId;

  static const String wordFrequency = wordFrequencyId;

  static const String morphAnalysis = morphAnalysisId;

  static const String wordLookup = wordLookupId;
  //
}
