import 'package:app/src/presentation/home/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../presentation/home/cubit/favorite_model_cubit.dart';
import '../presentation/home/cubit/image_cubit.dart';
import '../presentation/home/cubit/model_cubit.dart';
import '../presentation/home/cubit/report_cubit.dart';

final getIt = GetIt.instance;

void getItSetup() {
  getIt.registerSingleton<GlobalKey<NavigatorState>>(
      GlobalKey<NavigatorState>());
  getIt.registerSingleton<ImageCubit>(ImageCubit());
  getIt.registerSingleton<ModelCubit>(ModelCubit());
  getIt.registerSingleton<ReportCubit>(ReportCubit());
  getIt.registerSingleton<FavoriteCubit>(FavoriteCubit());
  getIt.registerSingleton<FavoriteModelCubit>(FavoriteModelCubit());
}
