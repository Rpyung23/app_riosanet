import 'dart:io';
import 'package:app_riosanet/provider/ProviderInstall.dart';
import 'package:app_riosanet/provider/ProviderTransfer.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/install_pen_all/dato_install_pen_model.dart';
import '../../model/transfer_all_pen.dart';
import '../../util/dimens.dart';
import '../../util/firebase_utils.dart';
import '../../util/icons.dart';
import '../../util/showtoastdialog.dart';

class DetalleDomicilioPageUser extends StatefulWidget {
  String img_url = "";
  int? estadoDomicilio = null;

  DatoTransferAllPen oDatoTransferAllPen;

  DetalleDomicilioPageUser({required this.oDatoTransferAllPen});

  TextEditingController oTextEditingControllerName = TextEditingController();
  TextEditingController oTextEditingControllerFail = TextEditingController();
  TextEditingController oTextEditingControllerRef = TextEditingController();
  TextEditingController oTextEditingControllerPhone = TextEditingController();
  TextEditingController oTextEditingControllerAnot = TextEditingController();
  TextEditingController oTextEditingControllerDir = TextEditingController();

  @override
  State<DetalleDomicilioPageUser> createState() =>
      _DetalleDomicilioPageUserState();
}

class _DetalleDomicilioPageUserState extends State<DetalleDomicilioPageUser> {
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
          "Detalle Traspaso",
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
                    launchUrl(
                        Uri.parse('tel://${widget.oDatoTransferAllPen.cel}'));
                  },
                  icon: Icon(Iconsax.call)),
              prefixIcon: Icon(Iconsax.mobile)),
        ),
        SizedBox(
          height: 25,
        ),
        TextFormField(
          controller: widget.oTextEditingControllerDir,
          maxLines: 1,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              prefixIcon: Icon(Iconsax.map),
              suffixIcon: IconButton(
                  onPressed: () {
                    openMap(widget.oDatoTransferAllPen.latTraspaso!,
                        widget.oDatoTransferAllPen.lngTraspaso!);
                  },
                  icon: Icon(Iconsax.search_favorite))),
        ),
        SizedBox(
          height: 25,
        ),
        TextFormField(
          controller: widget.oTextEditingControllerRef,
          maxLines: 2,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: color_primary)),
              prefixIcon: Icon(Iconsax.note)),
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
              value: widget.estadoDomicilio,
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
                widget.estadoDomicilio = value;
                setState(() {});
              }),
        ),
        SizedBox(
          height: 25,
        ),
        Visibility(
            visible: widget.estadoDomicilio == 3 ? true : false,
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
            visible: widget.estadoDomicilio == 3 ? true : false,
            child: SizedBox(
              height: 25,
            )),
        Visibility(
            visible: widget.estadoDomicilio == 3 ? true : false,
            child: GestureDetector(
              child: getFoto(),
              onTap: () {
                pickFile();
              },
            )),
        SizedBox(
          height: 25,
        ),
        ElevatedButton(
            onPressed: () {
              ShowToastDialog.showLoader();

              if (widget.estadoDomicilio == 2) {
                ProviderTransfer.updateEstadoTransfer(widget.estadoDomicilio,
                    '', '', '', widget.oDatoTransferAllPen.id);
              } else {
                if (widget.img_url != null && widget.img_url.isNotEmpty) {
                  ProviderTransfer.updateEstadoTransfer(
                      widget.estadoDomicilio,
                      widget.oTextEditingControllerAnot.value.text,
                      widget.img_url,
                      '',
                      widget.oDatoTransferAllPen.id);
                } else {
                  ShowToastDialog.showToast(
                      "Por favor subir una imagen / evidencia");
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

  getFoto() {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: widget.img_url.isEmpty
          ? Image.asset(
              "assets/add_image.jpg",
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
            )
          : Image.network(
              widget.img_url,
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
            ),
    );
  }

  llenarDatos() {
    widget.estadoDomicilio = widget.oDatoTransferAllPen.estado == 1
        ? null
        : widget.oDatoTransferAllPen.estado;

    ///widget.oDatoInstallPenAll.estado!;

    widget.oTextEditingControllerName.text =
        "${widget.oDatoTransferAllPen.nombre}";

    widget.oTextEditingControllerFail.text =
        "${widget.oDatoTransferAllPen.ref}";

    widget.oTextEditingControllerRef.text = "${widget.oDatoTransferAllPen.ref}";

    widget.oTextEditingControllerPhone.text =
        "${widget.oDatoTransferAllPen.cel}";

    widget.oTextEditingControllerAnot.text =
        "${widget.oDatoTransferAllPen.anotaciones}";

    widget.oTextEditingControllerDir.text = "${widget.oDatoTransferAllPen.dir}";
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
}
