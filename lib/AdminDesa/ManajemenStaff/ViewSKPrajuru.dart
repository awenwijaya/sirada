import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class viewSKPrajuru extends StatefulWidget {
  static var namaFile;
  const viewSKPrajuru({Key key}) : super(key: key);

  @override
  State<viewSKPrajuru> createState() => _viewSKPrajuruState();
}

class _viewSKPrajuruState extends State<viewSKPrajuru> {
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
          title: Text(viewSKPrajuru.namaFile, style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: Container(
          child: SfPdfViewer.network('http://storage.siradaskripsi.my.id/img/SK/${viewSKPrajuru.namaFile}'),
        ),
      ),
    );
  }
}