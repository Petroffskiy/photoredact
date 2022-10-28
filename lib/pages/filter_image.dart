import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photoredact/UI/platform_load_indicator.dart';
import 'package:photoredact/bloc/image_bloc.dart';
import 'package:photoredact/bloc/image_event.dart';
import 'package:photoredact/bloc/image_state.dart';
import 'package:photoredact/pages/photo_page.dart';
import 'dart:ui' as ui;

import '../data/filer.dart';

class FilerImage extends StatefulWidget {
  const FilerImage({Key? key}) : super(key: key);

  @override
  _FilterImage createState() => _FilterImage();
}

class _FilterImage extends State<FilerImage> {
  final GlobalKey _finalFilter = GlobalKey();
  final List<List<double>> filters = [
    SEPIA_MATRIX,
    GREYSCALE_MATRIX,
    VINTAGE_MATRIX,
    FILTER_1
  ];

  void convertWidgetToImage() async {
    RenderRepaintBoundary repaintBoundary = _finalFilter.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
    ByteData? byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8 = byteData!.buffer.asUint8List();
    BlocProvider.of<PhotoredactBloc>(context).add(
      SaveFilteredImage(dataImage: uint8),
    );
    Navigator.of(_finalFilter.currentContext!).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Фильтры"),
        actions: [
          IconButton(
              onPressed: () {
                convertWidgetToImage();
              },
              icon: const Icon(Icons.check)),
        ],
        backgroundColor: const Color(0xff616f8a),
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<PhotoredactBloc, PhotoredactState>(
          builder: (context, state) {
        if (state.status.isComplete && state.image != null) {
          return RepaintBoundary(
            key: _finalFilter,
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: size.width,
                  maxHeight: size.height,
                ),
                child: PageView.builder(
                  itemCount: filters.length,
                  itemBuilder: ((context, index) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.matrix(filters[index]),
                      child: Image.file(
                        File(state.image!),
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        } else {
          return Indicator();
        }
      }),
    );
  }
}
