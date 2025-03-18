// Project: Asterix
/// Checks if you are awesome. Spoiler: you are.
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

enum DetectionType {
  noDetection,
  singlePSRdetection,
  singleSSRDetection,
  ssrPSRDetection,
  singleModeSAllCall,
  singleModeSRollCall,
  modeSAllCallPSR,
  modeSRollCallPSR,
}

enum SimulatedOrActual { actual, simulated }

enum ReplyOrigin { aircraftTransponder, fieldMonitor }

enum RealOrTest { realTargetReport, testTargetReport }

class Asterix {
  late int category;
  late int length;

  Asterix(List<int> data);
}

class Asterix48 extends Asterix {
  int? sac;
  int? sic;
  double? timeOfDay;
  DetectionType? detectionType;
  SimulatedOrActual? simulatedOrActual;
  int? rdpChain;
  bool? spi;
  ReplyOrigin? replyOrigin;
  RealOrTest? realOrTest;

  Asterix48(List<int> data) : super(data) {
    category = 48;
    int i = 0;
    length = data[0] * 256 + data[1];
    int fspec = data[2];
    i = 2;
    final isDataSourcePresent = (fspec & 0x80) == 0x80;
    final isTimeOfDayPresent = (fspec & 0x40) == 0x40;
    final istargetReportDescriptorPresent = (fspec & 0x20) == 0x20;
    final isMeasuredPositioninSlantPolarCoordinatesPresent =
        (fspec & 0x10) == 0x10;
    final isMode3ACodeinOctalRepresentationPresent = (fspec & 0x08) == 0x08;
    final isFlightLevelinBinaryRepresentationPresent = (fspec & 0x04) == 0x04;
    final isRadarPlotCharacteristicsPresent = (fspec & 0x02) == 0x02;
    // one byte for FSPEC
    while (0x01 & fspec == 0x01) {
      fspec = data[++i];
    }

    if (isDataSourcePresent) {
      sac = data[++i];
      sic = data[++i];
    }
    if (isTimeOfDayPresent) {
      timeOfDay = (data[++i] * 256 * 256 + data[++i] * 256 + data[++i]) * 1.0;
      // seconds
      timeOfDay = timeOfDay! / 128;
    }
    if (istargetReportDescriptorPresent) {
      //Read next field
      int targetReportDescriptor = data[++i];

      // MSB 3 bits TYP
      int typ = targetReportDescriptor & 0xE0;
      typ = typ >> 5;
      detectionType = DetectionType.values[typ];

      // bit 5 SIM
      int sim = targetReportDescriptor & 0x10 == 0x10 ? 1 : 0;
      simulatedOrActual = SimulatedOrActual.values[sim];

      // bit 4 RDP Chain
      rdpChain = targetReportDescriptor & 0x08 == 0x08 ? 2 : 1;

      // bit 3 SPI
      spi = targetReportDescriptor & 0x04 == 0x04;

      // bit 2 RAB
      replyOrigin = ReplyOrigin.values[(targetReportDescriptor & 0x02) >> 1];

      // bit 1 First Extend
      if (targetReportDescriptor & 0x01 == 0x01) {
        targetReportDescriptor = data[++i];

        // bit 8 TST
        realOrTest = RealOrTest.values[targetReportDescriptor & 0x80 >> 7];
      }
    }
  }
}
