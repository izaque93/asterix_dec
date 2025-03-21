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

enum Mode3ACodeOrigin { transponder, notExtractedDuringLastScan }

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
  bool? adsbElementPopulated;
  bool? onSiteADSBInformationAvaliable;
  bool? scnElementPopulated;
  bool? surveillanceClusterNetworkInformationAvailable;
  bool? passiveAcquisitionInterfaceInformationAvailable;
  bool? paiElementPopulated;
  bool? mode3ACodeValidated;
  bool? mode3ACodeGarbled;
  Mode3ACodeOrigin? mode3ACodeOrigin;
  String? mode3ACode;
  double? rho;
  double? theta;

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

      // bit 1 First Extend //TODO: test
      if (targetReportDescriptor & 0x01 == 0x01) {
        targetReportDescriptor = data[++i];

        // bit 8 TST
        realOrTest = RealOrTest.values[targetReportDescriptor & 0x80 >> 7];

        // bit 7 ERR Extended Range present or not
        extendedRange = targetReportDescriptor & 0x40 == 0x40;

        // bit 6 XPP X-Pulse present or not
        xPulsePresent = targetReportDescriptor & 0x20 == 0x20;

        // bit 5 ME Military Emergency
        militaryEmergency = targetReportDescriptor & 0x10 == 0x10;

        // bit 4 MI Military identification
        militaryIdentification = targetReportDescriptor & 0x08 == 0x08;

        // bit 3/2 FOE/FRI
        foefri = FOEFRI.values[targetReportDescriptor & 0x06 >> 1];

        // bit 1 Second Extend
        //TODO: test
        if (targetReportDescriptor & 0x01 == 0x01) {
          targetReportDescriptor = data[++i];

          // bit 8 ADSB#EP ADSB Element Populated Bit
          adsbElementPopulated = targetReportDescriptor & 0x80 == 0x80;

          // bit 7 On-Site ADS-B Information Avaliable
          onSiteADSBInformationAvaliable =
              targetReportDescriptor & 0x40 == 0x40;

          //bits-6/5 (SCN) Surveillance Cluster Network Information
          scnElementPopulated = targetReportDescriptor & 0x20 == 0x20;
          surveillanceClusterNetworkInformationAvailable =
              targetReportDescriptor & 0x10 == 0x10;

          //bits-4/3 (PAI) Passive Acquisition Interface Informatio
          paiElementPopulated = targetReportDescriptor & 0x08 == 0x08;
          passiveAcquisitionInterfaceInformationAvailable =
              targetReportDescriptor & 0x04 == 0x04;

          // load nexts extended fields not suported yet
          while (targetReportDescriptor & 0x01 == 0x01) {
            targetReportDescriptor = data[++i];
          }
        }
      }
    }

    // I048/040 Measured Position in Slant Polar Coordinates
    if (isMeasuredPositioninSlantPolarCoordinatesPresent) {
      rho = ((data[++i] << 8) + data[++i]) / 256; //[NM]
      theta = ((data[++i] << 8) + data[++i]) * 0.0055; //[deg]
    }

    // I048/070 Mode-3/A Code in Octal Representation
    if (isMode3ACodeinOctalRepresentationPresent) {
      final firstByte = data[++i];
      final secondByte = data[++i];
      mode3ACodeValidated = firstByte & 0x80 == 0x80;
      mode3ACodeGarbled = firstByte & 0x40 == 0x40;
      mode3ACodeOrigin = Mode3ACodeOrigin.values[firstByte & 0x20 >> 5];

      mode3ACode = "${(firstByte & 0x0E) >> 1}";
      mode3ACode =
          "${mode3ACode!}${((firstByte & 0x01) << 2) + ((secondByte & 0xC0) >> 6)}";
      mode3ACode =
          "${mode3ACode!}${(secondByte & 0x38) >> 3}${secondByte & 0x07}";
      print("Mode3ACode: $mode3ACode");
    }
  }
}
