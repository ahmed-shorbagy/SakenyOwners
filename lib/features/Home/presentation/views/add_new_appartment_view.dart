import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeny_owners/core/utils/size_config.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/apartment_cubit/apartment_cubit.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/upload_apartment_cubit/upload_apartment_cubit.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/Building_id_numberFeild.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/Custom_app_bar.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_apartment_type_buttons.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_expansion_tile.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_image_slector.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_phoneField.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_row_of_inputs.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/custom_underLine_textField.dart';
import 'package:sakeny_owners/features/Home/presentation/views/widgets/upload_button_withCubitLogic.dart';

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
                          ApartmentCubit.apartment.numberOfSingleBeds = value;
                        },
                        onChangedPrice: (value) {
                          if (value.isNotEmpty) {
                            ApartmentCubit.apartment.priceOfOneBedInSingleBeds =
                                num.parse(value);
                          }
                          if (value == '0') {
                            ApartmentCubit.apartment.type!.remove('single');
                          } else {
                            if (!ApartmentCubit.apartment.type!
                                .contains('single')) {
                              ApartmentCubit.apartment.type!.add('single');
                            }
                          }
                        },
                        labelText1: 'single beds',
                        labelText2: 'Price'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: CustomRowOfInputs(
                        onChangedRooms: (value) {
                          ApartmentCubit.apartment.numberOfDoubleBeds = value;
                        },
                        onChangedPrice: (value) {
                          if (value.isNotEmpty) {
                            ApartmentCubit.apartment.priceOfOneBedInDoubleBeds =
                                num.parse(value);
                          }
                          if (value == '0') {
                            ApartmentCubit.apartment.type!.remove('double');
                          } else {
                            if (!ApartmentCubit.apartment.type!
                                .contains('double')) {
                              ApartmentCubit.apartment.type!.add('double');
                            }
                          }
                        },
                        labelText1: 'double beds',
                        labelText2: 'Price'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: CustomRowOfInputs(
                        onChangedRooms: (value) {
                          ApartmentCubit.apartment.numberOfTripleBeds = value;
                        },
                        onChangedPrice: (value) {
                          if (value.isNotEmpty) {
                            ApartmentCubit.apartment.priceOfOneBedInTripleBeds =
                                num.parse(value);
                          }
                          if (value == '0') {
                            ApartmentCubit.apartment.type!.remove('triple');
                          } else {
                            // Check if 'triple' is already present in the type list
                            if (!ApartmentCubit.apartment.type!
                                .contains('triple')) {
                              ApartmentCubit.apartment.type!.add('triple');
                            }
                          }
                          log(ApartmentCubit.apartment.type.toString());
                        },
                        labelText1: 'Triple beds',
                        labelText2: 'Price'),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: CustomUnderLineTextField(
                        onChanged: (value) {
                          ApartmentCubit.apartment.ownerName = value;
                        },
                        label: 'Owner Name',
                        suffixIcon: const Icon(Icons.center_focus_strong)),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      child: CustomPhoneField(
                          autoValidateMode: autovalidateMode,
                          onChanged: (value) {
                            ApartmentCubit.apartment.ownerPhone =
                                value?.international ?? '';
                          })),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: BuildingIdNumberField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            ApartmentCubit.apartment.buildingID =
                                int.parse(value);
                          }
                        },
                        labelText: 'Building ID',
                        icon: Icons.center_focus_strong),
                  ),
                  CustomExpansionTile(
                    title: 'Owner Description',
                    onChanged: (value) {
                      ApartmentCubit.apartment.ownerDescription = value;
                    },
                  ),
                  CustomExpansionTile(
                    title: 'User Description',
                    onChanged: (value) {
                      ApartmentCubit.apartment.userDescription = value;
                    },
                  ),
                  const AppartmentTypeButtons(),
                  const Padding(
                    padding: EdgeInsets.only(top: 32, bottom: 32),
                    child: UploadButtonWithCubitLogic(),
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
