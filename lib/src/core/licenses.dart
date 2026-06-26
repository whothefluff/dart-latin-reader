import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bundled_fonts.dart';

void registerLicenses() {
  registerFontLicenses();
}

void registerFontLicenses() {
  LicenseRegistry.addLicense(
    () => Stream.fromIterable(bundledFonts).asyncMap(
      (f) async => LicenseEntryWithLineBreaks(['fonts'], await rootBundle.loadString(f.oflPath)),
    ),
  );
}
