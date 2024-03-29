import 'dart:io';
import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:flutter/material.dart';

import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.parkingModel);

  final ParkingModel parkingModel;

  showAlertDialog1(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text("Favor inserir ao menos uma imagem!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(parkingModel.images),
      validator: (images) {
        if (!images.any((element) => element != "")) {
          return showAlertDialog1(context);
        }
        return null;
      },
      builder: (state) {
        void onImageSelected(File file) {
          state.value.add(file);
          state.didChange(state.value);
          parkingModel.images.add(file.path);
          Navigator.of(context).pop();
        }

        var material = Material(
          color: Colors.grey[100],
          child: IconButton(
            icon: Icon(Icons.add_a_photo),
            color: Theme.of(context).primaryColor,
            iconSize: 50,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => ImageSourceSheet(
                        onImageSelected: onImageSelected,
                      ));
            },
          ),
        );
        bool adicionouMaterial = false;

        state.value
            .removeWhere((element) => element is String && element.isEmpty);

        var imgs = state.value.map<Widget>((image) {
          if ((image is String && image.isNotEmpty) || image is File)
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                if (image is String) Image.network(image, fit: BoxFit.cover),
                if (image is File) Image.file(image, fit: BoxFit.cover),
              ],
            );
          else {
            adicionouMaterial = true;
            return material;
          }
        }).toList();

        if (!adicionouMaterial) {
          imgs.add(material);
        }

        return Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: imgs,
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).primaryColor,
                autoplay: false,
              ),
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
    );
  }
}
