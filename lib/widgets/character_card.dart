import 'package:flutter/material.dart';

import '../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(60, 62, 68, 1),
      margin: const EdgeInsets.all(8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                character.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  Text(character.species,
                    style: const TextStyle(
                      color: Colors.white70
                    ),
                  ),
                  Text(character.status,
                    style: const TextStyle(
                        color: Colors.white70
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
