import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:app_estacionamento/app/pages/parking/newParking_page.dart';

class ParkingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            child: new ParkingList(),
          ),
        ),
      ),
    );
  }
}

class ParkingList extends StatefulWidget {
  ParkingList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ParkingListState createState() => new _ParkingListState();
}

class _ParkingListState extends State<ParkingList> {
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return new ListView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      controller: _controller,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
      shrinkWrap: false,
      children: <Widget>[
        GestureDetector(
          onTap: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => NewParkingPage()))
          },
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outlined,
                      color: Colors.green,
                    ),
                    Text(
                      'Novo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        createListView(5),
      ],
    );
  }

  Widget createListView(int number) {
    List<Widget> containers = [];
    for (var i = 0; i < number; i++) {
      Widget container = createContainer();
      containers.add(container);
    }

    return new ListView(
      physics: const BouncingScrollPhysics(),
      controller: _controller,
      shrinkWrap: true,
      children: containers,
    );
  }

  Widget createContainer() {
    return new Container(
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://www.melhoresdestinos.com.br/wp-content/uploads/2020/02/estacionamento-capa2019-01-820x430.jpg",
                  ),
                  width: 150,
                  height: 150,
                ),
              ),
              Container(
                width: 150,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Nome: Teste',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Vagas: 2',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Preço: 15',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
