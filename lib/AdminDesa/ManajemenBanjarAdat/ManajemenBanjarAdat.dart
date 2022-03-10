import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class manajemenBanjarAdatAdmin extends StatefulWidget {
  const manajemenBanjarAdatAdmin({Key key}) : super(key: key);

  @override
  _manajemenBanjarAdatAdminState createState() => _manajemenBanjarAdatAdminState();
}

class _manajemenBanjarAdatAdminState extends State<manajemenBanjarAdatAdmin> {
  var listBanjar = ['Banjar A', 'Banjar B', 'Banjar C', 'Banjar D', 'Banjar E'];
  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Manajemen Banjar Adat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop();},
          )
        ),
        body: ListView.builder(
          itemCount: listBanjar.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                final url = "https://www.kindacode.com/wp-content/uploads/2021/07/test.pdf";
                if(await canLaunch(url)) {
                  await launch(url);
                }else{
                  print("tidak bisa membuka pdf");
                }
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'images/location.png',
                        height: 40,
                        width: 40,
                      )
                    ),
                    Container(
                        child: Text("${listBanjar[index]}", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: HexColor("#025393")
                        ))
                    ),
                  ]
                ),
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0,3)
                    )
                  ]
                )
              )
            );
          }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))
                  ),
                  content: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            'images/location.png',
                            height: 50,
                            width: 50,
                          )
                        ),
                        Container(
                          child: Text("Tambah Banjar Adat", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: HexColor("#025393")
                          ), textAlign: TextAlign.center),
                          margin: EdgeInsets.only(top: 10),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide(color: HexColor("#025393"))
                                  ),
                                  hintText: "Nama Banjar Adat"
                              ),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                          ),
                          margin: EdgeInsets.only(top: 15)
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Simpan", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393")
                      )),
                      onPressed: (){}
                    ),
                    TextButton(
                        child: Text("Batal", style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: HexColor("#025393")
                        )),
                        onPressed: (){Navigator.of(context).pop();}
                    )
                  ],
                );
              }
            );
          },
          child: Icon(Icons.add),
          backgroundColor: HexColor("#025393"),
        )
      ),
    );
  }
}