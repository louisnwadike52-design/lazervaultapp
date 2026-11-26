import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE EVENT BROWSE AXES COME FROM THE ADMIN DASHBOARD, NEVER FROM THE APP.
///
/// The operator asked for categories and all 36 states (plus the FCT) to be
/// editable settings with nothing hardcoded. The failure that would quietly
/// undo that is not a missing list — it is a convenient literal: a `const
/// _categories = [...]` added "just for now" becomes the one copy that cannot
/// follow the dashboard, and the organiser is then offered a category the
/// server refuses.
///
/// Asserted as source text because that is where the mistake lives. A
/// behavioural test would need a server to prove the negative.
void main() {
  String read(String p) => File(p).readAsStringSync();

  bool has(String haystack, String needle) {
    String flat(String s) =>
        s.replaceAll(RegExp(r'\s+'), '').replaceAll("''", '');
    return flat(haystack).contains(flat(needle));
  }

  /// Source with the comment lines removed.
  ///
  /// THE LITERAL CHECKS BELOW MUST IGNORE PROSE. The comments explaining why
  /// the lists are settings naturally say "Comedy in Lagos" — that is the
  /// example the whole feature exists for — and a raw search then fails on
  /// the explanation rather than on a hardcoded list. The invariant is about
  /// CODE: no category or state name may be compiled into the app.
  String code(String src) =>
      src.split('\n').where((l) => !l.trimLeft().startsWith('//')).join('\n');

  /// Everything under a directory, concatenated.
  ///
  /// READ AS A FEATURE, NOT AS ONE FILE. These assertions were written
  /// against a 1,100-line `create_event_screen.dart`; splitting it into a
  /// form cubit and four step widgets broke nine of them while every
  /// invariant they protect was still true. A guard that has to be rewritten
  /// whenever code is reorganised gets deleted during the reorganisation,
  /// which is exactly when it is most needed.
  String readTree(String dir) {
    final out = StringBuffer();
    for (final f in Directory(dir).listSync(recursive: true)) {
      if (f is File && f.path.endsWith('.dart')) {
        out.writeln(f.readAsStringSync());
      }
    }
    return out.toString();
  }

  /// The create wizard: the shell, the form model, the steps.
  final create = readTree(
          'lib/src/features/ticketing/presentation/screens/create_event_steps') +
      read('lib/src/features/ticketing/presentation/screens/'
          'create_event_screen.dart') +
      read('lib/src/features/ticketing/presentation/cubit/'
          'create_event_form_cubit.dart');

  /// The SHARED axis helpers — one file, three callers.
  ///
  /// Asserted here rather than on each screen, which is the improvement
  /// that broke the original assertions: the option mapping and the label
  /// lookup existed in three copies (the wizard, the edit screen and the
  /// catalogue's filter chips) and now exist once. One place to check is
  /// the whole point of having moved them.
  final axis = read('lib/src/features/ticketing/presentation/widgets/'
      'event_axis_field.dart');

  final events = read('lib/src/features/ticketing/presentation/screens/'
      'events_screen.dart');
  final repo =
      read('lib/src/features/ticketing/data/ticketing_repository.dart');

  group('the lists are the server config, not app literals', () {
    test('both pickers read the config', () {
      expect(has(axis, 'for (final o in raw) (value: o.slug, label: o.label)'),
          isTrue);
      expect(
          has(create, 'axisOptions(config?.categories ?? const [])'), isTrue);
      expect(has(create, 'axisOptions(config?.states ?? const [])'), isTrue);
    });

    test('the landing chips read the config too', () {
      expect(
          has(events, 'axisOptions(_config?.categories ?? const [])'), isTrue);
      expect(has(events, 'axisOptions(_config?.states ?? const [])'), isTrue);
    });

    test('no Nigerian state is named in the app at all', () {
      // The giveaway for a hardcoded list. Any one of these appearing in a
      // ticketing source file means somebody wrote the list out rather than
      // reading it — and the FCT plus 36 states is a long enough list that
      // the temptation is real.
      for (final file in {
        'create_event_screen.dart': code(create),
        'events_screen.dart': code(events),
        'ticketing_repository.dart': code(repo),
      }.entries) {
        for (final state in [
          'Akwa Ibom',
          'Cross River',
          'Nasarawa',
          'Zamfara',
          'Jigawa',
        ]) {
          expect(file.value.contains(state), isFalse,
              reason: '${file.key} names the state "$state" — the list is a '
                  'system setting so the operator can add and remove them, '
                  'and a copy here is the one that cannot follow');
        }
      }
    });

    test('no category is named in the app either', () {
      for (final cat in ['Comedy', 'Music & Concerts', 'Gaming & Esports']) {
        expect(code(create).contains(cat), isFalse,
            reason: 'the create screen names the category "$cat"');
        expect(code(events).contains(cat), isFalse,
            reason: 'the events screen names the category "$cat"');
      }
    });
  });

  group('slugs travel, labels are only rendered', () {
    test('the chosen value is stored as a slug', () {
      // An operator may re-word a label at any time; an app holding labels
      // would send one the server no longer recognises.
      expect(has(axis, '(value: o.slug, label: o.label)'), isTrue);
      expect(has(axis, 'final ValueChanged<String> onPicked;'), isTrue,
          reason: 'the picker must hand back the slug, not the label');
    });

    test('an unknown slug falls back to the slug, not to blank', () {
      // Showing an empty picker over a value that IS set reads as the choice
      // having been lost.
      expect(has(axis, 'return slug;'), isTrue);
    });

    test('an empty list does not open a sheet', () {
      // Until the config read lands there is nothing to offer, and an empty
      // sheet reads as a broken feature.
      expect(has(axis, 'if (options.isEmpty) {'), isTrue);
      expect(has(axis, 'onUnavailable?.call();'), isTrue);
    });

    test('a dismissed sheet changes nothing', () {
      // Backing out of a picker is not a choice and must not clear a value
      // that was already set.
      expect(has(axis, 'if (picked == null) return;'), isTrue);
    });
  });

  group('the filters survive paging and refresh', () {
    test('every load goes through one place that carries them', () {
      expect(has(events, "category: _category ?? '',"), isTrue);
      expect(has(events, "state: _state ?? '',"), isTrue);
    });

    test('load-more re-enters that same place', () {
      // A footer that silently widens a filtered list back to the whole
      // catalogue is worse than no footer.
      expect(has(events, '_load(page: state.page + 1)'), isTrue);
    });

    test('changing a filter restarts at page one', () {
      // Keeping the page would ask for page three of a query that has just
      // changed, against a total for a different filter.
      final at = events.indexOf('Future<void> _pickAxis(');
      expect(at, greaterThan(-1));
      final body = events.substring(at, at + 1200);
      expect(has(body, '_load();'), isTrue);
      expect(body.contains('page:'), isFalse,
          reason: 'a filter change must not carry a page number');
    });
  });

  group('the wizard validates each step', () {
    test('the host and its socials are step two', () {
      // The operator asked for this specifically: the handles a buyer uses to
      // decide whether an event is real were buried behind a collapsed
      // expander in the middle of one long page.
      expect(has(create, '1 => EventHostStep(onContinue: _next),'), isTrue);
      expect(
          has(create,
              "static const _stepNames = ['Event', 'Host', 'Tickets', 'Confirm'];"),
          isTrue);
    });

    test('problems are returned per field, not as one banner', () {
      expect(has(create, 'Map<String, String> problemsFor(int step)'), isTrue);
      expect(code(create).contains('String? _validate()'), isFalse,
          reason: 'the whole-form validator reported one problem at a time '
              'in a banner at the bottom; it is replaced by the per-step map');
    });

    test('submission re-checks every step, not just the one on screen', () {
      // An organiser who walked back to step one and cleared the title would
      // otherwise submit it — the button they pressed was on a valid step.
      expect(has(create, 'final all = form.allProblems();'), isTrue);
      expect(has(create, 'if (problemsFor(i).isNotEmpty) return i;'), isTrue);
      expect(has(create, 'if (bad >= 0) {'), isTrue,
          reason: 'it must also LAND them on the step that is wrong');
      expect(has(create, 'form.revealProblems(bad);'), isTrue,
          reason: 'and REVEAL that step, or the organiser arrives at a page '
              'with nothing marked and a message about a field that looks '
              'fine');
    });

    test('back walks the wizard before leaving it', () {
      // At four steps a leading arrow that popped the screen would lose
      // everything typed.
      expect(has(create, 'if (_step > 0) {'), isTrue);
      expect(has(create, 'setState(() => _step -= 1);'), isTrue);
    });

    test('validation is shown when Continue is PRESSED, not on arrival', () {
      // REPLACES "the continue button is disabled while the step is
      // invalid", which pinned the wrong behaviour. `problemsFor` answers
      // "is this step complete", which is false the instant the form opens —
      // so painting it directly turned every required field red before a
      // character had been typed, and the button under them was dead. The
      // organiser met a form already telling them off, with nothing to press.
      //
      // Now the press is what asks: it reveals the step's problems and the
      // messages then stay live, clearing field by field as each is fixed.
      expect(has(create, 'form.revealProblems(_step);'), isTrue,
          reason: 'pressing Continue on an incomplete step must reveal it');
      expect(has(create, 'onPressed: onContinue,'), isTrue,
          reason: 'Continue must stay pressable — it is what reveals the '
              'problems, and a disabled button explains nothing');
      expect(has(create, 'final blocked = form.problemsFor(step).isNotEmpty;'),
          isFalse,
          reason: 'the disabled-while-invalid gate is gone');

      // The steps paint only what has been revealed. Checked per STEP INDEX
      // because `create` also contains the cubit, which legitimately defines
      // problemsFor — it is the step widgets calling it directly that painted
      // errors on arrival.
      expect(has(create, 'form.visibleProblemsFor(0)'), isTrue);
      expect(has(create, 'form.visibleProblemsFor(1)'), isTrue);
      expect(has(create, 'form.visibleProblemsFor(2)'), isTrue);
      for (final i in [0, 1, 2]) {
        expect(has(create, 'form.problemsFor($i)'), isFalse,
            reason: 'step $i still reads problemsFor directly, which is what '
                'painted its errors before anything was typed');
      }
    });
  });

  group('an empty filtered list says why', () {
    test('the message names what was filtered', () {
      // "No events are on sale right now" under an active Comedy-in-Lagos
      // filter is false about the catalogue.
      expect(has(events, 'String _emptyMessage()'), isTrue);
      expect(has(events, "return 'Nothing on sale for \${bits.join(' ')}.';"),
          isTrue);
    });

    test('and offers to clear them', () {
      expect(has(events, "retryLabel: _hasFilters ? 'Clear filters' : null"),
          isTrue);
      expect(has(events, 'void _clearFilters()'), isTrue);
    });
  });

  _sizeGuard();
  _closeSafetyGuard();
  _oneDesignLanguageGuard();
  _submissionCarriesEveryFieldGuard();
  _stepCountGuard();

  group('the form speaks the PiggyVault language', () {
    test('fields and progress come from the shared kit', () {
      expect(has(create, 'event_form_kit.dart'), isTrue);
      expect(
          has(create, 'EventStepProgress(current: _step, total: _totalSteps)'),
          isTrue);
      expect(has(create, 'EventFieldCard('), isTrue);
    });

    test('the kit owns the gradient, so no screen repeats it', () {
      // Ticketing arrived with thirteen of its own hex literals, two of them
      // wrong against the rest of the product. One kit, one definition.
      final kit = read('lib/src/features/ticketing/presentation/widgets/'
          'event_form_kit.dart');
      expect(kit.contains('0xFF2A2A3E'), isTrue);
      expect(code(create).contains('0xFF2A2A3E'), isFalse,
          reason: 'the field gradient belongs to the kit');
      expect(code(events).contains('0xFF2A2A3E'), isFalse);
    });
  });
}

