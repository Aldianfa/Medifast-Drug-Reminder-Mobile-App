// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:uasmobile/models/apotek_model.dart';
import 'package:uasmobile/viewmodels/apotek_data.dart';

import '../../view/chart.dart';
import 'demo.dart';
import 'page.dart';

class PlaceSourcePage extends ExamplePage {
  PlaceSourcePage() : super(const Icon(Icons.place), 'Place source');

  @override
  Widget build(BuildContext context) {
    return const PlaceSymbolBody();
  }
}

class PlaceSymbolBody extends StatefulWidget {
  const PlaceSymbolBody();

  @override
  State<StatefulWidget> createState() => PlaceSymbolBodyState();
}

class PlaceSymbolBodyState extends State<PlaceSymbolBody> {
  PlaceSymbolBodyState();

  static const SOURCE_ID = 'apotek1_source';
  static const LAYER_ID = 'apotek1_layer';

  static const SOURCE_ID2 = 'apotek2_source';
  static const LAYER_ID2 = 'apotek2_layer';

  static const SOURCE_ID3 = 'apotek3_source';
  static const LAYER_ID3 = 'apotek3_layer';

  bool sourceAdded = false;
  bool layerAdded = false;
  late MapboxMapController controller;

  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;

    addImageSourceFromAsset(SOURCE_ID, 'assets/img/caps.png', listApotek[0])
        .then((value) {
      setState(() => sourceAdded = true);
    });
    addLayer(LAYER_ID, SOURCE_ID);

    addImageSourceFromAsset(SOURCE_ID2, 'assets/img/caps.png', listApotek[1])
        .then((value) {
      setState(() => sourceAdded = true);
    });
    addLayer(LAYER_ID2, SOURCE_ID2);

    addImageSourceFromAsset(SOURCE_ID3, 'assets/img/caps.png', listApotek[2])
        .then((value) {
      setState(() => sourceAdded = true);
    });
    addLayer(LAYER_ID3, SOURCE_ID3);
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  LatLngQuad convertToKotak(double latitude, double longitude) {
    final LatLngQuad kotak = LatLngQuad(
        topLeft: LatLng(latitude + 0.0003, longitude - 0.0003),
        topRight: LatLng(latitude + 0.0003, longitude + 0.0003),
        bottomRight: LatLng(latitude - 0.0003, longitude + 0.0003),
        bottomLeft: LatLng(latitude - 0.0003, longitude - 0.0003));
    print("INI NILAI NYA : " + kotak.toString());
    return kotak;
  }

  /// Adds an asset image as a source to the currently displayed style
  Future<void> addImageSourceFromAsset(
      String imageSourceId, String assetName, ApotekModel data) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller.addImageSource(
        imageSourceId, list, convertToKotak(data.latitude!, data.longitude!));
  }

  /// Update an asset image as a source to the currently displayed style

  Future<void> removeImageSource(String imageSourceId) {
    return controller.removeSource(imageSourceId);
  }

  Future<void> addLayer(String imageLayerId, String imageSourceId) {
    if (layerAdded) {
      removeLayer(imageLayerId);
    }
    setState(() => layerAdded = true);
    return controller.addImageLayer(imageLayerId, imageSourceId);
  }

  Future<void> addLayerBelow(
      String imageLayerId, String imageSourceId, String belowLayerId) {
    if (layerAdded) {
      removeLayer(imageLayerId);
    }
    setState(() => layerAdded = true);
    return controller.addImageLayerBelow(
        imageLayerId, imageSourceId, belowLayerId);
  }

  Future<void> removeLayer(String imageLayerId) {
    setState(() => layerAdded = false);
    return controller.removeLayer(imageLayerId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 23, 119, 247),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_ios_new_rounded),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Apotek',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins'),
          ),
          actions: [
            IconButton(
              icon: new Icon(Icons.shopping_bag_rounded),
              color: Colors.white,
              onPressed: () {
                print('Keranjang');
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => chart()));
              },
            )
          ],
        ),
        body: Stack(children:[
          SizedBox(
            height: 300.0,
            child: MapboxMap(
              // dragEnabled: true,
              // zoomGesturesEnabled: true,
              myLocationEnabled: true,
              accessToken: MapsDemo.ACCESS_TOKEN,
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(-7.951346, 112.607515),
                zoom: 15.5,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Apotek Terdekat",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ListTile(
                          leading: Image.asset(
                            "assets/img/caps.png",
                            width: 40,
                            height: 40,
                          ),
                          title: Text(
                            listApotek[index].nama!,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(listApotek[index].alamat!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),),

                              Text(listApotek[index].jambuka!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.blue),),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.directions),
                            onPressed: () {},
                          )),
                      itemCount: 3)
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
