import '../utils/animal_translator.dart';

class Animal {
  final String name;
  final String scientificName;
  final String animalClass;
  final String diet;
  final String habitat;
  final String lifespan;
  final List<String> locations;

  const Animal({
    required this.name,
    required this.scientificName,
    required this.animalClass,
    required this.diet,
    required this.habitat,
    required this.lifespan,
    required this.locations,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    final taxonomy = Map<String, dynamic>.from(json['taxonomy'] ?? {});
    final characteristics = Map<String, dynamic>.from(
      json['characteristics'] ?? {},
    );

    return Animal(
      name: AnimalTranslator.animalName(
        json['name']?.toString() ?? 'Без названия',
      ),
      scientificName: taxonomy['scientific_name']?.toString() ?? 'Не указано',
      animalClass: AnimalTranslator.animalClass(
        taxonomy['class']?.toString() ?? 'Не указано',
      ),
      diet: AnimalTranslator.diet(
        characteristics['diet']?.toString() ?? 'Не указано',
      ),
      habitat: AnimalTranslator.habitat(
        characteristics['habitat']?.toString() ?? 'Не указано',
      ),
      lifespan: AnimalTranslator.lifespan(
        characteristics['lifespan']?.toString() ?? 'Не указано',
      ),
      locations: (json['locations'] as List<dynamic>? ?? [])
          .map((location) => AnimalTranslator.location(location.toString()))
          .toList(),
    );
  }
}
