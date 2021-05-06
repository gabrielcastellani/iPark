import 'package:flutter/material.dart';

import 'card_description.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key key, this.title, this.address, this.image, this.price})
      : super(key: key);

  final String title;
  final String address;
  final String image;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      width: double.maxFinite,
      height: 120,
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 1, child: createImage()),
              Expanded(
                  flex: 2,
                  child: CardDescription(
                    title: 'Estacionamento do seu zé',
                    address: 'Centro - Blumenau',
                    price: 5.0,
                  )),
              const Icon(Icons.favorite_rounded, color: Colors.red)
            ],
          ),
        ),
      ),
    );
  }

  Widget createImage() {
    return CircleAvatar(
      radius: 40,
      backgroundImage: NetworkImage(
          'https://s3-sa-east-1.amazonaws.com/projetos-artes/fullsize%2F2018%2F01%2F04%2F10%2FLogo-229396_96752_102434568_1554410255.jpg'),
    );
  }
}
