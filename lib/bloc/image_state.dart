import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum PhotoStatus {
  loading,
  complete,
  error,
}

extension PhotoStatusX on PhotoStatus {
  bool get isLoading => this == PhotoStatus.loading;

  bool get isComplete => this == PhotoStatus.complete;

  bool get isError => this == PhotoStatus.error;
}

class PhotoredactState extends Equatable {
  final String? image;
  final PhotoStatus status;
  final Uint8List? dataFilteredImage;
  const PhotoredactState({
    this.image,
    this.dataFilteredImage,
    this.status = PhotoStatus.loading,
  });
  PhotoredactState copyWith({
    String? image,
    PhotoStatus? status,
    Uint8List? dataFiltredImage,
  }) {
    return PhotoredactState(
      image: image ?? this.image,
      status: status ?? this.status,
      dataFilteredImage: dataFiltredImage ?? this.dataFilteredImage,
    );
  }

  @override
  List<Object?> get props => [
        image,
        status,
        dataFilteredImage,
      ];
}
