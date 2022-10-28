import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:photoredact/bloc/image_event.dart';
import 'package:photoredact/bloc/image_state.dart';
import 'package:photoredact/data/models/photo_hive.dart';

class PhotoredactBloc extends Bloc<PhotoredactEvent, PhotoredactState> {
  PhotoredactBloc() : super(const PhotoredactState()) {
    on<SaveImage>(_saveImage);
    on<SaveFilteredImage>(_saveFiltered);
    on<SaveToHistory>(_saveHistory);
  }

  void _saveImage(SaveImage event, Emitter<PhotoredactState> emit) {
    emit(
      state.copyWith(status: PhotoStatus.loading),
    );
    if (event.image != null) {
      emit(
        state.copyWith(
          status: PhotoStatus.complete,
          image: event.image,
        ),
      );
    } else {
      state.copyWith(status: PhotoStatus.error);
    }
  }

  void _saveFiltered(SaveFilteredImage event, Emitter<PhotoredactState> emit) {
    emit(
      state.copyWith(status: PhotoStatus.loading),
    );

    if (event.dataImage != null) {
      emit(
        state.copyWith(
          status: PhotoStatus.complete,
          dataFiltredImage: event.dataImage,
        ),
      );
    } else {
      state.copyWith(status: PhotoStatus.error);
    }
  }

  Future<void> _saveHistory(
      SaveToHistory event, Emitter<PhotoredactState> emit) async {
    emit(
      state.copyWith(status: PhotoStatus.loading),
    );

    Box<HivePhoto> photo = await Hive.openBox('photo');
    //TODO будет осуществляться загрузка в локальное ханилище, после чего история будет отображаться из всей коробки
    photo.add(0)
    
  }
}