/// THE SPLIT HAS TO STAY SPLIT.
///
/// `create_event_screen.dart` reached 1,100 lines by accretion — four step
/// bodies, the validation for all of them, the flyer upload, two date pickers
/// and the navigation, all private to one State class. Nothing warned; it was
/// noticed by counting.
///
/// The root guide's ceiling is 500 lines, aiming low. This holds the create
/// wizard to it, and names the shape to grow into instead: another step is
/// another file under `create_event_steps/`, and another field is a method on
/// the form cubit.
///
/// SCOPED TO THE FILES THIS WORK OWNS. Two older ticketing screens are over
/// the line and are not this test's business — widening it to the whole
/// feature would make somebody else's debt fail this build and the test would
/// be weakened to pass.
void _sizeGuard() {
  const ceiling = 500;
  const owned = [
    'lib/src/features/ticketing/presentation/screens/create_event_screen.dart',
    'lib/src/features/ticketing/presentation/screens/edit_event_screen.dart',
    'lib/src/features/ticketing/presentation/screens/events_screen.dart',
    'lib/src/features/ticketing/presentation/cubit/create_event_form_cubit.dart',
    'lib/src/features/ticketing/presentation/widgets/event_form_kit.dart',
    'lib/src/features/ticketing/presentation/widgets/event_option_sheet.dart',
    'lib/src/features/ticketing/presentation/widgets/event_axis_field.dart',
  ];

  test('no file in the create wizard passes the 500-line ceiling', () {
    for (final path in [
      ...owned,
      ...Directory(
              'lib/src/features/ticketing/presentation/screens/create_event_steps')
          .listSync()
          .whereType<File>()
          .map((f) => f.path),
    ]) {
      final n = File(path).readAsLinesSync().length;
      expect(n, lessThanOrEqualTo(ceiling),
          reason: '$path is $n lines. Split it by RESPONSIBILITY, not by '
              'line count: a step belongs in create_event_steps/, form state '
              'and validation belong on CreateEventFormCubit, and a reusable '
              'control belongs in the widget kit.');
    }
  });
}

