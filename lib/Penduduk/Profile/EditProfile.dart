import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class editProfileUser extends StatefulWidget {
  const editProfileUser({Key key}) : super(key: key);

  @override
  _editProfileUserState createState() => _editProfileUserState();
}

class _editProfileUserState extends State<editProfileUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profil", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop();},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              color: HexColor("#025393"),
              onPressed: (){},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Edit Profil",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins"
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "* = required",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15,
                          fontFamily: "Poppins"
                        ),
                      ),
                      margin: EdgeInsets.only(left: 80),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20, left: 20),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Username *",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            hintText: "Username"
                          ),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Email *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: "Email"
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Password *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              hintText: "Password"
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15
                          ),
                          obscureText: true,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Nomor Telepon *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              prefixIcon: Icon(Icons.phone_outlined),
                              hintText: "Nomor Telepon"
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
