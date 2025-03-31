import 'package:asterix/asterix.dart';

enum MessageType {
  polarVector,
  cartesianVectorOfStartPointLenght,
  contourRecord,
  cartesianStartPointEndPointVector,
  sopMessage,
  eopMessage

}


class Asterix8 extends Asterix {
  Asterix8? next;
  
  MessageType? messageType;
  Asterix8(List<int> data) : super(data) {
    category = 8;
    int i = 1;
    bool isTimeOfDayPresent = false;
    bool isProcessingStatusPresent = false;
    bool isStationConfigurationStatusPresent = false;
    bool isNumberOfItemsInOnePicturePresent = false;
    bool isSequenceOfWeatherVectorsInSPFNotationPresent = false;
    //length = data[0] * 256 + data[1];
    // FSPEC field
    int fspec = data[++i];
    final isDataSourcePresent = bitfield(fspec, 8);
    final isMessageTypePresent = bitfield(fspec, 7);
    final isVectorQualifierPresent = bitfield(fspec, 6);
    final isCartesianVectorsPresent = bitfield(fspec, 5);
    final isPolarVectorsPresent = bitfield(fspec, 4);
    final isContourIdentifierPresent = bitfield(fspec, 3);
    final isContourPointsPresent = bitfield(fspec, 2);

    // Read next FSPEC field (1)
    if (bitfield(fspec, 1)) {
      fspec = data[++i];
      isTimeOfDayPresent = bitfield(fspec, 8);
      isProcessingStatusPresent = bitfield(fspec, 7);
      isStationConfigurationStatusPresent = bitfield(fspec, 6);
      isNumberOfItemsInOnePicturePresent = bitfield(fspec, 5);
      isSequenceOfWeatherVectorsInSPFNotationPresent = bitfield(fspec, 4);
    }
    //Data Item I008/010, Data Source Identifier
    if (isDataSourcePresent) {
      super.decodeDataSourceIdentifier([data[++i], data[++i]]);
    }

    // I008/000 Message Type
    if (isMessageTypePresent) {
      final info = data[++i];
      messageType = MessageType.values[info];
    }




  }
}
