import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.onChanged,
  });
  final String title;
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Theme.of(context).colorScheme.secondary,
      title: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: onChanged,
            maxLines: 5,
            minLines: 5,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
          ),
        )
      ],
    );
  }
}
