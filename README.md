<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

This packet decodes Asterix messages

## Features

Can decode Asterix messages in categories 34 and 48.
We're working in support for cat 8, 1 and 2.

## Getting started

Download the package and import as follow:

```dart
import 'package:asterix/asterix.dart';
import 'package:asterix/src/asterix34.dart';
import 'package:asterix/src/asterix48.dart';
```

```dart
void main() {
  final asterixDecoder = AsterixDecoder();
  // Read asterix file
  final file = File('rec_bin_001.bin',); // only asterix payload, don't suport .pcap
  final stream = await file.readAsBytes();
  // Read lenght fields of the first asterix packet
  final length = stream[1] * 256 + stream[2];
  asterixPacket = stream.sublist(0, length);
  Asterix asterixInfo = asterixDecoder.fromBinary(asterixPacket);


}
```

## Usage

this example demonstrates the usage for decode asterix 34 service messages

```dart
if (asterixInfo.category == 34) {
    final packet = asterixInfo as Asterix34;
    if (packet.antennaRotationPeriod != null) {
        print(packet.antennaRotationPeriod);
    }
    if (packet.sectorNumber != null) {
        final deltaTheta =
            (packet.sectorNumber! != 0.0
                ? packet.sectorNumber!
                : 360.0) -
            lastSector;
        final deltaTime = packet.timeOfDay! - lastTimeSector;
        print("${packet.sectorNumber} ->  ${deltaTheta / deltaTime}");
        lastSector = packet.sectorNumber!;
        lastTimeSector = packet.timeOfDay!;
    }
}
```

The fields on class Asterix subclasses can be null or a value depending the info.
Null values meaning no information.

## Additional information

For more information about this package, visit the [official repository](https://github.com/your-repo/asterix-decoder). Here, you can find detailed documentation, examples, and updates.

### Contributing
We welcome contributions! If you'd like to contribute, please check out our [contribution guidelines](https://github.com/your-repo/asterix-decoder/blob/main/CONTRIBUTING.md). Whether it's reporting bugs, suggesting features, or submitting pull requests, your input is valuable.

### Filing Issues
If you encounter any issues or have questions, please file an issue on our [GitHub Issues page](https://github.com/your-repo/asterix-decoder/issues). We aim to respond within 48 hours.

### Support
For additional support, feel free to reach out via the [discussions page](https://github.com/your-repo/asterix-decoder/discussions). Our team and community are here to help.

Thank you for using the Asterix Decoder package!
