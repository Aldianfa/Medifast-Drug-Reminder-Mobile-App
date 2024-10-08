// import 'dart:ffi';

class TokoObat {
  List<Obat>listObat;

  TokoObat({required this.listObat});

  factory TokoObat.fromJson(Map<String, dynamic> json) {
    var list = json['listObat'] as List;
    List<Obat> obatList = list.map((i) => Obat.fromJson(i)).toList();
    return TokoObat(listObat: obatList);
  }
}


class Obat {
  int id;
  String name;
  String price;
  String description;
  String image;
  int rate;
  String des;

  Obat(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.image,
      required this.rate,
      required this.des});

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
      rate: int.parse(json['rate'].toString()),
      des: json['des']
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'description': description, 'image': image, 'rate': rate, 'des': des};
  }


}
