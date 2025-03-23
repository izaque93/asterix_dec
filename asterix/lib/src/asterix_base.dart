// Project: Asterix
import 'package:asterix/src/asterix34.dart';
import 'package:asterix/src/asterix48.dart';
import 'package:asterix/src/asterix8.dart';

class AsterixDecoder {
  fromBinary(List<int> binary) {
    final category = binary[0];
    switch (category) {
      case 48:
        return Asterix48(binary.sublist(1));
      case 8:
        return Asterix8(binary.sublist(1));
      case 34:
        return Asterix34(binary.sublist(1));
      default:
        return null;
    }
  }
}

class Asterix {
  late int category;
  late int length;
  late int sac;
  late int sic;

  bool bitfield(int byte, int field) {
    return (byte >> (field - 1)) & 0x01 == 1;
  }

  decodeDataSourceIdentifier(List<int> data) {
    sac = data[0];
    sic = data[1];
  }

  Asterix(List<int> data);
}
