import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class viewSuratMasukAdmin extends StatefulWidget {
  static var namaFile;
  const viewSuratMasukAdmin({Key key}) : super(key: key);

  @override
  State<viewSuratMasukAdmin> createState() => _viewSuratMasukAdminState();
}

class _viewSuratMasukAdminState extends State<viewSuratMasukAdmin> {
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
          title: Text(viewSuratMasukAdmin.namaFile, style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: HexColor("#025393")
          )),
        ),
        body: Container(
          child: SfPdfViewer.network("http://192.168.18.10//siraja-api-skripsi-new/public/assets/file/surat-masuk/${viewSuratMasukAdmin.namaFile}"),
        )
      )
    );
  }
}