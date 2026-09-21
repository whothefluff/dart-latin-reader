import 'package:flutter/material.dart';

/// A [Scaffold] that keeps its body inside the usable screen area
/// (clear of system bars and display cutouts)
///
/// If an [AppBar] is present, it already handles the top inset, so the body
/// only needs padding on the remaining exposed edges
///
/// Use this instead of [Scaffold] for app pages
class SafeBodyScaffold extends StatelessWidget {
  const SafeBodyScaffold({
    super.key,
    required this.body,
    this.appBar,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(context) => Scaffold(
    appBar: appBar,
    body: SafeArea(
      top: appBar == null,
      child: body,
    ),
  );

  //
}
