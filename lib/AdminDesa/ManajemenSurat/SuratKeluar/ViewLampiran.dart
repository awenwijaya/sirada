import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class viewLampiranSuratKeluarAdmin extends StatefulWidget {
  static var namaFile;
  const viewLampiranSuratKeluarAdmin({Key key}) : super(key: key);

  @override
  State<viewLampiranSuratKeluarAdmin> createState() => _viewLampiranSuratKeluarAdminState();
}

class _viewLampiranSuratKeluarAdminState extends State<viewLampiranSuratKeluarAdmin> {
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
              title: Text(viewLampiranSuratKeluarAdmin.namaFile, style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  color: HexColor("#025393")
              )),
            ),
            body: Container(
              child: SfPdfViewer.network("https://storage.siradaskripsi.my.id/file/lampiran/surat-keluar/${viewLampiranSuratKeluarAdmin.namaFile}"),
            )
        )
    );
  }
}
