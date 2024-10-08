import 'package:flutter/cupertino.dart';
import '../models/apotek_model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

final LatLng uinMalang = LatLng(-7.951346, 112.607515);

final List<ApotekModel> listApotek = [
  ApotekModel(
      "Apotek K-24 Gajayana Malang",
      "Jl. Raya Sumbersari No.Kav. 4, Ketawanggede, Kec. Lowokwaru, Kota Malang, Jawa Timur 65145",
      "apotekk24_source",
      "apotekk24_layer",
      -7.951963621157307,
      112.60901133014197,
      "24 Jam"),
  ApotekModel(
      "Klinik UIN Maulana Malik Ibrahim Malang",
      "Jl. Gajayana No.50, Dinoyo, Kec. Lowokwaru, Kota Malang, Jawa Timur 65144",
      "klinikuin_source",
      "klinikuin_layer",
      -7.951316537357285,
      112.60868495121804,
      "09.00 - 24.00"),
  ApotekModel(
      "Klinik Daqu Sehat New",
      "Jl. Sunan Muria No.2, Dinoyo, Kec. Lowokwaru, Kota Malang, Jawa Timur 65145",
      "daqu_source",
      "daqu_layer",
      -7.9539908606057095,
      112.60653104168553,
      "07.00 - 21.00"),
  ApotekModel(
      "Apotek Telaga Nabi",
      "Jl. Raya Sumbersari No.254C, Sumbersari, Kec. Lowokwaru, Kota Malang, Jawa Timur 65145",
      "telaga_source",
      "telaga_layer",
      -7.9546538925802075,
      112.61117689326606,
      "24 Jam"),
  ApotekModel(
      "Apotek Mertojoyo",
      "Jl. Mertojoyo Kav. 3 No. 83, Merjosari, Lowokwaru, Jl. Mertojoyo Sel. No.7, Merjosari, Kec. Lowokwaru, Kota Malang, Jawa Timur 65144",
      "merto_source",
      "merto_layer",
      -7.944102201853726,
      112.60394105220927,
      "06.30 - 22.00"),
  ApotekModel(
      "Apotek Merjosari",
      "Jl. Joyo Tambaksari No.32 A, Merjosari, Kec. Lowokwaru, Kota Malang, Jawa Timur 65144",
      "merjo_source",
      "merjo_layer",
      -7.944479249046148,
      112.60586179272785,
      "06.30 - 22.00"),
  ApotekModel(
      "Klinik Dr. Emmi",
      "Jl. Simpang Gajayana, Merjosari, Kec. Lowokwaru, Kota Malang, Jawa Timur 65144",
      "ummi_source",
      "ummi_layer",
      -7.944281634346767,
      112.6061867751505,
      "18.00 - 21.00"),
];
