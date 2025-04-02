import 'dart:io';

import 'package:asterix/asterix.dart';

void main() {
  final asterixDecoder = AsterixDecoder();
  List<int> asterixPacket = [];

  RawDatagramSocket.bind(InternetAddress.anyIPv4, 20158).then((
    RawDatagramSocket socket,
  ) {
    socket.joinMulticast(InternetAddress("225.1.2.3"));
    socket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        Datagram? datagram = socket.receive();
        if (datagram != null) {
          print(
            'Received ${datagram.data.length} bytes from '
            '${datagram.address.address}:${datagram.port}',
          );
          print(datagram.data);
          final lenght = datagram.data[1] * 256 + datagram.data[2];
          asterixPacket = datagram.data.sublist(0, lenght);
          Asterix asterixInfo = asterixDecoder.fromBinary(asterixPacket);
          print("SAC: ${asterixInfo.sac} SIC: ${asterixInfo.sic} ");
          print("Time: ${asterixInfo.timeOfDay}");
        }
      }
    });
  });
}
