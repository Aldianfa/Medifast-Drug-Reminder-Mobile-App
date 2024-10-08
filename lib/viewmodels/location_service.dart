// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';

// class LocationService {
//   Future<String> getCoordinate() async {
//     // Memilih GPS yang Akurat
//     Position position = await Geolocator
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

//     final coordinate = new Coordinates(position.latitude, position.longitude);

//     var addresses =
//         await Geocoder.local.findAddressesFromCoordinates(coordinate);

//     var alamat = addresses.first;

//     return alamat.addressLine;
//   }
// }

