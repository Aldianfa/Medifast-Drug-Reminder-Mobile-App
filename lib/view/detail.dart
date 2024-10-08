import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uasmobile/view/chart.dart';

import '../models/obat.dart';
import '../viewmodels/sqlitehelper.dart';
import 'splashscreen.dart';

class Detail_obat extends StatelessWidget {
  int id;
  String? name;
  String? price;
  String? description;
  String? image;
  int? rate;
  String? des;

  // final Kopi kopi;
  Detail_obat(
    {Key? key,
    required this.id,
    // required this.kopi,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.rate,
    required this.des,}) 
    : super(key: key);

  SQLiteHelper? helper;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 119, 247),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Qohwatun',
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
        child: Container(
          width: width,
          child: Stack(
            children: [
              Container(
                height: height * 0.55,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image!),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Container(
                width: width,
                margin: EdgeInsets.only(top: height * 0.5),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      des!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 2,),

                    Text(
                      name!,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10,),
                    

                    Text(description!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      
                    ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      width: width,
                      child: ListView.builder(
                        itemCount: rate!,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int key) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber.shade300,
                            size: 28,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Harga',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            ),
                            Text(
                              price!, 
                              style: TextStyle(
                                color: Color.fromARGB(255, 55, 140, 252),
                                fontSize: 28,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Add to Chart"),
                                          content: Text("Ingin menyimpan Obat ini di keranjang?"),
                                          elevation: 24.0,
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () async {
                                                var input = Obat(
                                                    id: id,
                                                    name: name!,
                                                    price: price!,
                                                    description: description!,
                                                    image: image!,
                                                    rate: rate!,
                                                    des: des!);
                                                // insert data to bookmark
                                                helper = SQLiteHelper();
                                                helper!.inisiasiDB().whenComplete(() async {
                                                  await helper!.insertObat(input);
                                                });
                                                Navigator.pushReplacement(context,MaterialPageRoute(
                                                        builder: (context) => chart()));
                                              },
                                              color: Colors.white,
                                              elevation: 0,
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              color: Colors.white,
                                              elevation: 0,
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(35,10,35,10), backgroundColor: Color.fromARGB(255, 23, 119, 247),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            )
                          ),
                          child: Text(
                            'Chart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                            ),
                          ),
                           
                        )
                        
                      ],
                    )


                  ],
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}