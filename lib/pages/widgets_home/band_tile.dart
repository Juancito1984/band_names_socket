import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';

class BandTile extends StatelessWidget {
  final List<Band> bands;
  final int index;

  const BandTile({
    Key? key,
    required this.bands,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(bands[index].id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        print('direction: $direction');
        print('id: ${bands[index].id}');
        bands.removeAt(index);
        //TODO: llamar al borrado en el server
      },
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10),
        color: Colors.red,
        child: const Text(
          'Deleted Band',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(
            bands[index].name.substring(0, 2),
          ),
        ),
        title: Text(bands[index].name),
        trailing: Text(
          '${bands[index].votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(bands[index].name);
        },
      ),
    );
  }
}
