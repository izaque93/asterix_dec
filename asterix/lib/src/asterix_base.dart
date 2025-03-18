// Project: Asterix
import 'package:asterix/src/asterix48.dart';

class AsterixDecoder {
  fromBinary(List<int> binary) {
    final category = binary[0];
    switch (category) {
      case 48:
        return Asterix48(binary.sublist(1));
      default:
        return null;
    }
  }
}

class Asterix {
  late int category;
  late int length;

  Asterix(List<int> data);
}
