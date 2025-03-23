import 'package:asterix/asterix.dart';

class Asterix34 extends Asterix {
  Asterix34? next;
  Asterix34(List<int> data) : super(data) {
    category = 34;
    int i = 1;
    // FSPEC field
    int fspec = data[++i];
    final isDataSourcePresent = super.bitfield(fspec, 8);

    //Data Item I034/010, Data Source Identifier
    super.decodeDataSourceIdentifier([data[++i], data[++i]]);

    
  }
}
