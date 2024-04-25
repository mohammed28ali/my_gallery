import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/src/core/extenstions/empty_box_extention.dart';
import 'package:my_gallery/src/core/extenstions/size_extention.dart';
import 'package:my_gallery/src/core/extenstions/toast_extention.dart';
import 'package:my_gallery/src/core/utils/app_colors.dart';
import 'package:my_gallery/src/core/utils/app_images.dart';
import 'package:my_gallery/src/core/utils/app_strings.dart';
import 'package:my_gallery/src/core/utils/app_values.dart';
import 'package:my_gallery/src/core/utils/constants.dart';
import 'package:my_gallery/src/core/widgets/customBottom.dart';
import 'package:my_gallery/src/core/widgets/loader.dart';
import 'package:my_gallery/src/features/home/presentation/cubit/cubit.dart';
import 'package:my_gallery/src/features/home/presentation/cubit/states.dart';
import 'package:my_gallery/src/features/home/presentation/show_gallery_cubit/show_gallery_cubit.dart';

class ImageUploadForm extends StatelessWidget {
  const ImageUploadForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageUploadCubit, ImageUploadState>(
      listener: (context, state) {
        if (state is ImageUploadSuccess) {
          context.successSnackBar('Image uploaded successfully!');
          BlocProvider.of<GalleryCubit>(context).fetchGallery();
        } else if (state is ImageUploadFailure) {
          context.errorSnackBar('Failed to upload image: ${state.error}',
              AppConstant.errorSnackbarDuration);
        }
      },
      builder: (context, state) {
        if (state is ImageUploadInProgress) {
          return LoaderWidget.circularProgressIndicatorCenter();
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Flexible(
                    child: CustomButton(
                        color: AppColors.whiteColor.withOpacity(0.5),
                        text: AppStrings.logOut,
                        textColor: AppColors.textColor,
                        haveIcon: true,
                        borderRadius: AppSize.s20,
                        iconPath: AppImages.logoutIcon,
                        onPressed: () {}),
                  ),
                  (context.width * 0.025).emptyBoxWidth,
                  Flexible(
                    child: CustomButton(
                        color: AppColors.whiteColor.withOpacity(0.5),
                        text: AppStrings.upload,
                        textColor: AppColors.textColor,
                        haveIcon: true,
                        borderRadius: AppSize.s20,
                        iconPath: AppImages.uploadIcon,
                        onPressed: () {
                          showDialog(
                            barrierColor: AppColors.barrierColor,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppSize.s25),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      (context.height * 0.015).emptyBoxHeight,
                                      CustomButton(
                                          color: AppColors.galleryButtonColor,
                                          text: AppStrings.gellary,
                                          textColor: AppColors.textColor,
                                          haveIcon: true,
                                          borderRadius: AppSize.s20,
                                          iconPath: AppImages.galleryIcon,
                                          onPressed: () {
                                            context
                                                .read<ImageUploadCubit>()
                                                .pickImageFromGallery();
                                          }),
                                      (context.height * 0.035).emptyBoxHeight,
                                      CustomButton(
                                          color: AppColors.cameraButtonColor,
                                          text: AppStrings.camera,
                                          textColor: AppColors.textColor,
                                          haveIcon: true,
                                          borderRadius: AppSize.s20,
                                          iconPath: AppImages.cameraIcon,
                                          onPressed: () {
                                            context
                                                .read<ImageUploadCubit>()
                                                .pickImageFromCamera();
                                          }),
                                      (context.height * 0.015).emptyBoxHeight,
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
