import 'dart:io';

import 'package:hive/hive.dart';
part 'photo_hive.g.dart';

@HiveType(typeId: 0)
class HivePhoto extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  File image;

  HivePhoto({
    required this.image,
    required this.id,
  });
}
