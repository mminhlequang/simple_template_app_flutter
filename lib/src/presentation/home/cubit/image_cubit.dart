import 'package:app/src/constants/constants.dart';
import 'package:app/src/network_resources/civitai/model/model.dart';
import 'package:app/src/network_resources/civitai/repo.dart';
import 'package:app/src/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'report_cubit.dart';

ImageCubit get imageCubit => findInstance<ImageCubit>();

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageState());

  updateFilter({String? sort}) {
    emit(state.copyWith(sort: sort));
    if (sort != null) fetchImages(refresh: true);
  }

  int page = 1;
  late int limit = limitItemFetch;

  bool _fetching = false;
  Future fetchImages({int? page, int? limit, bool refresh = false}) async {
    if (_fetching) return;
    _fetching = true;
    this.page = page ?? this.page;
    this.limit = limit ?? this.limit;
    if (refresh) {
      this.page = 1;
      this.limit = limitItemFetch;
      state.images = null;
      emit(state.copyWith());
    }

    CivitaiResponse? civitaiResponse = await compute(fetchImagesApi, [
      AppPrefs.instance.directoryPath,
      this.page,
      this.limit,
      AppPrefs.instance.nsfw,
      AppPrefs.instance.period,
      state.sort,
      null
    ]);

    List<CivitaiImage> images = (state.images ?? []) +
        (civitaiResponse?.items?.map((e) => e as CivitaiImage).toList() ?? []);
    emit(state.copyWith(images: images));
    _fetching = false;
  }
}

class ImageState {
  String sort;
  List<CivitaiImage>? images;

  List<CivitaiImage>? get imagesDisplay =>
      images?.where((e) => !reportCubit.state.isReported(e)).toList();

  ImageState({
    this.sort = "Most Reactions",
    this.images,
  });

  ImageState copyWith({
    String? sort,
    List<CivitaiImage>? images,
  }) {
    return ImageState(
      sort: sort ?? this.sort,
      images: images ?? this.images,
    );
  }
}
