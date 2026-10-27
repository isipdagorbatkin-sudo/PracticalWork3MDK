import 'package:dio/dio.dart';

import '../models/animal.dart';
import '../utils/animal_translator.dart';

class AnimalService {
  final Dio dio;

  AnimalService(this.dio);

  Future<List<Animal>> getAnimals(String name) async {
    final response = await dio.get(
      '/animals',
      queryParameters: {'name': AnimalTranslator.searchQuery(name)},
    );

    final data = response.data as List<dynamic>;
    return data
        .map((item) => Animal.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
