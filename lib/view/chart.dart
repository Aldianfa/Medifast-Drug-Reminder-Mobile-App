import 'package:flutter/material.dart';
import 'package:uasmobile/models/obat.dart';
import 'package:uasmobile/view/detail.dart';

import '../viewmodels/sqlitehelper.dart';

class chart extends StatefulWidget {
  const chart({super.key});

  @override
  State<chart> createState() => _chartState();
}

class _chartState extends State<chart> {
  SQLiteHelper? helper;

  void initState() {
    // TODO: implement initState
    super.initState();
    helper = SQLiteHelper();
    helper!.inisiasiDB().whenComplete(() async {
      // await helper.tambahKucing();
      setState(() {});
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
          'Keranjang',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins'),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: FutureBuilder(
          future: helper!.ambilDataObat(),
          builder: (BuildContext context, AsyncSnapshot<List<Obat>> snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail_obat(
                              id: snapshot.data![index].id,
                              name: snapshot.data![index].name,
                              price: snapshot.data![index].price,
                              description: snapshot.data![index].description,
                              image: snapshot.data![index].image,
                              rate: snapshot.data![index].rate,
                              des: snapshot.data![index].des,
                            ),
                          ));
                    },
                    child: Dismissible(
                      key: ValueKey<int?>(snapshot.data![index].id),
                      onDismissed: (DismissDirection direction) async {
                        await helper!.deleteDataObat(snapshot.data![index].id);
                      },
                      child: Card(
                        margin: EdgeInsets.fromLTRB(10, 12, 10, 4),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          
                        ),
                        elevation: 2.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 233, 233, 233).withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                snapshot.data![index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data![index].price,
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              leading: Image.network(snapshot.data![index].image),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
