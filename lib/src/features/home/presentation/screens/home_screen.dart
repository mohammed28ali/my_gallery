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
import 'package:my_gallery/src/features/home/data/datasource/gallery_datasource.dart';
import 'package:my_gallery/src/features/home/presentation/cubit/cubit.dart';
import 'package:my_gallery/src/features/home/presentation/cubit/states.dart';

import 'package:my_gallery/src/features/home/presentation/show_gallery_cubit/show_gallery_cubit.dart';
import 'package:my_gallery/src/features/home/presentation/widgets/image_upload_form_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GalleryCubit(repository: GalleryRepositoryImpl())..fetchGallery(),
        ),
      ],
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.homeBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocBuilder<GalleryCubit, List<String>>(
            builder: (context, state) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
                children: [
                  (context.height * 0.05).emptyBoxHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            AppStrings.welcome,
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: AppSize.s25),
                          ),
                          const Text(
                            'Brooklyn Champlin',
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: AppSize.s25),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset(AppImages.profile)),
                    ],
                  ),
                  (context.height * 0.08).emptyBoxHeight,
                  const ImageUploadForm(),
                  (context.height * 0.055).emptyBoxHeight,
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 25.0,
                    ),
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      final imageUrl = state[index];
                      return SizedBox(
                          height: 25,
                          width: 25,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s20),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              )));
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
