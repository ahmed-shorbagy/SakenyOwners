import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakeny_owners/core/utils/size_config.dart';
import 'package:sakeny_owners/features/Home/presentation/manager/upload_images_cubit/upload_images_cubit.dart';

class CustomImageSelector extends StatefulWidget {
  const CustomImageSelector({Key? key}) : super(key: key);

  @override
  State<CustomImageSelector> createState() => _CustomImageSelectorState();
}

class _CustomImageSelectorState extends State<CustomImageSelector> {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile> selectedImages = [];

  void selectImages() async {
    final List<XFile> pickedImages = await imagePicker.pickMultiImage();
    setState(() {
      selectedImages.addAll(pickedImages);
      UploadImagesCubit.imageFileList = selectedImages;
    });
  }

  void removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
      UploadImagesCubit.imageFileList = selectedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: selectImages,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              color: selectedImages.isEmpty
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
            child: selectedImages.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedImages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image:
                                    FileImage(File(selectedImages[index].path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.height * 0.2,
                          ),
                          Positioned(
                            top: SizeConfig.defaultSize! * 1,
                            right: SizeConfig.defaultSize! * 1,
                            child: GestureDetector(
                              onTap: () => removeImage(index),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'UPLOAD UP TO 6 PHOTOS',
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Icon(Icons.arrow_right)
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Icon(
                          Icons.add_a_photo,
                          size: 64,
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
