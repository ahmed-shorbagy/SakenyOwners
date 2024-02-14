import 'package:flutter/material.dart';
import 'package:sakeny_owners/core/utils/size_config.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/Custom_app_bar.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_image_slector.dart';

class AddNewAppartmentView extends StatelessWidget {
  const AddNewAppartmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(),
            SizedBox(
              height: SizeConfig.screenhieght! * 0.04,
            ),
            const CustomImageSelector(),
          ],
        ),
      ),
    );
  }
}