/// THE HAZARD THE SPLIT CREATED, and the one-line guard that closes it.
///
/// Moving the form state into a cubit means a setter can be called after the
/// screen is gone: the organiser opens the 37-entry state picker, backs out of
/// the whole flow, and the sheet's future then completes and calls
/// `setStateSlug`. `emit` after `close` throws, so leaving a screen would
/// surface as a crash from a screen already left.
///
/// Pinned because the fix is invisible — one `if (isClosed) return;` that a
/// later refactor would not notice removing.
void _closeSafetyGuard() {
  test('the form cubit never emits after it is closed', () {
    final src = File('lib/src/features/ticketing/presentation/cubit/'
            'create_event_form_cubit.dart')
        .readAsStringSync();

    final at = src.indexOf('void _touch()');
    expect(at, greaterThan(-1), reason: '_touch was renamed');
    final body = src.substring(at, at + 160);
    expect(body.contains('if (isClosed) return;'), isTrue,
        reason: 'a picker or date sheet can outlive this screen; every setter '
            'funnels through _touch, so the guard belongs there rather than '
            'at eleven call sites');

    // And the async flyer path has to check too — it awaits twice.
    final flyer = src.indexOf('Future<void> pickFlyer()');
    expect(flyer, greaterThan(-1));
    final flyerBody = src.substring(flyer, src.indexOf('// ── DERIVED'));
    expect(flyerBody.split('isClosed').length - 1, greaterThanOrEqualTo(3),
        reason: 'pickFlyer awaits the picker and then the upload; each '
            'resumption needs its own check, because the screen can go away '
            'during either');
  });
}

