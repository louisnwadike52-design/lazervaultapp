import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/presentation/utils/group_validators.dart';

/// Titles and descriptions are rendered CLIPPED almost everywhere they appear:
/// the group card, the contribution card, the details header, the picker rows,
/// the push notifications. A limit far above what those surfaces can show buys
/// text nobody reads and a field that scrolls away under the keyboard.
///
/// The two creation flows also disagreed: groups used these constants while the
/// contribution sheet hardcoded 100/500, so identical layouts accepted
/// different lengths.
void main() {
  group('the limits fit the surfaces that render them', () {
    test('a name is at most 50 characters', () {
      expect(GroupValidators.nameMaxLength, 50);
    });

    test('a description is at most 200 characters', () {
      expect(GroupValidators.descriptionMaxLength, 200);
    });

    test('the minimums still leave room to say something useful', () {
      expect(GroupValidators.nameMinLength, lessThan(GroupValidators.nameMaxLength));
      expect(GroupValidators.descriptionMinLength,
          lessThan(GroupValidators.descriptionMaxLength));
    });
  });

  group('the validators enforce them', () {
    test('a name at the limit passes and one over it fails', () {
      expect(GroupValidators.name('a' * GroupValidators.nameMaxLength), isNull);
      final over = GroupValidators.name('a' * (GroupValidators.nameMaxLength + 1));
      expect(over, isNotNull);
      expect(over, contains('${GroupValidators.nameMaxLength}'),
          reason: 'the message must name the limit, or the user cannot tell '
              'how much to cut');
    });

    test('a description at the limit passes and one over it fails', () {
      expect(
          GroupValidators.description('a' * GroupValidators.descriptionMaxLength),
          isNull);
      final over = GroupValidators.description(
          'a' * (GroupValidators.descriptionMaxLength + 1));
      expect(over, isNotNull);
      expect(over, contains('${GroupValidators.descriptionMaxLength}'));
    });

    // Measured on prod when the limits were tightened: the longest group name
    // was 29 characters and the longest description 47, so nothing existing is
    // stranded above the new ceiling and no edit can be refused for a value
    // that was legal when it was saved.
    test('values typical of existing records still pass', () {
      expect(GroupValidators.name('a' * 29), isNull);
      expect(GroupValidators.description('a' * 47), isNull);
    });
  });
}
