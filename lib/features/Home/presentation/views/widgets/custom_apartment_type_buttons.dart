import 'package:flutter/material.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/apartment_cubit/apartment_cubit.dart';

class AppartmentTypeButtons extends StatefulWidget {
  const AppartmentTypeButtons({
    super.key,
  });

  @override
  State<AppartmentTypeButtons> createState() => _AppartmentTypeButtonsState();
}

bool isForMales = false;
bool isForFemales = false;

class _AppartmentTypeButtonsState extends State<AppartmentTypeButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: OutlinedButton(
            style: ButtonStyle(
              side: MaterialStatePropertyAll<BorderSide>(
                BorderSide(
                    color: isForMales
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.transparent,
                    width: 2),
              ),
            ),
            onPressed: () {
              setState(() {
                isForMales = true;
                isForFemales = false;
                ApartmentCubit.apartment.isForMales = isForMales;
              });
            },
            child: Text("Males only",
                style: Theme.of(context).textTheme.bodyLarge!),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: OutlinedButton(
            style: ButtonStyle(
              side: MaterialStatePropertyAll<BorderSide>(
                BorderSide(
                    color: isForFemales
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.transparent,
                    width: 2),
              ),
            ),
            onPressed: () {
              setState(() {
                isForMales = false;
                isForFemales = true;
                ApartmentCubit.apartment.isForMales = isForMales;
              });
            },
            child: Text("Females only",
                style: Theme.of(context).textTheme.bodyLarge!),
          ),
        ),
      ],
    );
  }
}
