import 'package:pari_test/models/gadget_data.dart';

class Gadget {
  final String id;
  final String name;
  GadgetData? data;

  Gadget({
    required this.name,
    required this.id,
    this.data,
  });

  factory Gadget.fromJson(Map<String, dynamic> json) {
    return Gadget(
        name: json['name'],
        id: json['id'],
        data: GadgetData.fromJson(json['data']));
  }

  static List<Gadget> listFromJson(List<dynamic> list) =>
      List<Gadget>.from(list.map((e) => Gadget.fromJson(e)));
}
