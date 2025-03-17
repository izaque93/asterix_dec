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

class Asterix48 {
  final int category = 48;
  late int length;
  final List<int> data;
  int? sac;
  int? sic;

  double? timeOfDay;

  Asterix48(this.data) {
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

    print(sac);
  }
}
