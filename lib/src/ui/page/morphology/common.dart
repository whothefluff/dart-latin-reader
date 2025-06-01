// ignore_for_file: avoid_annotating_with_dynamic, avoid_dynamic_calls
({String title, String dictRef, String? pos, String? add}) Function(dynamic r)
    consolidatedForm() => (r) => (
          title: r.macronizedForm ?? r.form,
          dictRef: r.dictionaryRef,
          pos: r.partOfSpeech,
          add: r.additional,
        );
