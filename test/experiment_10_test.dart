
import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/experiment_10.dart';

void main() {
  group('WheelUtils.chooseOption', () {
    test('returns an option from the provided list', () {
      final result = WheelUtils.chooseOption(
        ['Pizza', 'Burger', 'Biryani'],
        random: Random(1),
      );

      expect(
        ['Pizza', 'Burger', 'Biryani'],
        contains(result),
      );
    });

    test('throws an error for an empty list', () {
      expect(
        () => WheelUtils.chooseOption([]),
        throwsArgumentError,
      );
    });
  });
}
