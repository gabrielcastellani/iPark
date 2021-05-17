import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
        for (var image in images) {
          /*if (image == "") {
            return showAlertDialog1(context);
          }*/
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

        state.value.removeWhere((element) => element is String && element.isEmpty);

        var imgs = state.value.map<Widget>((image) {
          if ((image is String && image.isNotEmpty) || image is File)
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                if (image is String)
                    Image.network(image, fit: BoxFit.cover),
                if (image is File)
                  Image.file(image as File, fit: BoxFit.cover),
              ],
            );
          else {
            adicionouMaterial = true;
            return material;
          }
        }).toList();

        if (!adicionouMaterial){
          imgs.add(material);
        }


        return Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
<<<<<<< HEAD
              child: Material(
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
                      ),
                    );
                  },
                ),
=======
              child: Carousel(
                images: imgs,
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).primaryColor,
                autoplay: false,

>>>>>>> efef854d657ad23671b77bbe5decb35951ee1ad1
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
