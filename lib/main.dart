import 'package:flutter/material.dart';
import 'package:flutter_application_8/plant_cubit.dart';
import 'package:flutter_application_8/services/plant_api_service.dart';
import 'package:flutter_application_8/widgets/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final plantApiService = PlantApiService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PlantCubit>(
          create: (context) => PlantCubit(plantApiService)..getPlants(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Care App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const SplashScreen(), 
    );
  }
}
