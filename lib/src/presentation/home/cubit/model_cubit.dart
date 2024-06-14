// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:app/src/constants/constants.dart';
import 'package:app/src/network_resources/civitai/model/model.dart';
import 'package:app/src/network_resources/civitai/repo.dart';
import 'package:app/src/utils/utils.dart';

import 'report_cubit.dart';

ModelCubit get modelCubit => findInstance<ModelCubit>();

class ModelCubit extends Cubit<ModelState> {
  ModelCubit() : super(ModelState());

  fetchTags() async {
    final String response =
        await rootBundle.loadString('assets/jsons/tags.json');
    final data = await json.decode(response);
    state.tags = (data as List).map((e) => CivitaiTag.fromJson(e)).toList();
    emit(state.copyWith());
  }

  bool _fetching = false;
  Future fetchModels({bool refresh = false}) async {
    if (_fetching) return;
    _fetching = true;
    if (refresh) {
      state.models = null;
      emit(state.copyWith());
    }

    bool nsfw = AppPrefs.instance.nsfw != "None";
    CivitaiResponse? civitaiResponse = await compute(fetchModelsApi, [
      AppPrefs.instance.directoryPath,
      AppPrefs.instance.tag,
      nsfw,
    ]);
    if (!nsfw) {
      civitaiResponse?.items
          ?.removeWhere((e) => e.nsfwLevel > (Platform.isAndroid ? 5 : 25));
      civitaiResponse?.items?.removeWhere((e) => e.sfwImage?.url == null);
      civitaiResponse?.items?.removeWhere((e) => e.nsfw == true);
    }
    emit(state.copyWith(
        models:
            civitaiResponse?.items?.map((e) => e as CivitaiModel).toList()));
    _fetching = false;
  }

  selectModel(CivitaiModel? m) {
    state.model = m;
    fetchImages(refresh: true);
  }

  int page = 1;
  late int limit = limitItemFetch;

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
      null,
      null,
      state.model?.id,
    ]);

    List<CivitaiImage> images = (state.images ?? []) +
        (civitaiResponse?.items?.map((e) => e as CivitaiImage).toList() ?? []);
    if (AppPrefs.instance.nsfw == "None") {
      images.removeWhere((e) => e.nsfwLevel != "None");
    }
    emit(state.copyWith(images: images));
    _fetching = false;
  }
}

class ModelState {
  List<CivitaiTag>? tags;
  List<CivitaiModel>? models;

  CivitaiModel? model;
  List<CivitaiImage>? images;

  List<CivitaiImage>? get imagesDisplay =>
      images?.where((e) => !reportCubit.state.isReported(e)).toList();

  ModelState({
    this.tags,
    this.models,
    this.model,
    this.images,
  });

  ModelState copyWith({
    List<CivitaiTag>? tags,
    List<CivitaiModel>? models,
    CivitaiModel? model,
    List<CivitaiImage>? images,
  }) {
    return ModelState(
      models: models ?? this.models,
      tags: tags ?? this.tags,
      model: model ?? this.model,
      images: images ?? this.images,
    );
  }
}
