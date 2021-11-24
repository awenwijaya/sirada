import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class formPendaftaranAktaKelahiran extends StatefulWidget {
  const formPendaftaranAktaKelahiran({Key key}) : super(key: key);

  @override
  _formPendaftaranAktaKelahiranState createState() => _formPendaftaranAktaKelahiranState();
}

class _formPendaftaranAktaKelahiranState extends State<formPendaftaranAktaKelahiran> {
  List<String> jenisKelamin = ["Laki-Laki", "Perempuan"];
  List<String> tempatDilahirkan = ["RS/RB", "Puskesmas", "Polindes", "Rumah", "Lainnya"];
  List<String> jenisKelahiran = ["Tunggal", "Kembar 2", "Kembar 3", "Kembar 4", "Lainnya"];
  List<String> penolongKelahiran = ["Dokter", "Bidan/Perawat", "Dukun", "Lainnya"];

  String selectedJenisKelamin;
  String selectedTempatDilahirkan;
  String selectedJenisKelahiran;
  String selectedPenolongKelahiran;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Formulir Surat Akta Kelahiran", style: TextStyle(
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Formulir Surat Akta Kelahiran",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins"
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "* = dibutuhkan",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins",
                          color: Colors.redAccent
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15),
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
                        "Nama Anak *",
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
                            hintText: "Nama Anak"
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
                        "Jenis Kelamin *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: HexColor("#025393"),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: DropdownButton<String>(
                        onChanged: (value) {
                          setState(() {
                            selectedJenisKelamin = value;
                          });
                        },
                        value: selectedJenisKelamin,
                        underline: Container(),
                        hint: Center(
                          child: Text(
                            "Jenis Kelamin",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 15
                            ),
                          ),
                        ),
                        icon: Icon(Icons.arrow_downward, color: Colors.white),
                        isExpanded: true,
                        items: jenisKelamin.map((e) => DropdownMenuItem(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 15
                              ),
                            ),
                          ),
                          value: e,
                        )).toList(),
                          selectedItemBuilder: (BuildContext context) => jenisKelamin.map((e) => Center(
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: "Poppins"
                              ),
                            ),
                          )).toList()
                      ),
                      margin: EdgeInsets.only(top: 20),
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
                        "Tempat Dilahirkan *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                          color: HexColor("#025393"),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: DropdownButton<String>(
                          onChanged: (value) {
                            setState(() {
                              selectedTempatDilahirkan = value;
                            });
                          },
                          value: selectedTempatDilahirkan,
                          underline: Container(),
                          hint: Center(
                            child: Text(
                              "Tempat Dilahirkan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 15
                              ),
                            ),
                          ),
                          icon: Icon(Icons.arrow_downward, color: Colors.white),
                          isExpanded: true,
                          items: tempatDilahirkan.map((e) => DropdownMenuItem(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                e,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15
                                ),
                              ),
                            ),
                            value: e,
                          )).toList(),
                          selectedItemBuilder: (BuildContext context) => tempatDilahirkan.map((e) => Center(
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: "Poppins"
                              ),
                            ),
                          )).toList()
                      ),
                      margin: EdgeInsets.only(top: 20),
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
                        "Tempat Kelahiran *",
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
                              hintText: "Tempat Kelahiran"
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
                        "Jenis Kelahiran *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                          color: HexColor("#025393"),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: DropdownButton<String>(
                          onChanged: (value) {
                            setState(() {
                              selectedJenisKelahiran = value;
                            });
                          },
                          value: selectedJenisKelahiran,
                          underline: Container(),
                          hint: Center(
                            child: Text(
                              "Jenis Kelahiran",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 15
                              ),
                            ),
                          ),
                          icon: Icon(Icons.arrow_downward, color: Colors.white),
                          isExpanded: true,
                          items: jenisKelahiran.map((e) => DropdownMenuItem(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                e,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15
                                ),
                              ),
                            ),
                            value: e,
                          )).toList(),
                          selectedItemBuilder: (BuildContext context) => jenisKelahiran.map((e) => Center(
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: "Poppins"
                              ),
                            ),
                          )).toList()
                      ),
                      margin: EdgeInsets.only(top: 20),
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
                        "Kelahiran ke *",
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              hintText: "Kelahiran ke",
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
                        "Penolong Kelahiran *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                          color: HexColor("#025393"),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: DropdownButton<String>(
                          onChanged: (value) {
                            setState(() {
                              selectedPenolongKelahiran = value;
                            });
                          },
                          value: selectedPenolongKelahiran,
                          underline: Container(),
                          hint: Center(
                            child: Text(
                              "Penolong Kelahiran",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 15
                              ),
                            ),
                          ),
                          icon: Icon(Icons.arrow_downward, color: Colors.white),
                          isExpanded: true,
                          items: penolongKelahiran.map((e) => DropdownMenuItem(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                e,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15
                                ),
                              ),
                            ),
                            value: e,
                          )).toList(),
                          selectedItemBuilder: (BuildContext context) => penolongKelahiran.map((e) => Center(
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: "Poppins"
                              ),
                            ),
                          )).toList()
                      ),
                      margin: EdgeInsets.only(top: 20),
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
                        "Panjang Bayi *",
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              hintText: "Panjang Bayi (CM)"
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Berat Bayi *",
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              hintText: "Berat Bayi (KG)"
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Keluarga Anak *",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins"
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){},
                        child: Text("Pilih Keluarga Anak", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                        )),
                        color: HexColor("#025393"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                      ),
                      margin: EdgeInsets.only(top: 10, bottom: 10),
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