import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeny_owners/core/utils/helper_methodes.dart';
import 'package:sakeny_owners/core/utils/size_config.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/apartment_cubit/apartment_cubit.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/upload_apartment_cubit/upload_apartment_cubit.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/upload_images_cubit/upload_images_cubit.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/Building_id_numberFeild.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/Custom_app_bar.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_apartment_type_buttons.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_button.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_image_slector.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_row_of_inputs.dart';

class AddNewAppartmentView extends StatefulWidget {
  const AddNewAppartmentView({super.key});

  @override
  State<AddNewAppartmentView> createState() => _AddNewAppartmentViewState();
}

final GlobalKey<FormState> formkey = GlobalKey();
AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

class _AddNewAppartmentViewState extends State<AddNewAppartmentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            autovalidateMode: autovalidateMode,
            child: BlocListener<UploadApartmentCubit, UploadApartmentState>(
              listener: (context, state) {
                if (state is UploadApartmentSuccess) {
                  log('sucessssssss');
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomAppBar(),
                  SizedBox(
                    height: SizeConfig.screenhieght! * 0.04,
                  ),
                  const CustomImageSelector(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: CustomRowOfInputs(
                        onChangedRooms: (value) {
                          ApartmentCubit.apartment.numberOfSingleRooms =
                              int.parse(value);
                        },
                        onChangedPrice: (value) {
                          ApartmentCubit.apartment.priceOfOneBedInSingleroom =
                              double.parse(value);
                        },
                        labelText1: 'single rooms',
                        labelText2: 'Price'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: CustomRowOfInputs(
                        onChangedRooms: (value) {
                          ApartmentCubit.apartment.numberOfDoubleRooms =
                              int.parse(value);
                        },
                        onChangedPrice: (value) {
                          ApartmentCubit.apartment.priceOfOneBedInDoubleroom =
                              double.parse(value);
                        },
                        labelText1: 'double rooms',
                        labelText2: 'Price'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: CustomRowOfInputs(
                        onChangedRooms: (value) {
                          ApartmentCubit.apartment.numberOfTripleRooms =
                              int.parse(value);
                        },
                        onChangedPrice: (value) {
                          ApartmentCubit.apartment.priceOfOneBedInTripleroom =
                              double.parse(value);
                        },
                        labelText1: 'Triple rooms',
                        labelText2: 'Price'),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: BuildingIdNumberField(
                        onChanged: (value) {
                          ApartmentCubit.apartment.buildingID =
                              int.parse(value);
                        },
                        labelText: 'Building ID',
                        icon: Icons.center_focus_strong),
                  ),
                  const AppartmentTypeButtons(),
                  Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 32),
                    child: BlocConsumer<UploadImagesCubit, UploadImagesState>(
                      builder: (context, state) {
                        if (state is UploadImagesLoading) {
                          return AbsorbPointer(
                              child: CustomButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                if (isForMales || isForFemales) {
                                  formkey.currentState!.save();

                                  await BlocProvider.of<UploadImagesCubit>(
                                          context)
                                      .uploadImage(
                                          images:
                                              UploadImagesCubit.imageFileList);
                                } else {
                                  snackBar(context, 'Please select the gender');
                                }
                              } else {
                                autovalidateMode = AutovalidateMode.always;
                              }
                            },
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ));
                        } else {
                          return CustomButton(
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  if (isForMales || isForFemales) {
                                    formkey.currentState!.save();
                                    await BlocProvider.of<UploadImagesCubit>(
                                            context)
                                        .uploadImage(
                                            images: UploadImagesCubit
                                                .imageFileList);
                                  } else {
                                    snackBar(
                                        context, 'Please select the gender');
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
                          await BlocProvider.of<UploadApartmentCubit>(context)
                              .addNewApartmentToFireStore(
                                  buildingID:
                                      ApartmentCubit.apartment.buildingID!,
                                  apartment: ApartmentCubit.apartment);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
