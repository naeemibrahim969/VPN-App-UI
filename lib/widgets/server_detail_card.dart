import 'package:flutter/material.dart';

import '../models/server_data.dart';

class ServerDetailCard extends StatelessWidget {

  const ServerDetailCard({super.key, required this.data});
  final ServerData data;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: size.height * .01),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

            //flag
            leading: Icon(data.icon.icon,
                color: data.icon.color, size: data.icon.size ?? 28),

            //title
            title: Text(data.title),

            //subtitle
            subtitle: Text(data.subtitle),
          ),
        ));
  }
}
