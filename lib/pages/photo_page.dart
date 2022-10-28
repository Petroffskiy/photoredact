// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photofilters/photofilters.dart';
import 'package:photoredact/bloc/image_bloc.dart';
import 'package:photoredact/bloc/image_event.dart';
import 'package:photoredact/bloc/image_state.dart';
import 'package:photoredact/data/models/photo_hive.dart';
import 'package:photoredact/pages/filter_image.dart';

import '../UI/platform_load_indicator.dart';
import 'crop_page.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  _Photo createState() => _Photo();
}

class _Photo extends State<PhotoPage> {
  Uint8List? dataImage;
  String? imageString;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Фоторедактор",
        ),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<PhotoredactBloc>(context).add(SaveToHistory());
              },
              icon: const Icon(Icons.save))
        ],
        backgroundColor: const Color(0xff616f8a),
      ),
      body: BlocBuilder<PhotoredactBloc, PhotoredactState>(
        builder: ((context, state) {
          if (state.status.isLoading) {
            return Indicator();
          } else if (state.status.isComplete && state.image != null) {
            imageString =
                convertImageToString(dataImage: state.dataFilteredImage);
            dataImage = convertImageToUint(imageString: state.image!);
            return Column(
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: size.width,
                      maxHeight: size.height - 60,
                    ),
                    child: state.dataFilteredImage != null
                        ? Image.memory(state.dataFilteredImage!)
                        : Image.file(File(state.image!)),
                  ),
                ),
                Container(
                  color: Colors.black,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              filterImage(
                                  context: context, imageString: state.image!);
                            },
                            icon: const Icon(
                              Icons.filter,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      ExtendedImageExample()),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.crop,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: Text("Произошла какая-то ошибка"),
            );
          }
        }),
      ),
    );
  }

  addPhotoToHistory(File photo) async {
    Box<HivePhoto> photo = await Hive.openBox<HivePhoto>('photo');
    // photo.put('photo', ('image' : photo));
  }

  Uint8List convertImageToUint({required String imageString}) {
    final List<int> codeUnits = imageString.codeUnits;
    final Uint8List dataImage = Uint8List.fromList(codeUnits);
    return dataImage;
  }

  String? convertImageToString({required Uint8List? dataImage}) {
    if (dataImage != null) {
      return String.fromCharCodes(dataImage);
    } else {
      return null;
    }
  }

  Future filterImage(
      {required BuildContext context, required String imageString}) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const FilerImage()));
  }
}
