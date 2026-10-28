
import 'dart:math';

class WheelUtils {
  static String chooseOption(
    List<String> options, {
    Random? random,
  }) {
    if (options.isEmpty) {
      throw ArgumentError('Options cannot be empty');
    }

    final rng = random ?? Random();
    return options[rng.nextInt(options.length)];
  }
}
