class CivitaiTag {
  String? name;
  int? modelCount;
  String? link;

  CivitaiTag({this.name, this.modelCount, this.link});

  CivitaiTag.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["modelCount"] is int) {
      modelCount = json["modelCount"];
    }
    if (json["link"] is String) {
      link = json["link"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["modelCount"] = modelCount;
    _data["link"] = link;
    return _data;
  }
}