/// THE EDIT FORM AND THE CREATE FORM ARE ONE PRODUCT.
///
/// They edit the same object and were drawn in two dialects: the wizard's
/// gradient cards from the shared kit, and the edit screen's own hand-rolled
/// bordered TextFields. Nobody reports that as a bug; it just reads as
/// unfinished. Both now go through the kit, and the edit screen's frozen
/// fields get the kit's padlock rather than their own.
void _oneDesignLanguageGuard() {
  test('the edit screen draws its fields through the shared kit', () {
    final edit = File('lib/src/features/ticketing/presentation/screens/'
            'edit_event_screen.dart')
        .readAsStringSync();

    expect(edit.contains('EventTextField('), isTrue);
    expect(edit.contains('EventPickerField('), isTrue);

    // The giveaway for a re-rolled field: this feature's own card colour used
    // as a TextField fill, with an OutlineInputBorder around it.
    expect(edit.contains('fillColor: TicketingTheme.card'), isFalse,
        reason: 'the edit screen is drawing its own field decoration again — '
            'the kit owns the gradient card, the padlock and the disabled '
            'colour, and a second copy is how the two forms for one object '
            'stop looking like the same product');
  });

  test('a frozen field says WHY it will not take a keystroke', () {
    final kit = File('lib/src/features/ticketing/presentation/widgets/'
            'event_form_kit.dart')
        .readAsStringSync();
    // A greyed box on its own does not explain itself; once a ticket has
    // sold, the price and dates are frozen because a purchase row carries its
    // own price.
    expect(kit.contains('Icons.lock_outline'), isTrue);
    expect(kit.contains('locked: !enabled'), isTrue);
  });
}

