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

enum ConfirmedOrTentativeTrack { confirmed, tentative }

enum TrackMaintainingSensors { combined, psr, mssr, invalid }

enum ConfideceInAssociationProcess { normal, low }

enum ClimbingDescendingMode { maintaining, climbing, descending, unknown }

enum TypeOfPlotCoordTransformationMechanism { radarPlane, slantRange }

enum WarningErrorConditions {
  notDefined,
  reflection,
  replyDueSidelobe,
  splitPlot,
  secondTimeAroundReply,
  angel,
  terrestrialVehicle,
  fixedPsrPlot,
  slowPsrTarget,
  lowQualityPsrPlot,
  phantomPsrPlot,
  nomMatchingPsrPlot,
  altitudeCodeAbnormalValueComparedToTheTrack,
  targetInClutterArea,
  maximumDopplerResponse,
  transponderAnomalyDetected,
  duplicatedOrIlegalModeSAddress,
  modeSErrorCorrectionAPllied,
  undecodableModeSAltitude,
  birds,
  flockOfBirds,
  mode1PresentInOriginalReply,
  mode2PresentInOriginalReply,
  plotPotenctialyCausedByWindTurbine,
  helicopter,
  maxNumOfReInterrogations,
  maxNumOfReInterrogationsBDS,
  bdsOverlayIncoherence,
  potentialBDSSwapDetected,
  trackUpadateInZenithalGap,
  modeSTrackReAcquired,
  duplicatedMode5PairNoPinDetected,
  wrongDfReplyFormatDetected,
  transponderAnomalyMSXPD,
  transponderAnomalySI,
  potentialIcConflict,
  icConflictDetectionPossible,
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
  int? bds;
  int? bds1;
  int? bds2;
  int? trackNumber;
  double? xCoordinate;
  double? yCoordinate;
  double? trackGroundSpeed;
  double? trackHeading;
  ConfirmedOrTentativeTrack? confirmedOrTentativeTrack;
  TrackMaintainingSensors? trackMaintainingSensors;
  ConfideceInAssociationProcess? confideceInAssociationProcess;
  bool? manoeuvreDetectionInHorizontalSense;
  ClimbingDescendingMode? climbingDescendingMode;
  bool? endOfTrack;
  bool? ghostTarget;
  // Track maintained with track information from
  //neighbouring Node B on the cluster, or network
  bool? trackMaintainingWithExternalSources;
  TypeOfPlotCoordTransformationMechanism?
  typeOfPlotCoordTransformationMechanism;
  double? horizontalStandardDeviation;
  double? verticalStandardDeviation;
  double? groundspeedStandardDeviation;
  double? headingStandardDeviation;
  WarningErrorConditions? warningErrorConditions;
  bool? qa4, qa2, qa1, qb4, qb2, qb1, qc4, qc2, qc1, qd4, qd2, qd1;
  bool? modeCCodeValidated;
  bool? modeCCodeGarbled;
  int? modeCReplyInGrayNotation;
  int? modoCLowQualityIndicators;
  int? heightMeasuredBy3dRadar;

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
      aircraftIdentification = String.fromCharCode(firstByte >> 2);
      aircraftIdentification =
          aircraftIdentification! +
          String.fromCharCode(((firstByte & 0x03) << 4) + (secondByte >> 4));
      aircraftIdentification =
          aircraftIdentification! +
          String.fromCharCode(((secondByte & 0x0F) << 2) + (thirdByte >> 6));
      aircraftIdentification =
          aircraftIdentification! + String.fromCharCode(thirdByte & 0x3F);
    }

    // I048/250 Mode-S MB Data
    // TODO: test
    if (isModeSMBDataPresent) {
      final firstByte = data[++i];
      for (int j = 8; j > 0; j++) {
        if (super.bitfield(firstByte, j)) {
          if (j > 1) {
            if (bds == null) {
              bds = data[++i];
            } else {
              bds = (bds! << 8) + data[++i];
            }
          } else {
            final finalByte = data[++i];
            bds1 = (finalByte & 0xF0) >> 4;
            bds2 = finalByte & 0x0F;
          }
        }
      }
    }
    // I048/161 Track Number
    if (isTrackNumberPresent) {
      final firstByte = data[++i];
      final secondByte = data[++i];
      trackNumber = (firstByte << 8) + secondByte;
    }

    // I048/042 Calculated Position in Cartesian Coordinates
    if (isCalculatedPositionInCartesianCoordinatesPresent) {
      final firstByte = data[++i];
      final secondByte = data[++i];
      final thirdByte = data[++i];
      final fourthByte = data[++i];
      xCoordinate = ((firstByte << 8) + secondByte).toSigned(16) / 128;
      yCoordinate = ((thirdByte << 8) + fourthByte).toSigned(16) / 128;
    }

    // I048/200 Calculated Track Velocity in Polar Representation
    if (isCalculatedTrackVelocityInPolarRepresentationPresent) {
      final firstByte = data[++i];
      final secondByte = data[++i];
      final thirdByte = data[++i];
      final fourthByte = data[++i];
      trackGroundSpeed = ((firstByte << 8) + secondByte) / 16384; //[NM/s]
      trackHeading =
          ((thirdByte << 8) + fourthByte) * 0.0055; //[deg] geographic ref
    }

    // I048/170 Track Status
    if (isTrackStatusPresent) {
      final info = data[++i];
      confirmedOrTentativeTrack =
          bitfield(info, 8)
              ? ConfirmedOrTentativeTrack.tentative
              : ConfirmedOrTentativeTrack.confirmed;
      trackMaintainingSensors =
          TrackMaintainingSensors.values[(info & 0x60) >> 5];
      confideceInAssociationProcess =
          ConfideceInAssociationProcess.values[bitfield(info, 5) ? 1 : 0];
      manoeuvreDetectionInHorizontalSense = bitfield(info, 4);
      climbingDescendingMode = ClimbingDescendingMode.values[(info & 0x6) >> 1];
      // extension field
      if (bitfield(info, 1)) {
        final info = data[++i];
        endOfTrack = bitfield(info, 8);
        ghostTarget = bitfield(info, 7);
        trackMaintainingWithExternalSources = bitfield(info, 6);
        typeOfPlotCoordTransformationMechanism =
            TypeOfPlotCoordTransformationMechanism.values[(info & 0x10) >> 4];
        while (bitfield(info, 1)) {
          final _ = data[++i];
        }
      }
    }
    //Data Item I048/210, Track Quality
    //TODO: test
    if (isTrackQualityPresent) {
      horizontalStandardDeviation = data[++i] / 128; // [NM]
      verticalStandardDeviation = data[++i] / 128; // [NM]
      groundspeedStandardDeviation = data[++i] / 16384; // [NM/s]
      headingStandardDeviation = data[++i] * 0.08789; // [°]
    }

    //Data Item I048/030, Warning/Error Conditions, and Special Purpose Field
    if (isWarningErrorConditionsTargetClassificationPresent) {
      //TODO: test
      int info = data[++i];

      warningErrorConditions = WarningErrorConditions.values[info >> 1];

      while (bitfield(info, 1)) {
        info = data[++i];
      }
    }
    //Data Item I048/080, Mode-3/A Code Confidence Indicator
    if (isMode3ACodeConfidenceIndicatorPresent) {
      int info = data[++i];
      qa4 = bitfield(info, 4);
      qa2 = bitfield(info, 3);
      qa1 = bitfield(info, 2);
      qb4 = bitfield(info, 1);
      info = data[++i];
      qb2 = bitfield(info, 8);
      qb1 = bitfield(info, 7);
      qc4 = bitfield(info, 6);
      qc2 = bitfield(info, 5);
      qc1 = bitfield(info, 4);
      qd4 = bitfield(info, 3);
      qd2 = bitfield(info, 2);
      qd1 = bitfield(info, 1);
    }
    // I048/100 Mode-C Code and Confidence Indicator
    //TODO: test
    if (isModeCCodeandConfidenceIndicatorPresent) {
      int info = data[++i];
      modeCCodeValidated = !bitfield(info, 8);
      modeCCodeGarbled = bitfield(info, 7);
      modeCReplyInGrayNotation = ((info & 0x0F) << 8) + data[++i];
      info = data[++i];
      modoCLowQualityIndicators = (info << 8) + data[++i]; // high bits has low quality
    }
    // Data Item I048/110, Height Measured by a 3D Radar
    if(isHeightMeasuredBy3dRadarPresent){
      int info = data[++i];
      heightMeasuredBy3dRadar = ((info << 8) + data[++i]).toSigned(16);
    }
  }
}
