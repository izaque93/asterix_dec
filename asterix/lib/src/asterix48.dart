import 'package:asterix/asterix.dart';

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

enum FOEFRI { noMode4Interrogation, friendlyTarget, unknownTarget, noReply }

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
  bool? extendedRange;
  bool? xPulsePresent;
  bool? militaryEmergency;
  bool? militaryIdentification;
  FOEFRI? foefri;

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
    // I048/020 Target Report Descriptor
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
        //TODO: test
        realOrTest = RealOrTest.values[targetReportDescriptor & 0x80 >> 7];

        // bit 7 ERR Extended Range present or not
        //TODO: test
        extendedRange = targetReportDescriptor & 0x40 == 0x40;

        // bit 6 XPP X-Pulse present or not
        //TODO: test
        xPulsePresent = targetReportDescriptor & 0x20 == 0x20;

        // bit 5 ME Military Emergency
        //TODO: test
        militaryEmergency = targetReportDescriptor & 0x10 == 0x10;

        // bit 4 MI Military identification
        //TODO: test
        militaryIdentification = targetReportDescriptor & 0x08 == 0x08;

        // bit 3/2 FOE/FRI
        //TODO: test
        foefri = FOEFRI.values[targetReportDescriptor & 0x06 >> 1];

        // bit 1 Second Extend
        if (targetReportDescriptor & 0x01 == 0x01) {
          targetReportDescriptor = data[++i];
          
        }
      }
    }
  }
}
