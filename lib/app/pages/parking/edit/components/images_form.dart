import 'dart:io';

import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:flutter/material.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.parkingModel);

  final ParkingModel parkingModel;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
        initialValue: List.from(parkingModel.images),

        validator: (images) {
          if (images.isEmpty) {
            return 'Insira ao menos uma imagem';
          }
          for (var image in images as List<Image>) {
            print(image);
          }
          return null;
        },
        builder: (state) {
          void onImageSelected(File file) {
            state.value.add(file);
            state.didChange(state.value);
            Navigator.of(context).pop();
          }

          return Column(
            children: <Widget>[
              AspectRatio(
                  aspectRatio: 1,
                  child: Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      color: Theme
                          .of(context)
                          .primaryColor,
                      iconSize: 50,
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) =>
                                ImageSourceSheet(
                                  onImageSelected: onImageSelected,
                                ));
                      },
                    ),
                  )
              ),
              if (state.hasError)
                Text(
                  state.errorText,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                )
            ],
          );
        },
        onSaved: (images) {
          for (var image in images) {
            print(image);
          }
        },
    );
  }
}
