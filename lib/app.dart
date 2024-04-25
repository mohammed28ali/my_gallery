import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/src/config/routes/app_route.dart';
import 'package:my_gallery/src/config/theme/app_theme.dart';
import 'package:my_gallery/src/core/utils/app_strings.dart';
import 'package:my_gallery/src/features/home/presentation/cubit/cubit.dart';

class MyGalleryApp extends StatelessWidget {
  const MyGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageUploadCubit(),
      child: MaterialApp(
        title: AppStrings.appName,
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGeneratRoute,
      ),
    );
  }
}
