import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeny_owners/core/utils/helper_methodes.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/apartment_cubit/apartment_cubit.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/upload_apartment_cubit/upload_apartment_cubit.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/upload_images_cubit/upload_images_cubit.dart';
import 'package:sakeny_owners/features/Home/presentation/views/add_new_appartment_view.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_apartment_type_buttons.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_button.dart';

class UploadButtonWithCubitLogic extends StatelessWidget {
  const UploadButtonWithCubitLogic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadImagesCubit, UploadImagesState>(
      builder: (context, state) {
        if (state is UploadImagesLoading) {
          return AbsorbPointer(
              child: CustomButton(
            onPressed: () async {
              if (formkey.currentState!.validate()) {
                if (isForMales || isForFemales) {
                  formkey.currentState!.save();

                  await BlocProvider.of<UploadImagesCubit>(context)
                      .uploadImage(images: UploadImagesCubit.imageFileList);
                } else {
                  snackBar(context, 'Please select the gender');
                }
              } else {
                autovalidateMode = AutovalidateMode.always;
              }
            },
            child: const Center(child: CircularProgressIndicator()),
          ));
        } else {
          return CustomButton(
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  if (isForMales || isForFemales) {
                    formkey.currentState!.save();
                    await BlocProvider.of<UploadImagesCubit>(context)
                        .uploadImage(images: UploadImagesCubit.imageFileList);
                  } else {
                    snackBar(context, 'Please select the gender');
                  }
                } else {
                  autovalidateMode = AutovalidateMode.always;
                }
              },
              child: Text(
                'Upload',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ));
        }
      },
      listener: (context, state) async {
        if (state is UploadImagesSuccess) {
          ApartmentCubit.apartment.photosUrls = state.photosUrl;
          ApartmentCubit.apartment.time = Timestamp.now();
          await BlocProvider.of<UploadApartmentCubit>(context)
              .addNewApartmentToFireStore(
                  buildingID: ApartmentCubit.apartment.buildingID!,
                  apartment: ApartmentCubit.apartment);
        }
      },
    );
  }
}
