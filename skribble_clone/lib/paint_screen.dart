import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PaintScreen extends StatefulWidget {
  final Map data;
  final String screenFrom;
  PaintScreen({required this.data, required this.screenFrom});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  late IO.Socket _socket;
  String dataOfRoom = "";
  @override
  void initState() {
    super.initState();
    connect();
    print(widget.data);
  }

// socket io client
  void connect() {
    _socket = IO.io('http://192.168.123.87:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();

    if (widget.screenFrom == 'createRoom') {
      _socket.emit('create-game', widget.data);
    }

    // listen to socket
    _socket.onConnect((data) => {
          print('Connected!'),
          _socket.on('updateRoom', (roomData) {
            setState(() {
              dataOfRoom = roomData;
            });

            if (roomData['isJoin'] != true) {
              // start timer
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
