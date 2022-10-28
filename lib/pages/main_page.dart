import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photoredact/bloc/image_bloc.dart';
import 'package:photoredact/bloc/image_event.dart';
import 'package:photoredact/bloc/image_state.dart';
import 'package:photoredact/pages/photo_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  File? _image;

  Future getImageFromGallery({required bool isGallery}) async {
    XFile? image;
    if (isGallery == true) {
      image = await ImagePicker.platform.getImage(source: ImageSource.gallery);
    } else {
      image = await ImagePicker.platform.getImage(source: ImageSource.camera);
    }
    setState(() {
      _image = File(image!.path) ?? null;
    });
    BlocProvider.of<PhotoredactBloc>(context)
        .add(SaveImage(image: _image!.path));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Фоторедактор"),
              backgroundColor: const Color(0xff616f8a),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.history))
              ],
            ),
            body: BlocListener<PhotoredactBloc, PhotoredactState>(
              listener: (context, state) {
                if (state.image != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const PhotoPage(),
                    ),
                  );
                }
              },
              child: GestureDetector(
                onTap: () {
                  print("tap on print");
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Фото"),
                        content: const Text("Выберите способ загрузки фото"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              getImageFromGallery(isGallery: false);
                              if (_image != null) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PhotoPage()));
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text("Камера"),
                          ),
                          TextButton(
                            onPressed: () {
                              getImageFromGallery(isGallery: true);

                              // BlocProvider.of<PhotoredactBloc>(context)
                              // .add(SaveImage(image: _image!));
                            },
                            child: const Text("Галерея"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_a_photo_outlined,
                        size: 100,
                        color: Color(0xff616f8a),
                      ),
                      const Text(
                        " Добавить фото",
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
