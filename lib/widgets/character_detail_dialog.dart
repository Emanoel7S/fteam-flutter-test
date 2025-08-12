import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterDetailDialog extends StatelessWidget {
  final Character character;

  const CharacterDetailDialog({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        character.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              character.image,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 8),
              Text('Status: ${character.status}'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0), // Applies 20 pixels of padding to the left and right
                child: iconStatus(character.status),
              ),

            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 8),
              Text('Espécie: ${character.species}'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Fechar'),
        ),
      ],
    );
  }

 Icon iconStatus(String status) {
    return
      status == 'Alive'
          ? const Icon(Icons.circle, color: Colors.green, size: 14,)
          : status == 'Dead'
              ? const Icon(Icons.circle, color: Colors.red, size: 14,)
              : const Icon(Icons.circle, color: Colors.grey, size: 14,);
  }
}