/// THE SUBMISSION MUST CARRY EVERY FIELD THE FORM COLLECTS.
///
/// This is the failure the restructure could have introduced and the one this
/// codebase keeps paying for: a field that exists, is typed into, validates,
/// and is then simply not passed on. It compiles, nothing errors, and the
/// organiser's venue is blank on the published listing. The gateway proxy lost
/// `uniqueness_scope` to exactly this shape, and the create wizard's
/// submission moved file during the split — from a State method to the shell —
/// so every argument was re-typed by hand.
///
/// Derived from the cubit rather than listed: a field added to the form is
/// caught without anyone remembering to extend this.
void _submissionCarriesEveryFieldGuard() {
  test('every form field reaches createDraft', () {
    final shell = File('lib/src/features/ticketing/presentation/screens/'
            'create_event_screen.dart')
        .readAsStringSync();
    final submission = shell.substring(shell.indexOf('createDraft('));

    // Each thing the organiser can set, and the argument that must carry it.
    const carried = {
      'title': 'form.title.text.trim()',
      'description': 'form.description.text.trim()',
      'venue': 'form.venue.text.trim()',
      'flyerUrl': 'form.flyerUrl',
      'unitPriceMinor': 'form.priceMinor!',
      'capacity': 'form.capacityValue',
      'salesCloseAt': 'form.salesCloseAt',
      'eventAt': 'form.eventAt!',
      'organiserName': 'form.organiserName.text.trim()',
      'organiserSocials': 'form.socialHandles',
      'category': "form.category ?? ''",
      'state': "form.stateSlug ?? ''",
    };
    carried.forEach((field, expr) {
      expect(submission.contains('$field: $expr'), isTrue,
          reason: '$field is collected by the form and is not passed to '
              'createDraft — it would be silently absent from the published '
              'event, with nothing anywhere reporting it');
    });
  });

  test('the form has no field the submission ignores', () {
    // THE OTHER DIRECTION: a controller on the cubit that nothing sends.
    //
    // A controller does not have to be read as `form.x.text` — the money
    // fields reach the submission through PARSERS (`priceMinor` does the one
    // multiplication by 100; `capacityValue` maps an empty box to
    // "unlimited"), and a raw `.text` read of either would be a bug. So the
    // rule is "reachable", and the indirect routes are named here: adding a
    // controller means saying how it is sent, which is exactly the question
    // that was not asked when a field was last dropped.
    const sentVia = {
      'price': 'form.priceMinor!',
      'capacity': 'form.capacityValue',
    };

    final cubit = File('lib/src/features/ticketing/presentation/cubit/'
            'create_event_form_cubit.dart')
        .readAsStringSync();
    final shell = File('lib/src/features/ticketing/presentation/screens/'
            'create_event_screen.dart')
        .readAsStringSync();
    final submission = shell.substring(shell.indexOf('createDraft('));

    final declared =
        RegExp(r'^  final (\w+) = TextEditingController\(\);', multiLine: true)
            .allMatches(cubit)
            .map((m) => m.group(1)!)
            .toList();
    expect(declared, isNotEmpty, reason: 'the walk found no controllers');

    for (final name in declared) {
      final direct = submission.contains('form.$name.text');
      final indirect =
          sentVia.containsKey(name) && submission.contains(sentVia[name]!);
      expect(direct || indirect, isTrue,
          reason: 'CreateEventFormCubit declares a `$name` controller that '
              'the submission never reads. Either pass it, or — if it is '
              'sent through a parser — add it to `sentVia` above naming the '
              'expression that carries it.');
    }

    // And the reverse of the allow-list: a named indirection that no longer
    // exists would make this guard pass by checking nothing.
    sentVia.forEach((name, expr) {
      expect(declared.contains(name), isTrue,
          reason: '`$name` is listed in sentVia but is no longer a '
              'controller — remove it so the guard keeps biting');
    });
  });
}

/// ONE FACT, ONE CONSTANT.
///
/// The shell needs "how many steps are there" and the form cubit needs "how
/// many collect input". Writing both as literals is how the step switch and
/// the navigation come to disagree: the switch routes to Confirm while
/// `_next` still believes there is another form to fill, or the app bar
/// indexes past the end of the names list.
void _stepCountGuard() {
  test('the step count is derived from the form, not written twice', () {
    final shell = File('lib/src/features/ticketing/presentation/screens/'
            'create_event_screen.dart')
        .readAsStringSync();

    expect(
        shell.contains(
            'static const int _totalSteps = CreateEventFormCubit.dataSteps + 1;'),
        isTrue,
        reason: '_totalSteps must be derived from the cubit\'s dataSteps. A '
            'second literal is one somebody can change alone.');

    // One name per step, because the app bar indexes straight into the list.
    final names = RegExp(r"static const _stepNames = \[(.*?)\];", dotAll: true)
        .firstMatch(shell)
        ?.group(1);
    expect(names, isNotNull, reason: '_stepNames was renamed');
    expect(RegExp("'").allMatches(names!).length ~/ 2, equals(4),
        reason: 'there are four steps, so there must be four names — a '
            'missing one is a range error on exactly the step that lost it');

    final cubit = File('lib/src/features/ticketing/presentation/cubit/'
            'create_event_form_cubit.dart')
        .readAsStringSync();
    expect(cubit.contains('static const int dataSteps = 3;'), isTrue,
        reason: 'three steps collect input; if that changed, _stepNames and '
            'the step switch in the shell change with it');
  });
}
