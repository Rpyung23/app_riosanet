import 'dart:io';

import 'package:app_riosanet/page/siganture_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/fail_pen_all/dato_fail_pen_model.dart';
import '../../provider/ProviderFail.dart';
import '../../util/dimens.dart';
import '../../util/firebase_utils.dart';
import '../../util/icons.dart';
import '../../util/showtoastdialog.dart';

class DetalleFailPageUser extends StatefulWidget {
  String img_url = "";
  String img_url_signature = "";
  int? estadofail = null;

  DatoFailPenAllModel oDatoFailPenAllModel;

  DetalleFailPageUser({required this.oDatoFailPenAllModel});

  TextEditingController oTextEditingControllerName = TextEditingController();
  TextEditingController oTextEditingControllerFail = TextEditingController();
  TextEditingController oTextEditingControllerRef = TextEditingController();
  TextEditingController oTextEditingControllerPhone = TextEditingController();
  TextEditingController oTextEditingControllerAnot = TextEditingController();

  @override
  State<DetalleFailPageUser> createState() => _DetalleFailPageUserState();
}

class _DetalleFailPageUserState extends State<DetalleFailPageUser> {
  @override
  void initState() {
    // TODO: implement initState
    llenarDatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Detalle del fallo",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: _getBody(),
      ),
    );
  }

  _getBody() {
    return ListView(
      children: [
        TextFormField(
          controller: widget.oTextEditingControllerName,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              prefixIcon: Icon(Iconsax.user)),
        ),
        SizedBox(
          height: 25,
        ),
        TextFormField(
          controller: widget.oTextEditingControllerFail,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              prefixIcon: Icon(icon_warning)),
        ),
        SizedBox(
          height: 25,
        ),
        TextFormField(
          controller: widget.oTextEditingControllerRef,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              suffixIcon: IconButton(
                  onPressed: () {
                    openMap(
                        double.parse(widget.oDatoFailPenAllModel.latUsuario!),
                        double.parse(widget.oDatoFailPenAllModel.latUsuario!));
                  },
                  icon: Icon(Iconsax.search_favorite)),
              prefixIcon: Icon(Iconsax.map)),
        ),
        SizedBox(
          height: 25,
        ),
        TextFormField(
          controller: widget.oTextEditingControllerPhone,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              suffixIcon: IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse(
                        'tel://${widget.oDatoFailPenAllModel.movil}'));
                  },
                  icon: Icon(Iconsax.call)),
              prefixIcon: Icon(Iconsax.mobile)),
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), // Radio del borde
              border: Border.all(
                color: color_primary, // Color del borde
                width: 1, // Ancho del borde
              )),
          child: DropdownButton(
              value: widget.estadofail,
              isDense: false,
              isExpanded: true,
              alignment: Alignment.center,
              items: [
                DropdownMenuItem(
                  value: 2,
                  child: Text("   En Proceso"),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text("   Terminado"),
                )
              ],
              onChanged: (value) {
                widget.estadofail = value;
                setState(() {});
              }),
        ),
        SizedBox(
          height: 25,
        ),
        Visibility(
            visible: widget.estadofail == 3 ? true : false,
            child: TextFormField(
              maxLines: 3,
              controller: widget.oTextEditingControllerAnot,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: "Anotaciones",
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.all(0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_primary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_primary)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: color_primary)),
                  prefixIcon: Icon(Iconsax.note)),
            )),
        Visibility(
            visible: widget.estadofail == 3 ? true : false,
            child: SizedBox(
              height: 25,
            )),
        Visibility(
            visible: widget.estadofail == 3 ? true : false,
            child: GestureDetector(
              child: getFoto(widget.img_url, false),
              onTap: () {
                pickFile();
              },
            )),
        SizedBox(
          height: 25,
        ),
        Visibility(
            visible: widget.estadofail == 3 ? true : false,
            child: GestureDetector(
              child: getFoto(widget.img_url_signature, true),
              onTap: () {
                getUrlSignature();
              },
            )),
        SizedBox(
          height: 25,
        ),
        ElevatedButton(
            onPressed: () {
              ShowToastDialog.showLoader();
              print(widget.oDatoFailPenAllModel.toRawJson());
              if (widget.estadofail == 2) {
                ProviderFail.updateFail(
                    widget.estadofail,
                    widget.oTextEditingControllerAnot.value.text,
                    '',
                    '',
                    widget.oDatoFailPenAllModel.id,
                    widget.oDatoFailPenAllModel.fcm);
              } else {
                if (widget.img_url != null &&
                    widget.img_url.isNotEmpty &&
                    widget.img_url_signature != null &&
                    widget.img_url_signature.isNotEmpty) {
                  ProviderFail.updateFail(
                      widget.estadofail,
                      widget.oTextEditingControllerAnot.value.text,
                      widget.img_url,
                      widget.img_url_signature,
                      widget.oDatoFailPenAllModel.id,
                      widget.oDatoFailPenAllModel.fcm);
                } else {
                  ShowToastDialog.showToast(
                      'Ingresar evidencia y firma digital.');
                }
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: color_secondary,
                minimumSize: Size(
                  double.infinity,
                  altoMedium,
                )),
            child: Text(
              "Guardar cambios",
              style: TextStyle(color: Colors.white, fontSize: textMedium),
            )),
        SizedBox(
          height: 15,
        )
      ],
    );
  }

  getFoto(String img, bool isSignature) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: img.isEmpty
          ? Image.asset(
              !isSignature ? "assets/add_image.jpg" : "assets/signature.png",
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
            )
          : Image.network(
              img,
              fit: BoxFit.fill,
              repeat: ImageRepeat.noRepeat,
            ),
    );
  }

  llenarDatos() {
    widget.estadofail = widget.oDatoFailPenAllModel.estado! == 1
        ? null
        : widget.oDatoFailPenAllModel.estado!;

    widget.oTextEditingControllerName.text =
        "${widget.oDatoFailPenAllModel.nombre}";
    widget.oTextEditingControllerFail.text =
        "${widget.oDatoFailPenAllModel.tarea}";
    widget.oTextEditingControllerRef.text =
        "${widget.oDatoFailPenAllModel.direccion}";
    widget.oTextEditingControllerPhone.text =
        "${widget.oDatoFailPenAllModel.movil}";
    widget.oTextEditingControllerAnot.text =
        "${widget.oDatoFailPenAllModel.notaFallo}";
  }

  static Future<void> openMap(double lat, double lng) async {
    Uri url = Uri.parse('geo:${lat},${lng}?q=${lat},${lng}');

    // ignore: deprecated_member_use
    if (await canLaunch(url.toString())) {
      // ignore: deprecated_member_use
      await launch(url.toString());
    } else {
      await LaunchApp.openApp(
        androidPackageName: 'com.google.android.gms.maps',
        iosUrlScheme: 'maps://',
        openStore: true,
      );
    }
  }

  pickFile() async {
    ImagePicker _imagePicker = ImagePicker();
    XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      widget.img_url = await FirebaseUtils.uploadUserImageToFireStorage(
          File(image.path), File(image.path).path.split('/').last);
      setState(() {});
    }
  }

  getUrlSignature() async {
    widget.img_url_signature = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => SignaturePage()));
    print("URL FIRMA DIGITAL : ${widget.img_url_signature}");
    setState(() {});
  }
}
