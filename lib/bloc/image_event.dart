import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class PhotoredactEvent extends Equatable {
  const PhotoredactEvent();
}

class SaveImage extends PhotoredactEvent {
  final String image;

  const SaveImage({required this.image});

  @override
  List<Object?> get props => [
        image,
      ];
}

class SaveFilteredImage extends PhotoredactEvent {
  final Uint8List dataImage;

  const SaveFilteredImage({required this.dataImage});

  @override
  List<Object?> get props => [dataImage];
}

class SaveToHistory extends PhotoredactEvent {
  final File image;
  const SaveToHistory({required this.image});
  @override
  List<Object?> get props => [image];
}
