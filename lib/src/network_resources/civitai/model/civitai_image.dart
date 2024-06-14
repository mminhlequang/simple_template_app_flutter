import 'package:equatable/equatable.dart';
import 'package:internal_core/internal_core.dart';

import 'civitai_model.dart';

class CivitaiImage extends Equatable {
  int? id;
  String? url;
  String? hash;
  int? width;
  int? height;
  dynamic nsfwLevel;
  bool? nsfw;
  int? browsingLevel;
  String? createdAt;
  int? postId;
  Stats? stats;
  Meta? meta;
  String? username;

  late double ratio = width != null && height != null
      ? width! / height!
      : doubleInRange(0.6, 1.2);

  CivitaiImage(
      {this.id,
      this.url,
      this.hash,
      this.width,
      this.height,
      this.nsfwLevel,
      this.nsfw,
      this.browsingLevel,
      this.createdAt,
      this.postId,
      this.stats,
      this.meta,
      this.username});

  CivitaiImage.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["url"] is String) {
      url = json["url"];
    }
    if (json["hash"] is String) {
      hash = json["hash"];
    }
    if (json["width"] is int) {
      width = json["width"];
    }
    if (json["height"] is int) {
      height = json["height"];
    }

    nsfwLevel = json["nsfwLevel"];

    if (json["nsfw"] is bool) {
      nsfw = json["nsfw"];
    }
    if (json["browsingLevel"] is int) {
      browsingLevel = json["browsingLevel"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["postId"] is int) {
      postId = json["postId"];
    }
    if (json["stats"] is Map) {
      stats = json["stats"] == null ? null : Stats.fromJson(json["stats"]);
    }
    if (json["meta"] is Map) {
      meta = json["meta"] == null ? null : Meta.fromJson(json["meta"]);
    }
    if (json["username"] is String) {
      username = json["username"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["url"] = url;
    _data["hash"] = hash;
    _data["width"] = width;
    _data["height"] = height;
    _data["nsfwLevel"] = nsfwLevel;
    _data["nsfw"] = nsfw;
    _data["browsingLevel"] = browsingLevel;
    _data["createdAt"] = createdAt;
    _data["postId"] = postId;
    if (stats != null) {
      _data["stats"] = stats?.toJson();
    }
    if (meta != null) {
      _data["meta"] = meta?.toJson();
    }
    _data["username"] = username;
    return _data;
  }

  @override
  List<Object?> get props => [id];
}

class Meta {
  String? ensd;
  String? size;
  int? seed;
  String? model;
  int? steps;
  String? prompt;
  String? sampler;
  int? cfgScale;
  String? clipSkip;
  List<Resources>? resources;
  String? modelHash;
  String? hiresUpscale;
  String? hiresUpscaler;
  String? negativePrompt;
  String? controlNetModel;
  String? controlNetModule;
  String? controlNetWeight;
  String? controlNetEnabled;
  String? denoisingStrength;
  String? controlNetGuidanceStrength;

  Meta(
      {this.ensd,
      this.size,
      this.seed,
      this.model,
      this.steps,
      this.prompt,
      this.sampler,
      this.cfgScale,
      this.clipSkip,
      this.resources,
      this.modelHash,
      this.hiresUpscale,
      this.hiresUpscaler,
      this.negativePrompt,
      this.controlNetModel,
      this.controlNetModule,
      this.controlNetWeight,
      this.controlNetEnabled,
      this.denoisingStrength,
      this.controlNetGuidanceStrength});

  Meta.fromJson(Map<String, dynamic> json) {
    if (json["ENSD"] is String) {
      ensd = json["ENSD"];
    }
    if (json["Size"] is String) {
      size = json["Size"];
    }
    if (json["seed"] is int) {
      seed = json["seed"];
    }
    if (json["Model"] is String) {
      model = json["Model"];
    }
    if (json["steps"] is int) {
      steps = json["steps"];
    }
    if (json["prompt"] is String) {
      prompt = json["prompt"];
    }
    if (json["sampler"] is String) {
      sampler = json["sampler"];
    }
    if (json["cfgScale"] is int) {
      cfgScale = json["cfgScale"];
    }
    if (json["Clip skip"] is String) {
      clipSkip = json["Clip skip"];
    }
    if (json["resources"] is List) {
      resources = json["resources"] == null
          ? null
          : (json["resources"] as List)
              .map((e) => Resources.fromJson(e))
              .toList();
    }
    if (json["Model hash"] is String) {
      modelHash = json["Model hash"];
    }
    if (json["Hires upscale"] is String) {
      hiresUpscale = json["Hires upscale"];
    }
    if (json["Hires upscaler"] is String) {
      hiresUpscaler = json["Hires upscaler"];
    }
    if (json["negativePrompt"] is String) {
      negativePrompt = json["negativePrompt"];
    }
    if (json["ControlNet Model"] is String) {
      controlNetModel = json["ControlNet Model"];
    }
    if (json["ControlNet Module"] is String) {
      controlNetModule = json["ControlNet Module"];
    }
    if (json["ControlNet Weight"] is String) {
      controlNetWeight = json["ControlNet Weight"];
    }
    if (json["ControlNet Enabled"] is String) {
      controlNetEnabled = json["ControlNet Enabled"];
    }
    if (json["Denoising strength"] is String) {
      denoisingStrength = json["Denoising strength"];
    }
    if (json["ControlNet Guidance Strength"] is String) {
      controlNetGuidanceStrength = json["ControlNet Guidance Strength"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ENSD"] = ensd;
    _data["Size"] = size;
    _data["seed"] = seed;
    _data["Model"] = model;
    _data["steps"] = steps;
    _data["prompt"] = prompt;
    _data["sampler"] = sampler;
    _data["cfgScale"] = cfgScale;
    _data["Clip skip"] = clipSkip;
    if (resources != null) {
      _data["resources"] = resources?.map((e) => e.toJson()).toList();
    }
    _data["Model hash"] = modelHash;
    _data["Hires upscale"] = hiresUpscale;
    _data["Hires upscaler"] = hiresUpscaler;
    _data["negativePrompt"] = negativePrompt;
    _data["ControlNet Model"] = controlNetModel;
    _data["ControlNet Module"] = controlNetModule;
    _data["ControlNet Weight"] = controlNetWeight;
    _data["ControlNet Enabled"] = controlNetEnabled;
    _data["Denoising strength"] = denoisingStrength;
    _data["ControlNet Guidance Strength"] = controlNetGuidanceStrength;
    return _data;
  }
}

class Resources {
  String? hash;
  String? name;
  String? type;

  Resources({this.hash, this.name, this.type});

  Resources.fromJson(Map<String, dynamic> json) {
    if (json["hash"] is String) {
      hash = json["hash"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["hash"] = hash;
    _data["name"] = name;
    _data["type"] = type;
    return _data;
  }
}
