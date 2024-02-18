import 'package:flutter/material.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/number_input_field.dart';

class CustomRowOfInputs extends StatelessWidget {
  const CustomRowOfInputs({
    super.key,
    required this.labelText1,
    required this.labelText2,
    required this.onChangedRooms,
    required this.onChangedPrice,
  });
  final String labelText1;
  final String labelText2;
  final Function(String) onChangedRooms;
  final Function(String) onChangedPrice;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: NumberInputFormField(
                icon: Icons.numbers,
                labelText: labelText1,
                onChanged: onChangedRooms),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: NumberInputFormField(
                icon: Icons.money_off,
                labelText: labelText2,
                onChanged: onChangedPrice),
          ),
        ),
      ],
    );
  }
}
