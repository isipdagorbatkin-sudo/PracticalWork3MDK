import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interceptors/api_key_interceptor.dart';
import 'pages/animals_page.dart';
import 'services/animal_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.api-ninjas.com/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.addAll([
    ApiKeyInterceptor(),
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: true,
    ),
  ]);

  getIt.registerSingleton<Dio>(dio);
  getIt.registerLazySingleton<AnimalService>(() => AnimalService(getIt<Dio>()));
}

void main() {
  setupDependencies();
  runApp(const AnimalFinderApp());
}

class AnimalFinderApp extends StatelessWidget {
  const AnimalFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Поиск животных',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF315A8A),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const AnimalsPage(),
    );
  }
}
