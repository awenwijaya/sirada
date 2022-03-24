import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class suratKeluarParumanDesaAdat extends StatefulWidget {
  const suratKeluarParumanDesaAdat({Key key}) : super(key: key);

  @override
  State<suratKeluarParumanDesaAdat> createState() => _suratKeluarParumanDesaAdatState();
}

class _suratKeluarParumanDesaAdatState extends State<suratKeluarParumanDesaAdat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Surat Paruman Desa Adat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/handshake.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                child: FlatButton(
                  onPressed: (){},
                  child: Text("Tambah Data Surat", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50)
                ),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Status Pengajuan Surat", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 20, left: 15, bottom: 20)
              ),
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        DefaultTabController(
                            length: 4,
                            initialIndex: 0,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                      child: TabBar(
                                          labelColor: HexColor("#025393"),
                                          unselectedLabelColor: Colors.black,
                                          tabs: [
                                            Tab(child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.55,
                                                child: Text("Menunggu", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w700,
                                                ), maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                  textAlign: TextAlign.center,
                                                )
                                            )),
                                            Tab(child: Text("Sedang Diproses", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700
                                            ), textAlign: TextAlign.center)),
                                            Tab(child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.55,
                                                child: Text("Dikonfirmasi", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w700,
                                                ), maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                  textAlign: TextAlign.center,
                                                )
                                            )),
                                            Tab(child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.55,
                                                child: Text("Dibatalkan", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w700,
                                                ), maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                  textAlign: TextAlign.center,
                                                )
                                            )),
                                          ]
                                      )
                                  ),
                                  Container(
                                      height: MediaQuery.of(context).size.height * 0.5,
                                      decoration: BoxDecoration(
                                          border: Border(top: BorderSide(color: Colors.black26, width: 0.5))
                                      ),
                                      child: TabBarView(
                                          children: <Widget>[
                                            Container(
                                                child: Center(child: Text("Menunggu Respons"))
                                            ),
                                            Container(
                                                child: Center(child: Text("Sedang Diproses"))
                                            ),
                                            Container(
                                                child: Center(child: Text("Telah Dikonfirmasi"))
                                            ),
                                            Container(
                                                child: Center(child: Text("Dibatalkan"))
                                            )
                                          ]
                                      )
                                  )
                                ]
                            )
                        )
                      ]
                  )
              )
            ]
          )
        )
      ),
    );
  }
}
