class CivitaiResponse {
  List? items;
  Metadata2? metadata;

  CivitaiResponse({this.items, this.metadata});

  CivitaiResponse.fromJson(Map<String, dynamic> json, fromJson) {
    if (json["items"] is List) {
      items = json["items"] == null
          ? null
          : (json["items"] as List).map((e) => fromJson(e)).toList();
    }
    if (json["metadata"] is Map) {
      metadata = json["metadata"] == null
          ? null
          : Metadata2.fromJson(json["metadata"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (items != null) {
      _data["items"] = items?.map((e) => e.toJson()).toList();
    }
    if (metadata != null) {
      _data["metadata"] = metadata?.toJson();
    }
    return _data;
  }
}

class Metadata2 {
  int? totalItems;
  int? currentPage;
  int? pageSize;
  int? totalPages;
  String? nextPage;

  Metadata2(
      {this.totalItems,
      this.currentPage,
      this.pageSize,
      this.totalPages,
      this.nextPage});

  Metadata2.fromJson(Map<String, dynamic> json) {
    if (json["totalItems"] is int) {
      totalItems = json["totalItems"];
    }
    if (json["currentPage"] is int) {
      currentPage = json["currentPage"];
    }
    if (json["pageSize"] is int) {
      pageSize = json["pageSize"];
    }
    if (json["totalPages"] is int) {
      totalPages = json["totalPages"];
    }
    if (json["nextPage"] is String) {
      nextPage = json["nextPage"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["totalItems"] = totalItems;
    _data["currentPage"] = currentPage;
    _data["pageSize"] = pageSize;
    _data["totalPages"] = totalPages;
    _data["nextPage"] = nextPage;
    return _data;
  }
}
