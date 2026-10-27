import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/animal.dart';
import '../services/animal_service.dart';
import '../widgets/animal_card.dart';

class AnimalsPage extends StatefulWidget {
  const AnimalsPage({super.key});

  @override
  State<AnimalsPage> createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
  final AnimalService animalService = getIt<AnimalService>();
  final TextEditingController searchController = TextEditingController(
    text: 'лиса',
  );

  List<Animal> animals = [];
  bool isLoading = false;
  String errorMessage = '';
  String lastQuery = 'лиса';

  @override
  void initState() {
    super.initState();
    searchAnimals();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> searchAnimals() async {
    final query = searchController.text.trim();
    if (query.isEmpty) {
      setState(() => errorMessage = 'Введите название животного');
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
      errorMessage = '';
      lastQuery = query;
    });

    try {
      final result = await animalService.getAnimals(query);
      if (!mounted) return;
      setState(() {
        animals = result;
        if (result.isEmpty) {
          errorMessage = 'Ничего не найдено. Попробуйте другое название.';
        }
      });
    } on DioException catch (error) {
      if (!mounted) return;
      setState(() {
        if (error.response?.statusCode == 401) {
          errorMessage = 'API-ключ недействителен';
        } else {
          errorMessage = 'Не удалось загрузить данные. Проверьте интернет.';
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => errorMessage = 'Произошла ошибка при загрузке данных');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void useExample(String value) {
    searchController.text = value;
    searchAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF315A8A),
        foregroundColor: Colors.white,
        title: const Text('Поиск животных'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: searchAnimals,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Узнай больше о животных',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Введите название животного на русском языке',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final field = TextField(
                  controller: searchController,
                  onSubmitted: (_) => searchAnimals(),
                  decoration: const InputDecoration(
                    hintText: 'Например: лев, лиса, дельфин',
                    prefixIcon: Icon(Icons.search),
                  ),
                );
                final button = FilledButton.icon(
                  onPressed: isLoading ? null : searchAnimals,
                  icon: const Icon(Icons.travel_explore),
                  label: const Text('Найти'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                  ),
                );

                if (constraints.maxWidth < 600) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [field, const SizedBox(height: 12), button],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: field),
                    const SizedBox(width: 12),
                    button,
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['лев', 'лиса', 'дельфин', 'панда']
                  .map(
                    (name) => ActionChip(
                      label: Text(name),
                      onPressed: isLoading ? null : () => useExample(name),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(40),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (errorMessage.isNotEmpty)
              _ErrorBlock(message: errorMessage, onRetry: searchAnimals)
            else ...[
              Text(
                'Результаты для «$lastQuery»: ${animals.length}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ...animals.map((animal) => AnimalCard(animal: animal)),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorBlock extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorBlock({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}
