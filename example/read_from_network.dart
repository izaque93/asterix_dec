import 'dart:io';

import 'package:asterix/asterix.dart';


void main() {
  final asterixDecoder = AsterixDecoder();
  List<int> asterixPacket = [];
  double lastTimeSector = 0.0;
  double lastSector = 0.0;

  RawDatagramSocket.bind(InternetAddress.anyIPv4, 20110).then((
    RawDatagramSocket socket,
  ) {
    //socket.joinMulticast(InternetAddress("225.1.2.3"));
    socket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        Datagram? datagram = socket.receive();
        if (datagram != null) {
          /*print(
            'Received ${datagram.data.length} bytes from '
            '${datagram.address.address}:${datagram.port}',
          );*/
          //print(datagram.data);
          while (true) {
            final lenght = datagram.data[1] * 256 + datagram.data[2];
            asterixPacket = datagram.data.sublist(0, lenght);
            Asterix asterixInfo = asterixDecoder.fromBinary(asterixPacket);
            /* print("SAC: ${asterixInfo.sac} SIC: ${asterixInfo.sic} ");
            print(
              "Time: ${asterixInfo.timeOfDay} category: ${asterixInfo.category}",
            ); */
            if (asterixInfo.category == 34) {
              final packet = asterixInfo as Asterix34;
              if (packet.antennaRotationPeriod != null) {
                //print(packet.antennaRotationPeriod);
              }
              if (packet.sectorNumber != null) {
                final deltaTheta =
                    (packet.sectorNumber! != 0.0
                        ? packet.sectorNumber!
                        : 360.0) -
                    lastSector;
                final deltaTime = packet.timeOfDay! - lastTimeSector;
                //print("${packet.sectorNumber} ->  ${deltaTheta / deltaTime}");
                lastSector = packet.sectorNumber!;
                lastTimeSector = packet.timeOfDay!;
              }
            }
            if (asterixInfo.category == 48) {
              final packet = asterixInfo as Asterix48;
              final amplitudePSR = packet.amplitudeOfprimaryPlot;
              final rho = packet.rho;
              final theta = packet.theta;
              if ((rho != null) & (theta != null) & (amplitudePSR != null)) {
                print("$rho,$theta,${-amplitudePSR!}");
              }
            }
            if (lenght == datagram.data.length) {
              //print("----------------------");
              break;
            } else {
              datagram.data = datagram.data.sublist(lenght);
            }
          }
        }
      }
    });
  });
}
