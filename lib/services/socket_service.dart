import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  onLine,
  offLine,
  connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;

  get serverStatus => _serverStatus;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    //Dart client
    IO.Socket socket = IO.io('http://192.168.1.7:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.on('connect', (data) {
      print('DATA CONNET IS: $data');
      _serverStatus = ServerStatus.onLine;
      notifyListeners();
    });

    socket.on('disconnect', (data) {
      print('DATA DISCONNECT IS: $data');
      _serverStatus = ServerStatus.offLine;
      notifyListeners();
    });

    socket.on('nuevo-mensaje', (payload) {
      print('NUEVO MENSAJE:');
      print('NOMBRE: ${payload['nombre']}');
      print('MENSAJE: ${payload['mensaje']}');
      print(payload.containsKey('mensaje2')?payload['mensaje2']:'No hay mensaje2');
    });
  }
}
