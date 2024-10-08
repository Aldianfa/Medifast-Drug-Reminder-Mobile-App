import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:location/location.dart';
import 'package:uasmobile/map/view/place_source.dart';
import 'package:uasmobile/models/obat.dart';
import 'package:uasmobile/view/detail.dart';
import 'package:uasmobile/view/reminder.dart';
import 'package:uasmobile/view/splashscreen.dart';
import 'package:uasmobile/viewmodels/kopi_controller.dart';
import 'package:uasmobile/viewmodels/location_service.dart';

import 'chart.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // Menampilkan alamat terkini
  // Future<String> _getAddress() async {
  //   final locationData = await Location().getLocation();
  //   final coordinates =
  //       Coordinates(locationData.latitude!, locationData.longitude!);
  //   final address =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   return address.first.addressLine;
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 119, 247),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Medifast',
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
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Color.fromARGB(255, 23, 119, 247),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Malang, Indonesia',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: TextField(
                  style:
                      TextStyle(fontSize: 20), // Ubah ukuran font untuk input teks
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Cari obat',
                    hintStyle:
                        TextStyle(fontSize: 16), // Ubah ukuran font untuk hint teks
                    contentPadding: EdgeInsets.symmetric(
                        vertical:
                            10), // Ubah jarak padding atas dan bawah dari input teks
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),

              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  'assets/img/layer2.png',
                  width: 380,
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                elevation: 2,
                margin: EdgeInsets.all(5),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "Features",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 16, 4, 5),
                        padding: EdgeInsets.all(5),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.blue.shade200, width: 2),
                          borderRadius: BorderRadius.circular(14),
                          color: Color.fromARGB(255, 230, 241, 255)
                              
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.local_hospital_outlined,
                              color: Color.fromARGB(255, 36, 84, 148),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Obat",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 36, 84, 148)),
                            )
                          ],
                        )),
                        Container(
                        margin: EdgeInsets.fromLTRB(15, 10, 4, 5),
                        padding: EdgeInsets.all(5),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.blue.shade200, width: 2),
                          borderRadius: BorderRadius.circular(14),
                          color: Color.fromARGB(255, 254, 242, 225)
                              
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.map_sharp,
                              color: Color.fromARGB(255, 224, 159, 67),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Maps",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 224, 159, 67),
                            ))
                          ],
                        )),
                        Container(
                        margin: EdgeInsets.fromLTRB(13, 10, 2, 5),
                        padding: EdgeInsets.all(5),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.blue.shade200, width: 2),
                          borderRadius: BorderRadius.circular(14),
                          color: Color.fromARGB(255, 225, 220, 247)
                              
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.alarm_add_rounded,
                              color: Color.fromARGB(255, 88, 68, 181),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Alarm",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 88, 68, 181)),
                            )
                          ],
                        )),
                        Container(
                        margin: EdgeInsets.fromLTRB(15, 10, 4, 5),
                        padding: EdgeInsets.all(5),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.blue.shade200, width: 2),
                          borderRadius: BorderRadius.circular(14),
                          color: Color.fromARGB(255, 253, 226, 233)
                              
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.newspaper_rounded,
                              color: Color.fromARGB(255, 191, 54, 90),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Article",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 191, 54, 90)),
                            )
                          ],
                        )),
                        Container(
                        margin: EdgeInsets.fromLTRB(15, 10, 4, 5),
                        padding: EdgeInsets.all(5),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.blue.shade200, width: 2),
                          borderRadius: BorderRadius.circular(14),
                          color: Color.fromARGB(255, 224, 247, 220)
                              
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: Color.fromARGB(255, 63, 160, 46),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Chart",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 63, 160, 46)),
                            )
                          ],
                        )),
                    
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "List Product",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ),
              FutureBuilder<List<Obat>>(
                  future: service.fetchObat(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text('Please wait its loading...'));
                    } else {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Detail_obat(
                                            id: snapshot.data![i].id,
                                            name: snapshot.data![i].name,
                                            price: snapshot.data![i].price,
                                            description:
                                                snapshot.data![i].description,
                                            image: snapshot.data![i].image,
                                            rate: snapshot.data![i].rate,
                                            des: snapshot.data![i].des,
                                          ),
                                        ));
                                  },
                                  child: Card(
                                    color: Color.fromARGB(255, 235, 243, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(),
                                            child: Container(
                                              height: 125,
                                              width: 170,
                                              // child: Image.asset(dataKopi[index].image,fit: BoxFit.contain,),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20)),
                                                  // borderRadius: BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data![i].image),
                                                    fit: BoxFit.cover,
                                                    // image: AssetImage('assets/img/stimuno.jpg')
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(snapshot.data![i].name,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(snapshot.data![i].des,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey)),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    }
                  })
            ]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 23, 119, 247),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Medifast,",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "Solusi Kesehatanmu!",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
                leading:
                    Icon(Icons.home, color: Color.fromARGB(255, 60, 141, 247)),
                title: const Text(
                  'Home',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (Menu()),
                      ));
                }),
            ListTile(
              leading: Icon(Icons.local_hospital_rounded,
                  color: Color.fromARGB(255, 60, 141, 247)),
              title: const Text(
                'Maps',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (PlaceSourcePage()),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.add_alarm,
                  color: Color.fromARGB(255, 60, 141, 247)),
              title: const Text(
                'Reminder',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (reminderPage()),
                    ));
              },
            ),
            new Divider(),
            SizedBox(
              height: 250,
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded,
                  color: Color.fromARGB(255, 60, 141, 247)),
              title: const Text(
                'Logout',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (Splashscreen()),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
