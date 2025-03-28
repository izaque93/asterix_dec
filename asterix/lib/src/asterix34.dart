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

enum PsrChannelSelectionStatus {
  noChannelSelected,
  channelASelected,
  channelBSelected,
  diversityModeAandBSelected,
}

enum SsrOrMdsChannelSelectionStatus {
  noChannelSelected,
  channelASelected,
  channelBSelected,
  invalidCombination,
}

enum CountType {
  noDetections,
  singlePsrTargetReports,
  singleSsrTargetReports,
  psrAndSsrTargetReports,
  singleAllCallTargetReports,
  singleRollCallTargetReports,
  allCallAndPsrTargetReports,
  rollCallAndPsrTargetReports,
  filterForWheaterData,
  filterForJammingStrobe,
  filterForPsrData,
  filterForSsrModeSData,
  filterForSsrModeSAndPsrData,
  filterForEnhancedSurveillanceData,
  filterForPsrAndEnhancedSurveillance,
  filterForPsrSsrEnhancedSurveillanceDataNotInArea,
  filterForPsrSsrMdsEnhancedSurveillanceData,
  reInterrogationsPerSector,
  bdsSwapAndWrongDfRepliesPerSector,
  modeACFruitPerSector,
  mdsFruitPerSector,
}

enum DataFilterType {
  invalidValue,
  wheaterData,
  jammingStrobe,
  psrData,
  ssrModeSData,
  ssrModeSPsrData,
  enhancedSurveillanceData,
  ssrAndEnhancedSurveillanceData,
  psrSsrEnhancedSurveillanceDataNotInArea,
  psrSsrMdsEnhancedSurveillanceData,
}

class Asterix34 extends Asterix {
  Asterix34? next;
  MessageType? messageType;
  PsrChannelSelectionStatus? psrChannelSelectionStatus;
  SsrOrMdsChannelSelectionStatus? ssrChannelSelectionStatus,
      mdsChannelSelectionStatus;
  DataFilterType? dataFilterType;
  List<CountType> countType = [];
  List<int> count = [];
  double? sectorNumber,
      antennaRotationPeriod,
      collimationAzimuthError,
      collimationRangeError,
      genericWindowRhoStart,
      genericWindowRhoEnd,
      genericWindowThetaStart,
      genericWindowThetaEnd,
      dataSourceLatitude,
      dataSourceLongitude;

  int? radarDataProcessorChain,
      psrSelectedAntena,
      ssrSelectedAntena,
      mdsSelectedAntena,
      channelSelectionForSurveillanceCoordinateFunction,
      reductionStepDueOverloadInRDP,
      reductionStepDueOverloadIntransmission,
      reductionStepDueOverloadInPSR,
      psrSTCMapInUse,
      reductionStepDueOverloadInSSR,
      reductionStepDueOverloadInMDS,
      dataSourceHeight,
      channelSelectionForDataLinkFunction;

  bool? isResetOrRestartOfRdpcChain,
      radarDataProcessorOverload,
      transmissionSubsystemOverload,
      monitoringSystemDisconnected,
      timeSourceValid,
      psrOverload,
      systemIsReleasedForOperacionalUse,
      psrMonitoringSystemDisconnected,
      ssrOverload,
      ssrMonitoringSystemDisconnected,
      mdsOverload,
      mdsMonitoringSystemDisconnected,
      overloadInSurveillanceCoordinateFunction,
      overloadInDataLinkFunction,
      isMdsClusterStateAutonomous;

  Asterix34(List<int> data) : super(data) {
    category = 34;
    int i = 1;
    bool isMessageCountValuesPresent = false;
    bool isCollimationErrorPresent = false;
    bool isGenericPolarWindowPresent = false;
    bool isDataFilterPresent = false;
    bool isPositionOfDataSourcePresent = false;
    // FSPEC field
    int fspec = data[++i];
    final isDataSourcePresent = bitfield(fspec, 8);
    final isMessageTypePresent = bitfield(fspec, 7);
    final isTimeOfDayPresent = bitfield(fspec, 6);
    final isSectorNumberPresent = bitfield(fspec, 5);
    final isAntennaRotationPeriodPresent = bitfield(fspec, 4);
    final isSystemConfigurationAndStatusPresent = bitfield(fspec, 3);
    final isSystemProcessingModePresent = bitfield(fspec, 2);

    // Read next FSPEC field (1)
    if (bitfield(fspec, 1)) {
      fspec = data[++i];
      isMessageCountValuesPresent = bitfield(fspec, 8);
      isGenericPolarWindowPresent = bitfield(fspec, 7);
      isDataFilterPresent = bitfield(fspec, 6);
      isPositionOfDataSourcePresent = bitfield(fspec, 5);
      isCollimationErrorPresent = bitfield(fspec, 4);
    }
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
      sectorNumber = info * 1.40625; //[°]
    }

    //I034/041 Antenna Rotation Speed
    //TODO: test
    if (isAntennaRotationPeriodPresent) {
      antennaRotationPeriod = data[++i] * 256 + data[++i] / 128;
    }

    // I034/050, System Configuration and Status

