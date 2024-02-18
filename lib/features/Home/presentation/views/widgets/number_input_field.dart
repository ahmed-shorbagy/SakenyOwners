import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputFormField extends StatelessWidget {
  final String labelText;
  final Function(String)? onChanged;
  final IconData icon;

  const NumberInputFormField({
    Key? key,
    required this.labelText,
    this.onChanged,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This Field is required';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        focusedBorder:
            CustomBorder(context, Theme.of(context).colorScheme.secondary),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        border: CustomBorder(context, Theme.of(context).colorScheme.secondary),
        prefixIcon: Icon(icon),
        fillColor: Colors.grey[200],
      ),
      onChanged: onChanged,
    );
  }

  UnderlineInputBorder CustomBorder(BuildContext context, Color color) {
    return UnderlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: const BorderRadius.all(Radius.circular(8)));
  }
}
