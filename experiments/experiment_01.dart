
import 'dart:math';

void main() {
  String appName = 'Spin the Wheel';

  List<String> options = [
    'Pizza',
    'Burger',
    'Biryani',
    'Noodles',
  ];

  String chooseOption(List<String> items) {
    final random = Random();
    return items[random.nextInt(items.length)];
  }

  print('App: $appName');
  print('Available options: $options');
  print('Selected option: ${chooseOption(options)}');
}
