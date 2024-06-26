import 'dart:io';

import 'package:app_riosanet/util/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../util/color.dart';
import '../util/icons.dart';
import '../util/showtoastdialog.dart';

class SignaturePage extends StatefulWidget {
  String? _urlSignature;
  final SignatureController oSignatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: color_black,
    exportBackgroundColor: color_white,
  );

  SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  @override
  void initState() {
    // TODO: implement initState
    widget.oSignatureController.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.oSignatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(
                    widget._urlSignature == null ? "" : widget._urlSignature);
              },
              icon: icon_back),
          backgroundColor: color_primary,
          title: Text(
            "Firma digital",
            style: TextStyle(color: color_white),
          ),
        ),
        body: Stack(
          children: [
            Signature(
              controller: widget.oSignatureController,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              backgroundColor: color_accent,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: ElevatedButton(
                    onPressed: () {
                      _uploadSignature();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: color_success),
                    child: Text(
                      "GUARDAR FIRMA",
                      style: TextStyle(color: color_white),
                    )),
                padding: EdgeInsets.only(bottom: 20),
              ),
            )
          ],
        ));
  }

  _uploadSignature() async {
    var uuid = Uuid();
    String name_File = uuid.v1();

    final pnBytes = await widget.oSignatureController.toPngBytes();
    if (pnBytes == null) {
      ShowToastDialog.showToast("POR FAVOR INGRESE SU FIRMA");
      return;
    }

    ShowToastDialog.showLoader();

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/${name_File}.png');
    await file.writeAsBytes(pnBytes);
    String downloadUrl =
        await FirebaseUtils.uploadSignatureImageToFireStorage(file, name_File);
    print('${downloadUrl}');
    widget._urlSignature = downloadUrl;
    ShowToastDialog.closeLoader();
    if (downloadUrl != null) {
      Navigator.of(context)
          .pop(widget._urlSignature == null ? "" : widget._urlSignature);
    } else {
      ShowToastDialog.showToast("ERROR AL SUBIR FIRMA DIGITAL");
    }
  }
}
