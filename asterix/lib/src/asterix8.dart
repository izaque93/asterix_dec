import 'package:asterix/asterix.dart';

class Asterix8 extends Asterix {
  Asterix8? next;
  Asterix8(List<int> data) : super(data) {
    category = 8;
    int i = 1;
    //length = data[0] * 256 + data[1];
    // FSPEC field
    int fspec = data[++i];
  }
}
