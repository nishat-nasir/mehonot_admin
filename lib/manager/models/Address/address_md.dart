import 'package:json_annotation/json_annotation.dart';

part 'address_md.g.dart';

@JsonSerializable(anyMap: true)
class AddressModel {
  String division;
  String? district;
  String? city;
  String? area;

  @override
  AddressModel({
    required this.division,
    this.district,
    this.city,
    this.area,
  });

  factory AddressModel.fromJson(Map json) => _$AddressModelFromJson(json);

  Map toJson() => _$AddressModelToJson(this);
}
