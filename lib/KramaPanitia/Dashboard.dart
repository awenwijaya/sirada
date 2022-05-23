import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class dashboardKramaPanitia extends StatefulWidget {
  const dashboardKramaPanitia({Key key}) : super(key: key);

  @override
  State<dashboardKramaPanitia> createState() => _dashboardKramaPanitiaState();
}

class _dashboardKramaPanitiaState extends State<dashboardKramaPanitia> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Row(
                children: <Widget>[
                  Text("SiRada", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  )),
                  Container(
                    child: Text("PANITIA", style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      color: HexColor("#025393"),
                      fontSize: 14
                    )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.only(left: 10),
                  )
                ],
              ),
              backgroundColor: HexColor("#025393"),
              expandedHeight: 180.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.only(top: statusBarHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/profilepic.png'),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text("Halo 👋", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Panitia", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.white
                        )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text("Desa Anda", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    )),
                    margin: EdgeInsets.only(top: 20, left: 15),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('images/noimage.png'),
                              fit: BoxFit.fill
                            )
                          ),
                          margin: EdgeInsets.only(left: 20)
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text("Nama Desa", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                                )),
                                margin: EdgeInsets.only(left: 20)
                              ),
                              Container(
                                child: TextButton(
                                  child: Text("Lihat Detail Desa", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#025393")
                                  )),
                                  onPressed: (){},
                                ),
                                margin: EdgeInsets.only(left: 15)
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0,3)
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text("Validasi Surat", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    )),
                    margin: EdgeInsets.only(top: 20, left: 15)
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}