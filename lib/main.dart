import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:photoredact/bloc/image_bloc.dart';
import 'package:photoredact/pages/main_page.dart';

void main() async { runApp(MainPageWrapper());
await Hive.initFlutter();}

class MainPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PhotoredactBloc(),
      child: const MainPage(),
    );
  }
}
