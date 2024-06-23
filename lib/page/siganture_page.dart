import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../util/color.dart';

class SignaturePage extends StatefulWidget {
  final SignatureController oSignatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: color_white,
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
        appBar: AppBar(),
        body: Signature(
          controller: widget.oSignatureController,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          backgroundColor: Colors.lightBlueAccent,
        ));
  }
}
