import 'package:asterix/asterix.dart';

enum MessageType {
  notDefined,
  northMarkermessage,
  sectorcrossingmessage,
  geographicalfilteringmessage,
  jammingStrobemessage,
  solarStormMessage,
  ssrJammingStrobeMessage,
  modeSJammingStrobeMessage,
}

class Asterix34 extends Asterix {
  Asterix34? next;
  MessageType? messageType;
  
  double? sectorNumber;
  
  double? antennaRotationPeriod;

  Asterix34(List<int> data) : super(data) {
    category = 34;
    int i = 1;
    // FSPEC field
    int fspec = data[++i];
    final isDataSourcePresent = super.bitfield(fspec, 8);
    final isMessageTypePresent = super.bitfield(fspec, 7);
    final isTimeOfDayPresent = super.bitfield(fspec, 6);
    final isSectorNumberPresent = super.bitfield(fspec, 5);
    final isAntennaRotationPeriodPresent = super.bitfield(fspec, 4);
    //Data Item I034/010, Data Source Identifier
    if (isDataSourcePresent) {
      super.decodeDataSourceIdentifier([data[++i], data[++i]]);
    }
    // I034/000 Message Type
    if (isMessageTypePresent) {
      final info = data[++i];
      messageType = MessageType.values[info];
    }
    // I034/030 Time-of-Day
    if (isTimeOfDayPresent) {
      super.decodeTimeOfDay([data[++i], data[++i], data[++i]]);
    }

    //I034/020 Sector Number
    if (isSectorNumberPresent) {
      final info = data[++i];
      sectorNumber = info * 1.41; //[°]
    }

    //I034/041 Antenna Rotation Speed
    if (isAntennaRotationPeriodPresent){
      antennaRotationPeriod = data[++i] * 256 + data[++i] / 128;
    }
  }
}
