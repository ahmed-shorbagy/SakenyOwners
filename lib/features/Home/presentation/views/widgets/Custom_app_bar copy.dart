import 'package:flutter/material.dart';

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
