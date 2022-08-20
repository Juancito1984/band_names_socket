import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:band_names/pages/widgets_home/band_tile.dart';
import '../models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Miel San Marcos', votes: 5),
    Band(id: '1', name: 'Roberto Orellana', votes: 10),
    Band(id: '1', name: 'Remanente de salvacion', votes: 15),
    Band(id: '1', name: 'Marcos Barrientos', votes: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: const Text(
            'BandNames',
            style: TextStyle(color: Colors.black87),
          )),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) {
          return BandTile(
            bands: bands,
            index: index,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  void addNewBand() {
    final textEditingController = TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('New band names'),
              content: TextField(
                controller: textEditingController,
              ),
              actions: [
                MaterialButton(
                  elevation: 5,
                  textColor: Theme.of(context).primaryColor,
                  child: const Text('Add'),
                  onPressed: () {
                    addBandToList(textEditingController.text);
                  },
                ),
              ],
            );
          });
    } else {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('New band name'),
            content: CupertinoTextField(
              controller: textEditingController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Add'),
                onPressed: () {
                  addBandToList(textEditingController.text);
                  print(textEditingController.text);
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text('Dismiss'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      bands.add(
        Band(
          id: DateTime.now().toString(),
          name: name,
          votes: name.length,
        ),
      );
      setState(() {});
    } else {
      print('Debe colocar un nombre');
    }

    Navigator.pop(context);
  }
}
