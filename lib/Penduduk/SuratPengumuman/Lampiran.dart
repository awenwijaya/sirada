import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class viewLampiranSuratKeluarKrama extends StatefulWidget {
  static var namaFile;
  const viewLampiranSuratKeluarKrama({Key key}) : super(key: key);

  @override
  State<viewLampiranSuratKeluarKrama> createState() => _viewLampiranSuratKeluarKramaState();
}

class _viewLampiranSuratKeluarKramaState extends State<viewLampiranSuratKeluarKrama> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("025393"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text(viewLampiranSuratKeluarKrama.namaFile, style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: Colors.white
          )),
        ),
          body: Container(
            child: SfPdfViewer.network("https://storage.siradaskripsi.my.id/file/lampiran/surat-keluar/${viewLampiranSuratKeluarKrama.namaFile}"),
          )
      ),
    );
  }
}