    if (isSystemConfigurationAndStatusPresent) {
      int info = data[++i];
      final com = bitfield(info, 8);
      final psr = bitfield(info, 5);
      final ssr = bitfield(info, 4);
      final mds = bitfield(info, 3);
      final fx = bitfield(info, 1);

      // extention field
      if (fx) {
        final _ = data[++i];
      }
      if (com) {
        info = data[++i];
        systemIsReleasedForOperacionalUse = !bitfield(info, 8);
        radarDataProcessorChain = bitfield(info, 7) ? 2 : 1;
        isResetOrRestartOfRdpcChain = bitfield(info, 6);
        radarDataProcessorOverload = bitfield(info, 5);
        transmissionSubsystemOverload = bitfield(info, 4);
        monitoringSystemDisconnected = bitfield(info, 3);
        timeSourceValid = !bitfield(info, 2);
      }
      if (psr) {
        info = data[++i];
        psrSelectedAntena = bitfield(info, 8) ? 2 : 1;
        psrChannelSelectionStatus =
            PsrChannelSelectionStatus.values[((info & 0x60) >> 5)];
        psrOverload = bitfield(info, 5);
        psrMonitoringSystemDisconnected = bitfield(info, 4);
      }
      if (ssr) {
        //TODO: test
        info = data[++i];
        ssrSelectedAntena = bitfield(info, 8) ? 2 : 1;
        ssrChannelSelectionStatus =
            SsrOrMdsChannelSelectionStatus.values[((info & 0x60) >> 5)];
        ssrOverload = bitfield(info, 5);
        ssrMonitoringSystemDisconnected = bitfield(info, 4);
      }
      if (mds) {
        info = data[++i];
        mdsSelectedAntena = bitfield(info, 8) ? 2 : 1;
        mdsChannelSelectionStatus =
            SsrOrMdsChannelSelectionStatus.values[((info & 0x60) >> 5)];
        mdsOverload = bitfield(info, 5);
        mdsMonitoringSystemDisconnected = bitfield(info, 4);
        channelSelectionForSurveillanceCoordinateFunction =
            bitfield(info, 3) ? 2 : 1;
        channelSelectionForDataLinkFunction = bitfield(info, 2) ? 2 : 1;
        overloadInSurveillanceCoordinateFunction = bitfield(info, 1);

        info = data[++i];
        overloadInDataLinkFunction = bitfield(info, 8);
      }
    }

    // I034/060, System Processing Mode
    //TODO: Test
    if (isSystemProcessingModePresent) {
      int info = data[++i];
      final com = bitfield(info, 8);
      final psr = bitfield(info, 5);
      final ssr = bitfield(info, 4);
      final mds = bitfield(info, 3);
      final fx = bitfield(info, 1);

      // extention field
      if (fx) {
        final _ = data[++i];
      }

      if (com) {
        final info = data[++i];
        reductionStepDueOverloadInRDP = (info & 0x70) >> 4;
        reductionStepDueOverloadIntransmission = (info & 0x0E) >> 1;
      }
      if (psr) {
        final info = data[++i];
        reductionStepDueOverloadInPSR = (info & 0x70) >> 4;
        psrSTCMapInUse = ((info & 0x0C) >> 2) + 1;
      }
      if (ssr) {
        final info = data[++i];
        reductionStepDueOverloadInSSR = (info & 0xE0) >> 5;
      }
      if (mds) {
        final info = data[++i];
        reductionStepDueOverloadInMDS = (info & 0xE0) >> 5;
        isMdsClusterStateAutonomous = bitfield(info, 5);
      }
    }

    //I034/070, Message Count Values
    //TODO: Test
    if (isMessageCountValuesPresent) {
      final rep = data[++i];

      for (int i = 0; i < rep; i++) {
        final info = data[++i];
        final info2 = data[++i];
        countType.add(CountType.values[((info & 0xF8) >> 3)]);
        count.add(((info & 0x07) << 8) + info2);
      }
    }
    //decode next packet if its present
    if (i < data.length - 1) {
      next = Asterix34(data.sublist(i - 1));
    }

    //I034/100, Generic Polar Window
    //TODO: Test
    if (isGenericPolarWindowPresent) {
      genericWindowRhoStart = (data[++i] * 256 + data[++i]) / 256; //[NM]
      genericWindowRhoEnd = (data[++i] * 256 + data[++i]) / 256; //[NM]
      genericWindowThetaStart = (data[++i] * 256 + data[++i]) * 0.0055;
      genericWindowThetaEnd = (data[++i] * 256 + data[++i]) * 0.0055;
    }

    //I034/110 Data Filter
    //TODO: Test
    if (isDataFilterPresent) {
      final info = data[++i];
      dataFilterType = DataFilterType.values[info];
    }

    //I034/120 3D-Position of Data Source
    //TODO: Test
    if (isPositionOfDataSourcePresent) {
      dataSourceHeight = (data[++i] * 256 + data[++i]); //[m]
      dataSourceLatitude =
          (data[++i] * 256 + data[++i]).toDouble() * 256 + data[++i];
      dataSourceLatitude = dataSourceLatitude! * 2.145767 / 100000;
      dataSourceLongitude =
          (data[++i] * 256 + data[++i]).toDouble() * 256 + data[++i];
      dataSourceLongitude = dataSourceLongitude! * 2.145767 / 100000;
    }

    //I034/090, Collimation Error
    //TODO: test
    if (isCollimationErrorPresent) {
      collimationAzimuthError = data[++i].toSigned(8) / 128;
      collimationRangeError = data[++i].toSigned(8) * 0.022;
    }

    //decode next packet if its present
    if (i < data.length - 1) {
      next = Asterix34(data.sublist(i - 1));
    }
  }
}
