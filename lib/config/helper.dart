import 'dart:math';

class Helper {
  static final Random _random = Random();

  // get a random image url
  static String randomPictureUrl(int width, int height) {
    final randomInt = _random.nextInt(1000);
    return 'https://picsum.photos/$width/$height?random=$randomInt';
  }
}
