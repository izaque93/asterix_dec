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
  bool? flightLevelValidated;
  bool? flightLevelGarbled;
  double? flightLevel;
  double? ssrPlotRunlength;
  int? numberOfReceivedMssrReplies;
  int? amplitudeOfMssrReply;
  double? primaryPlotRunlength;
  int? amplitudeOfprimaryPlot;
  double? differenceInRangeBetweenPsrAndSsrplot;
  double? differenceInAzimuthBetweenPsrAndSsrplot;
  int? aircraftMSAddress;
  String? aircraftIdentification;

  Asterix48(List<int> data) : super(data) {
    // first extended variables
    bool isAircraftAddressPresent = false;
    bool isAircraftIdentificationPresent = false;
    bool isModeSMBDataPresent = false;
    bool isTrackNumberPresent = false;
    bool isCalculatedPositionInCartesianCoordinatesPresent = false;
    bool isCalculatedTrackVelocityInPolarRepresentationPresent = false;
    bool isTrackStatusPresent = false;

    // second extended variables
    bool isTrackQualityPresent = false;
    bool isWarningErrorConditionsTargetClassificationPresent = false;
    bool isMode3ACodeConfidenceIndicatorPresent = false;
    bool isModeCCodeandConfidenceIndicatorPresent = false;
    bool isHeightMeasuredBy3dRadarPresent = false;
    bool isRadialDopplerSpeedPresent = false;
    bool isCommunicationsACASCapabilityAndFlightStatusPresent = false;

    // third extended variables
    bool isACASResolutionAdvisoryReportPresent = false;
    bool isMode1InOctalRepresentationPresent = false;
    bool isMode2InOctalRepresentationPresent = false;
    bool isMode1InConfidenceIndicatorPresent = false;
    bool isMode2InConfidenceIndicatorPresent = false;
    bool isSpecialPurposeFieldPresent = false;
    bool isReservedExpansionFieldPresent = false;

    category = 48;
    int i = 1;
    length = data[0] * 256 + data[1];
    // FSPEC field
    int fspec = data[++i];

    final isDataSourcePresent = super.bitfield(fspec, 8);
    final isTimeOfDayPresent = super.bitfield(fspec, 7);
    final istargetReportDescriptorPresent = super.bitfield(fspec, 6);
    final isMeasuredPositioninSlantPolarCoordinatesPresent = super.bitfield(
      fspec,
      5,
    );
    final isMode3ACodeinOctalRepresentationPresent = super.bitfield(fspec, 4);
    final isFlightLevelinBinaryRepresentationPresent = super.bitfield(fspec, 3);
    final isRadarPlotCharacteristicsPresent = super.bitfield(fspec, 2);

    // Read next FSPEC field (1)
    if (fspec & 0x01 == 0x01) {
      fspec = data[++i];
      isAircraftAddressPresent = super.bitfield(fspec, 8);
      isAircraftIdentificationPresent = super.bitfield(fspec, 7);
      isModeSMBDataPresent = super.bitfield(fspec, 6);
      isTrackNumberPresent = super.bitfield(fspec, 5);
      ;
      isCalculatedPositionInCartesianCoordinatesPresent = super.bitfield(
        fspec,
        4,
      );
      isCalculatedTrackVelocityInPolarRepresentationPresent = super.bitfield(
        fspec,
        3,
      );
      isTrackStatusPresent = super.bitfield(fspec, 2);
    }

    // Read next FSPEC field (2)
    if (fspec & 0x01 == 0x01) {
      fspec = data[++i];
      isTrackQualityPresent = super.bitfield(fspec, 8);
      ;
      isWarningErrorConditionsTargetClassificationPresent = super.bitfield(
        fspec,
        7,
      );
      isMode3ACodeConfidenceIndicatorPresent = super.bitfield(fspec, 6);
      isModeCCodeandConfidenceIndicatorPresent = super.bitfield(fspec, 5);
      ;
      isHeightMeasuredBy3dRadarPresent = super.bitfield(fspec, 4);
      isRadialDopplerSpeedPresent = super.bitfield(fspec, 3);
      isCommunicationsACASCapabilityAndFlightStatusPresent = super.bitfield(
        fspec,
        2,
      );
    }

    // Read next FSPEC field (3)
    if (fspec & 0x01 == 0x01) {
      fspec = data[++i];
      isACASResolutionAdvisoryReportPresent = super.bitfield(fspec, 8);
      ;
      isMode1InOctalRepresentationPresent = super.bitfield(fspec, 7);
      isMode2InOctalRepresentationPresent = super.bitfield(fspec, 6);
      isMode1InConfidenceIndicatorPresent = super.bitfield(fspec, 5);
      ;
      isMode2InConfidenceIndicatorPresent = super.bitfield(fspec, 4);
      isSpecialPurposeFieldPresent = super.bitfield(fspec, 3);
      isReservedExpansionFieldPresent = super.bitfield(fspec, 2);
    }

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
      mode3ACodeValidated = !(firstByte & 0x80 == 0x80);
      mode3ACodeGarbled = firstByte & 0x40 == 0x40;
      mode3ACodeOrigin = Mode3ACodeOrigin.values[(firstByte & 0x20) >> 5];

      mode3ACode = "${(firstByte & 0x0E) >> 1}";
      mode3ACode =
          "${mode3ACode!}${((firstByte & 0x01) << 2) + ((secondByte & 0xC0) >> 6)}";
      mode3ACode =
          "${mode3ACode!}${(secondByte & 0x38) >> 3}${secondByte & 0x07}";
    }
    // I048/090 Flight Level in Binary Representation
    if (isFlightLevelinBinaryRepresentationPresent) {
      final firstByte = data[++i];
      final secondByte = data[++i];
      flightLevelValidated = !(firstByte & 0x80 == 0x80);
      flightLevelGarbled = firstByte & 0x40 == 0x40;
      flightLevel = (((firstByte & 0x3F) << 8) + secondByte) * 0.25;
    }

    //I048/130 Radar Plot Characteristics
    if (isRadarPlotCharacteristicsPresent) {
      final firstByte = data[++i];
      if (firstByte & 0x80 == 0x80) {
        ssrPlotRunlength = data[++i] * 0.044;
      }
      if (firstByte & 0x40 == 0x40) {
        numberOfReceivedMssrReplies = data[++i];
      }
      if (firstByte & 0x20 == 0x20) {
        amplitudeOfMssrReply = data[++i].toSigned(8);
      } //TODO: test
      if (firstByte & 0x10 == 0x10) {
        primaryPlotRunlength = data[++i] * 0.044;
      } //TODO: test
      if (firstByte & 0x08 == 0x08) {
        amplitudeOfprimaryPlot = data[++i].toSigned(8);
      }
      //TODO: test
      if (firstByte & 0x04 == 0x04) {
        differenceInRangeBetweenPsrAndSsrplot = data[++i].toSigned(8) / 256;
      }
      //TODO: test
      if (firstByte & 0x02 == 0x02) {
        differenceInAzimuthBetweenPsrAndSsrplot =
            data[++i].toSigned(8) * 0.02197265625;
      }
    }

    // I048/220 Aircraft Address
    // TODO: test
    if (isAircraftAddressPresent) {
      final firstByte = data[++i];
      final secondByte = data[++i];
      final thirdByte = data[++i];
      aircraftMSAddress = (firstByte << 16) + (secondByte << 8) + thirdByte;
    }

    // I048/240 Aircraft Identification (MS)
    if (isAircraftIdentificationPresent) {
      final firstByte = data[++i];
      final secondByte = data[++i];
      final thirdByte = data[++i];
      aircraftIdentification = String.fromCharCode(firstByte >>2);
      aircraftIdentification = aircraftIdentification! + String.fromCharCode(((firstByte & 0x03) << 4) + (secondByte >> 4));
      aircraftIdentification = aircraftIdentification! + String.fromCharCode(((secondByte & 0x0F) << 2) + (thirdByte >> 6));
      aircraftIdentification = aircraftIdentification! + String.fromCharCode(thirdByte & 0x3F);
    }

    // I048/250 Mode-S MB Data


  }
}
