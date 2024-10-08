
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import '../models/obat.dart';

class service{
  static Future<List<Obat>> fetchObat() async{
    // Response response = await Dio().get('https://www.jsonkeeper.com/b/7UEH');
    Response response = await Dio().get('https://www.jsonkeeper.com/b/K7DU'); 
    List<Obat> obate = (response.data as List).map((v) => Obat.fromJson(v)).toList();
    return obate; 
  }
}

// class service{
//   static Future<List<Obat>> fetchObat() async{
//     var response = await http
//         .get(Uri.parse("https://www.jsonkeeper.com/b/K7DU"));
//     List<dynamic> jsonData =
//         jsonDecode(utf8.decode(response.bodyBytes))['hasil'];

//     List<Obat> obate = [];

//     // for (var i = 0; i < jsonData.length; i++) {
//     //   obate.add(Obat.fromJson(jsonData[i]));
//     // }
//     for (var i = 0; i < jsonData.length; i++) {
//   obate.add(Obat.fromJson({
//     'id': int.parse(jsonData[i]['id'].toString()),
//     'name': jsonData[i]['name'],
//     'price': jsonData[i]['price'],
//     'description': jsonData[i]['description'],
//     'image': jsonData[i]['image'],
//     'rate': int.parse(jsonData[i]['rate'].toString()),
//     'des': jsonData[i]['des']
//   }));
// }

// return obate;
//   }
// }