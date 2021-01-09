class Apps {
  String _name;
  String _description;
  String _linkdown;
  String _logolink;
  String _linkdownios;

  String get name => _name;

  String get description => _description;

  String get linkdown => _linkdown;

  String get logolink => _logolink;

  String get linkdownios => _linkdownios;

  Apps({String name, String description, String linkdown, String logolink, String linkdownios}) {
    _name = name;
    _description = description;
    _linkdown = linkdown;
    _logolink = logolink;
    _linkdownios = linkdownios;
  }

  Apps.fromJson(dynamic json) {
    _name = json["name"];
    _description = json["description"];
    _linkdown = json["linkdown"];
    _logolink = json["logolink"];
    _linkdownios = json["linkdownios"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["description"] = _description;
    map["linkdown"] = _linkdown;
    map["logolink"] = _logolink;
    map["linkdownios"] = _linkdownios;
    return map;
  }
}
