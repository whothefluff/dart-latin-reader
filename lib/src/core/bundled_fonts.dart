import 'dart:collection';

const Set<String> _fontFamilyNames = {
  'EB Garamond',
  'Cardo',
  'Gentium Book Plus',
  'Alegreya',
  'Lora',
  'Source Serif 4',
  'Spectral',
  'Bitter',
  'Literata',
  'Crimson Pro',
  'Source Sans 3',
  'Atkinson Hyperlegible',
  'Libre Baskerville',
  'Merriweather',
};

typedef BundledFonts = UnmodifiableSetView<({String oflPath, String family})>;

final BundledFonts bundledFonts = UnmodifiableSetView(
  _fontFamilyNames
      .map(
        (name) => (
          family: name,
          oflPath: 'assets/google_fonts/${name.replaceAll(' ', '')}-OFL.txt',
        ),
      )
      .toSet(),
);
