import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/person_first_name.dart';

void main() {
  // The reported line: "nnameka Chirstirna sent you …" should say "Nnaemeka".
  test('a two-part name gives the first part', () {
    expect(firstNameOf('Nnaemeka Christiana'), 'Nnaemeka');
    expect(firstNameOf('Praiz Onah'), 'Praiz');
  });

  test('a single name is left exactly as it is', () {
    expect(firstNameOf('Praiz'), 'Praiz');
    expect(firstNameOf('chi'), 'chi');
  });

  // The directory stores some names surname-first in caps. Taking the literal
  // first token there would address someone by their surname, shouted.
  test('a comma-ordered name gives the given name, not the surname', () {
    expect(firstNameOf('ONAH, Praiz'), 'Praiz');
    expect(firstNameOf('Okafor, Mary-Jane'), 'Mary-Jane');
  });

  test('honorifics are skipped', () {
    expect(firstNameOf('Dr. Ada Obi'), 'Ada');
    expect(firstNameOf('Alhaji Musa Bello'), 'Musa');
    expect(firstNameOf('Chief Mrs Ngozi Eze'), 'Ngozi');
    expect(firstNameOf('Engr. Tunde'), 'Tunde');
  });

  // A name made of nothing but titles must not erase the person.
  test('a name that is only a title returns something', () {
    expect(firstNameOf('Chief'), 'Chief');
  });

  test('a handle is already short and is never split', () {
    expect(firstNameOf('@praiz_o'), '@praiz_o');
    expect(firstNameOf('@ada.obi'), '@ada.obi');
  });

  test('hyphenated given names stay whole', () {
    expect(firstNameOf('Mary-Jane Okafor'), 'Mary-Jane');
  });

  test('whitespace is collapsed, not counted', () {
    expect(firstNameOf('  Ada   Obi  '), 'Ada');
    expect(firstNameOf('\tAda\nObi'), 'Ada');
  });

  // Case is the user's to choose. Title-casing "MOHAMMED" or "chi" would be
  // the app deciding how someone spells their own name.
  test('case is never changed', () {
    expect(firstNameOf('MOHAMMED Sani'), 'MOHAMMED');
    expect(firstNameOf('chi okeke'), 'chi');
  });

  group('empty input', () {
    test('returns empty so the caller picks the fallback', () {
      expect(firstNameOf(null), '');
      expect(firstNameOf(''), '');
      expect(firstNameOf('   '), '');
    });

    test('firstNameOr supplies it', () {
      expect(firstNameOr(null, 'Unknown User'), 'Unknown User');
      expect(firstNameOr('', 'Unknown User'), 'Unknown User');
      expect(firstNameOr('Praiz Onah', 'Unknown User'), 'Praiz');
    });
  });

  // The whole point: the line has to get shorter. A row that ellipsises away
  // the amount is a money line with no money in it.
  test('the result is never longer than the name it came from', () {
    for (final name in [
      'Nnaemeka Christiana',
      'ONAH, Praiz',
      'Dr. Ada Obi',
      'Mary-Jane Okafor',
      'Praiz',
      '@praiz_o',
    ]) {
      expect(firstNameOf(name).length, lessThanOrEqualTo(name.length),
          reason: '"$name" did not get shorter');
    }
  });
}
