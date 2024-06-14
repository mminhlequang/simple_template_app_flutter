import 'package:dio/dio.dart';

import 'model/model.dart';

/// [params] must list 3 items
/// [cache dir path, tag, nsfw]
Future<CivitaiResponse?> fetchModelsApi(List params) async {
  try {
    var queryParameters = {
      "sort": "Highest Rated",
      // "page": params[0],
      // "limit": params[1],
      "tag": params[1],
      "nsfw": params[2],
      // "period": data.period,
    }..removeWhere((key, value) => value == null);
    Response response = await Dio().get("https://civitai.com/api/v1/models",
        queryParameters: queryParameters);
    return CivitaiResponse.fromJson(response.data, CivitaiModel.fromJson);
  } catch (e) {
    return null;
  }
}

/// [params] must list 7 items
/// [cache dir path, page, limit, nsfw, period, sort, modelId]
Future<CivitaiResponse?> fetchImagesApi(List params) async {
  try {
    var queryParameters = {
      "page": params[1],
      "limit": params[2],
      //boolean | enum (None, Soft, Mature, X)
      "nsfw": params[3],
      "period": params[4],
      "sort": params[5],
      "modelId": params[6],
    }..removeWhere((key, value) => value == null);
    print('fetchImagesApi $queryParameters');
    Response response = await Dio().get("https://civitai.com/api/v1/images",
        queryParameters: queryParameters);
    return CivitaiResponse.fromJson(response.data, CivitaiImage.fromJson);
  } catch (e) {
    return null;
  }
}
