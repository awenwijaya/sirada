import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class viewLampiranSuratKrama extends StatefulWidget {
  static var namaFile;
  const viewLampiranSuratKrama({Key key}) : super(key: key);

  @override
  _viewLampiranSuratKramaState createState() => _viewLampiranSuratKramaState();
}

class _viewLampiranSuratKramaState extends State<viewLampiranSuratKrama> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(viewLampiranSuratKrama.namaFile, style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700
          )),
          backgroundColor: HexColor("#025393"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: (){Navigator.of(context).pop();},
          ),
        ),
          body: Container(
            child: SfPdfViewer.network("http://192.168.18.10/siraja-api-skripsi-new/public/assets/file/lampiran/${viewLampiranSuratKrama.namaFile}"),
          )
      ),
    );
  }
}
