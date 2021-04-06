import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:app_estacionamento/app/providers/parking_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewParkingPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ParkingModel _parkingModel = ParkingModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                Center(
                  child: const Text(
                    'Cadastrar um novo estacionamento',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  keyboardType: TextInputType.name,
                  onSaved: (name) => _parkingModel.name = name,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                  keyboardType: TextInputType.multiline,
                  onSaved: (description) =>
                      _parkingModel.description = description,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (phone) => _parkingModel.phone = phone,
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 60,
                  child: RaisedButton(
                    color: Colors.red,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.red),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        context
                            .read<ParkingProvider>()
                            .create(parking: _parkingModel);

                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'CADASTRAR',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
