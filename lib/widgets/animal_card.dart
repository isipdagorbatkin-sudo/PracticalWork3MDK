import 'package:flutter/material.dart';

import '../models/animal.dart';

class AnimalCard extends StatelessWidget {
  final Animal animal;

  const AnimalCard({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE1ECF7),
          child: Text(
            animal.name.isEmpty ? '?' : animal.name[0].toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF315A8A),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          animal.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(animal.scientificName),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          _InfoRow(
            icon: Icons.category,
            title: 'Класс',
            value: animal.animalClass,
          ),
          _InfoRow(
            icon: Icons.restaurant,
            title: 'Питание',
            value: animal.diet,
          ),
          _InfoRow(icon: Icons.park, title: 'Среда', value: animal.habitat),
          _InfoRow(
            icon: Icons.schedule,
            title: 'Жизнь',
            value: animal.lifespan,
          ),
          _InfoRow(
            icon: Icons.public,
            title: 'Места',
            value: animal.locations.isEmpty
                ? 'Не указано'
                : animal.locations.join(', '),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF315A8A)),
          const SizedBox(width: 10),
          SizedBox(
            width: 76,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
