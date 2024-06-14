import 'model.dart';

class CivitaiModel {
  int? id;
  String? name;
  String? description;
  bool? poi;
  bool? allowNoCredit;
  List<String>? allowCommercialUse;
  bool? allowDerivatives;
  bool? allowDifferentLicense;
  String? type;
  bool? nsfw;
  int? nsfwLevel;
  Stats? stats;
  Creator? creator;
  List<String>? tags;
  List<ModelVersions>? modelVersions;

  CivitaiImage? get sfwImage {
    ModelVersions? m = modelVersions?.firstWhere(
        (e) => e.images?.any((e) => e.nsfwLevel == 1) == true,
        orElse: () => ModelVersions());
    return m?.images
        ?.firstWhere((e) => e.nsfwLevel == 1, orElse: () => CivitaiImage());
  }

  CivitaiModel(
      {this.id,
      this.name,
      this.description,
      this.poi,
      this.allowNoCredit,
      this.allowCommercialUse,
      this.allowDerivatives,
      this.allowDifferentLicense,
      this.type,
      this.nsfw,
      this.nsfwLevel,
      this.stats,
      this.creator,
      this.tags,
      this.modelVersions});

  CivitaiModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["poi"] is bool) {
      poi = json["poi"];
    }
    if (json["allowNoCredit"] is bool) {
      allowNoCredit = json["allowNoCredit"];
    }
    if (json["allowCommercialUse"] is List) {
      allowCommercialUse = json["allowCommercialUse"] == null
          ? null
          : List<String>.from(json["allowCommercialUse"]);
    }
    if (json["allowDerivatives"] is bool) {
      allowDerivatives = json["allowDerivatives"];
    }
    if (json["allowDifferentLicense"] is bool) {
      allowDifferentLicense = json["allowDifferentLicense"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["nsfw"] is bool) {
      nsfw = json["nsfw"];
    }
    if (json["nsfwLevel"] is int) {
      nsfwLevel = json["nsfwLevel"];
    }
    if (json["stats"] is Map) {
      stats = json["stats"] == null ? null : Stats.fromJson(json["stats"]);
    }
    if (json["creator"] is Map) {
      creator =
          json["creator"] == null ? null : Creator.fromJson(json["creator"]);
    }
    if (json["tags"] is List) {
      tags = json["tags"] == null ? null : List<String>.from(json["tags"]);
    }
    if (json["modelVersions"] is List) {
      modelVersions = json["modelVersions"] == null
          ? null
          : (json["modelVersions"] as List)
              .map((e) => ModelVersions.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["poi"] = poi;
    _data["allowNoCredit"] = allowNoCredit;
    if (allowCommercialUse != null) {
      _data["allowCommercialUse"] = allowCommercialUse;
    }
    _data["allowDerivatives"] = allowDerivatives;
    _data["allowDifferentLicense"] = allowDifferentLicense;
    _data["type"] = type;
    _data["nsfw"] = nsfw;
    _data["nsfwLevel"] = nsfwLevel;
    if (stats != null) {
      _data["stats"] = stats?.toJson();
    }
    if (creator != null) {
      _data["creator"] = creator?.toJson();
    }
    if (tags != null) {
      _data["tags"] = tags;
    }
    if (modelVersions != null) {
      _data["modelVersions"] = modelVersions?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ModelVersions {
  int? id;
  String? name;
  int? index;
  int? modelId;
  String? baseModel;
  int? nsfwLevel;
  dynamic description;
  String? publishedAt;
  String? availability;
  List<dynamic>? trainedWords;
  String? baseModelType;
  Stats1? stats;
  List<Files>? files;
  List<CivitaiImage>? images;
  String? downloadUrl;

  ModelVersions(
      {this.id,
      this.name,
      this.index,
      this.modelId,
      this.baseModel,
      this.nsfwLevel,
      this.description,
      this.publishedAt,
      this.availability,
      this.trainedWords,
      this.baseModelType,
      this.stats,
      this.files,
      this.images,
      this.downloadUrl});

  ModelVersions.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["index"] is int) {
      index = json["index"];
    }
    if (json["modelId"] is int) {
      modelId = json["modelId"];
    }
    if (json["baseModel"] is String) {
      baseModel = json["baseModel"];
    }
    if (json["nsfwLevel"] is int) {
      nsfwLevel = json["nsfwLevel"];
    }
    description = json["description"];
    if (json["publishedAt"] is String) {
      publishedAt = json["publishedAt"];
    }
    if (json["availability"] is String) {
      availability = json["availability"];
    }
    if (json["trainedWords"] is List) {
      trainedWords = json["trainedWords"] ?? [];
    }
    if (json["baseModelType"] is String) {
      baseModelType = json["baseModelType"];
    }
    if (json["stats"] is Map) {
      stats = json["stats"] == null ? null : Stats1.fromJson(json["stats"]);
    }
    if (json["files"] is List) {
      files = json["files"] == null
          ? null
          : (json["files"] as List).map((e) => Files.fromJson(e)).toList();
    }
    if (json["images"] is List) {
      images = json["images"] == null
          ? null
          : (json["images"] as List)
              .map((e) => CivitaiImage.fromJson(e))
              .toList();
    }
    if (json["downloadUrl"] is String) {
      downloadUrl = json["downloadUrl"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["index"] = index;
    _data["modelId"] = modelId;
    _data["baseModel"] = baseModel;
    _data["nsfwLevel"] = nsfwLevel;
    _data["description"] = description;
    _data["publishedAt"] = publishedAt;
    _data["availability"] = availability;
    if (trainedWords != null) {
      _data["trainedWords"] = trainedWords;
    }
    _data["baseModelType"] = baseModelType;
    if (stats != null) {
      _data["stats"] = stats?.toJson();
    }
    if (files != null) {
      _data["files"] = files?.map((e) => e.toJson()).toList();
    }
    if (images != null) {
      _data["images"] = images?.map((e) => e.toJson()).toList();
    }
    _data["downloadUrl"] = downloadUrl;
    return _data;
  }
}

class Files {
  int? id;
  double? sizeKb;
  String? name;
  String? type;
  String? pickleScanResult;
  String? pickleScanMessage;
  String? virusScanResult;
  dynamic virusScanMessage;
  String? scannedAt;
  Metadata? metadata;
  Hashes? hashes;
  String? downloadUrl;
  bool? primary;

  Files(
      {this.id,
      this.sizeKb,
      this.name,
      this.type,
      this.pickleScanResult,
      this.pickleScanMessage,
      this.virusScanResult,
      this.virusScanMessage,
      this.scannedAt,
      this.metadata,
      this.hashes,
      this.downloadUrl,
      this.primary});

  Files.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["sizeKB"] is double) {
      sizeKb = json["sizeKB"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["pickleScanResult"] is String) {
      pickleScanResult = json["pickleScanResult"];
    }
    if (json["pickleScanMessage"] is String) {
      pickleScanMessage = json["pickleScanMessage"];
    }
    if (json["virusScanResult"] is String) {
      virusScanResult = json["virusScanResult"];
    }
    virusScanMessage = json["virusScanMessage"];
    if (json["scannedAt"] is String) {
      scannedAt = json["scannedAt"];
    }
    if (json["metadata"] is Map) {
      metadata =
          json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]);
    }
    if (json["hashes"] is Map) {
      hashes = json["hashes"] == null ? null : Hashes.fromJson(json["hashes"]);
    }
    if (json["downloadUrl"] is String) {
      downloadUrl = json["downloadUrl"];
    }
    if (json["primary"] is bool) {
      primary = json["primary"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["sizeKB"] = sizeKb;
    _data["name"] = name;
    _data["type"] = type;
    _data["pickleScanResult"] = pickleScanResult;
    _data["pickleScanMessage"] = pickleScanMessage;
    _data["virusScanResult"] = virusScanResult;
    _data["virusScanMessage"] = virusScanMessage;
    _data["scannedAt"] = scannedAt;
    if (metadata != null) {
      _data["metadata"] = metadata?.toJson();
    }
    if (hashes != null) {
      _data["hashes"] = hashes?.toJson();
    }
    _data["downloadUrl"] = downloadUrl;
    _data["primary"] = primary;
    return _data;
  }
}

class Hashes {
  String? autoV1;
  String? autoV2;
  String? sha256;
  String? crc32;
  String? blake3;

  Hashes({this.autoV1, this.autoV2, this.sha256, this.crc32, this.blake3});

  Hashes.fromJson(Map<String, dynamic> json) {
    if (json["AutoV1"] is String) {
      autoV1 = json["AutoV1"];
    }
    if (json["AutoV2"] is String) {
      autoV2 = json["AutoV2"];
    }
    if (json["SHA256"] is String) {
      sha256 = json["SHA256"];
    }
    if (json["CRC32"] is String) {
      crc32 = json["CRC32"];
    }
    if (json["BLAKE3"] is String) {
      blake3 = json["BLAKE3"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["AutoV1"] = autoV1;
    _data["AutoV2"] = autoV2;
    _data["SHA256"] = sha256;
    _data["CRC32"] = crc32;
    _data["BLAKE3"] = blake3;
    return _data;
  }
}

class Metadata {
  String? format;
  String? size;
  String? fp;

  Metadata({this.format, this.size, this.fp});

  Metadata.fromJson(Map<String, dynamic> json) {
    if (json["format"] is String) {
      format = json["format"];
    }
    if (json["size"] is String) {
      size = json["size"];
    }
    if (json["fp"] is String) {
      fp = json["fp"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["format"] = format;
    _data["size"] = size;
    _data["fp"] = fp;
    return _data;
  }
}

class Stats1 {
  int? downloadCount;
  int? ratingCount;
  double? rating;
  int? thumbsUpCount;
  int? thumbsDownCount;

  Stats1(
      {this.downloadCount,
      this.ratingCount,
      this.rating,
      this.thumbsUpCount,
      this.thumbsDownCount});

  Stats1.fromJson(Map<String, dynamic> json) {
    if (json["downloadCount"] is int) {
      downloadCount = json["downloadCount"];
    }
    if (json["ratingCount"] is int) {
      ratingCount = json["ratingCount"];
    }
    if (json["rating"] is double) {
      rating = json["rating"];
    }
    if (json["thumbsUpCount"] is int) {
      thumbsUpCount = json["thumbsUpCount"];
    }
    if (json["thumbsDownCount"] is int) {
      thumbsDownCount = json["thumbsDownCount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["downloadCount"] = downloadCount;
    _data["ratingCount"] = ratingCount;
    _data["rating"] = rating;
    _data["thumbsUpCount"] = thumbsUpCount;
    _data["thumbsDownCount"] = thumbsDownCount;
    return _data;
  }
}

class Creator {
  String? username;
  String? image;

  Creator({this.username, this.image});

  Creator.fromJson(Map<String, dynamic> json) {
    if (json["username"] is String) {
      username = json["username"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["username"] = username;
    _data["image"] = image;
    return _data;
  }
}

class Stats {
  int? downloadCount;
  int? favoriteCount;
  int? thumbsUpCount;
  int? thumbsDownCount;
  int? commentCount;
  int? ratingCount;
  int? rating;
  int? tippedAmountCount;

  Stats(
      {this.downloadCount,
      this.favoriteCount,
      this.thumbsUpCount,
      this.thumbsDownCount,
      this.commentCount,
      this.ratingCount,
      this.rating,
      this.tippedAmountCount});

  Stats.fromJson(Map<String, dynamic> json) {
    if (json["downloadCount"] is int) {
      downloadCount = json["downloadCount"];
    }
    if (json["favoriteCount"] is int) {
      favoriteCount = json["favoriteCount"];
    }
    if (json["thumbsUpCount"] is int) {
      thumbsUpCount = json["thumbsUpCount"];
    }
    if (json["thumbsDownCount"] is int) {
      thumbsDownCount = json["thumbsDownCount"];
    }
    if (json["commentCount"] is int) {
      commentCount = json["commentCount"];
    }
    if (json["ratingCount"] is int) {
      ratingCount = json["ratingCount"];
    }
    if (json["rating"] is int) {
      rating = json["rating"];
    }
    if (json["tippedAmountCount"] is int) {
      tippedAmountCount = json["tippedAmountCount"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["downloadCount"] = downloadCount;
    _data["favoriteCount"] = favoriteCount;
    _data["thumbsUpCount"] = thumbsUpCount;
    _data["thumbsDownCount"] = thumbsDownCount;
    _data["commentCount"] = commentCount;
    _data["ratingCount"] = ratingCount;
    _data["rating"] = rating;
    _data["tippedAmountCount"] = tippedAmountCount;
    return _data;
  }
}
