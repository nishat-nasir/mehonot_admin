import 'dart:collection';

class Code {
  String? code;
  String? name;

  Code({this.code, this.name});

  Code.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        name = json['name'];

  @override
  String toString() {
    return '$code: $name';
  }
}

class Codes extends ListBase<Code> {
  List<Code> _codes = [];

  @override
  int get length => _codes.length;

  @override
  Code operator [](int index) => _codes[index];

  @override
  void operator []=(int index, Code value) {
    _codes[index] = value;
  }

  @override
  set length(int newLength) {
    _codes.length = length;
  }

  @override
  void add(Code element) {
    _codes.add(element);
  }

  Codes();

  Codes.from(Map<String?, String?> list) {
    _codes = list.keys.map((e) => Code(code: e, name: list[e])).toList();
  }

  Codes.fromJson(List<dynamic> list) {
    _codes = list.map((e) => Code.fromJson(e)).toList();
  }

  List<String> names() => _codes.map((i) => i.name!).toList();

  String? get firstName => _codes.isNotEmpty ? _codes.first.name : null;

  String? name(String? code) =>
      _codes.firstWhere((i) => i.code == code, orElse: () => Code()).name;

  String? code(String? name) =>
      _codes.firstWhere((i) => i.name == name, orElse: () => Code()).code;
}
