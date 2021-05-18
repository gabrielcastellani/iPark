import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:app_estacionamento/app/pages/parking/view/view_parking_page.dart';
import 'package:flutter/material.dart';

import '../../models/parking_model.dart';
import 'card_description.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(this.parkingModel);

  final ParkingModel parkingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      width: double.maxFinite,
      height: 120,
      child: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => ViewParkingPage(parkingModel))),
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 1, child: createImage(parkingModel)),
                Expanded(
                    flex: 2,
                    child: CardDescription(
                      title: parkingModel.name,
                      address: 'Centro - Blumenau',
                      price: parkingModel.parkingSpaceValue,
                    )),
                const Icon(Icons.favorite_rounded, color: Colors.red)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createImage(ParkingModel model) {
    String path = "";

    if (model.images != null && model.images.length > 0)
      path = model.images[0];
    else
      path =
          "https://s3-sa-east-1.amazonaws.com/projetos-artes/fullsize%2F2018%2F01%2F04%2F10%2FLogo-229396_96752_102434568_1554410255.jpg";

    return CircleAvatar(radius: 40, backgroundImage: NetworkImage(path));
  }
}
