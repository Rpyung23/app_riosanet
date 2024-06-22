import 'dart:io';
import 'package:app_riosanet/provider/ProviderInstall.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/install_pen_all/dato_install_pen_model.dart';
import '../../util/dimens.dart';
import '../../util/firebase_utils.dart';
import '../../util/icons.dart';
import '../../util/showtoastdialog.dart';

class DetalleInstallPageUser extends StatefulWidget {
  String img_url = "";
  int? estadoInstall = null;

  DatoInstallPenAll oDatoInstallPenAll;

  DetalleInstallPageUser({required this.oDatoInstallPenAll});

  TextEditingController oTextEditingControllerName = TextEditingController();
  TextEditingController oTextEditingControllerFail = TextEditingController();
  TextEditingController oTextEditingControllerRef = TextEditingController();
  TextEditingController oTextEditingControllerPhone = TextEditingController();
  TextEditingController oTextEditingControllerAnot = TextEditingController();
  TextEditingController oTextEditingControllerDir = TextEditingController();

  @override
  State<DetalleInstallPageUser> createState() => _DetalleInstallPageUserState();
}

class _DetalleInstallPageUserState extends State<DetalleInstallPageUser> {
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
          "Detalle Instalación",
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
                        Uri.parse('tel://${widget.oDatoInstallPenAll.cel}'));
                  },
                  icon: Icon(Iconsax.call)),
              prefixIcon: Icon(Iconsax.mobile)),
        ),
        SizedBox(
          height: 25,
        ),
        TextFormField(
          controller: widget.oTextEditingControllerDir,
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
              prefixIcon: Icon(Iconsax.map)),
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
              value: widget.estadoInstall,
              isDense: false,
              isExpanded: true,
              alignment: Alignment.center,
              items: [
                DropdownMenuItem(
                  value: 1,
                  child: Text("   En Proceso"),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text("   Terminado"),
                )
              ],
              onChanged: (value) {
                widget.estadoInstall = value;
                setState(() {});
              }),
        ),
        SizedBox(
          height: 25,
        ),
        Visibility(
            visible: widget.estadoInstall == 2 ? true : false,
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
            visible: widget.estadoInstall == 2 ? true : false,
            child: SizedBox(
              height: 25,
            )),
        Visibility(
            visible: widget.estadoInstall == 2 ? true : false,
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
              print(widget.oDatoInstallPenAll.toRawJson());
              if (widget.estadoInstall == 1) {
                ProviderInstall.updateInstall(
                    widget.estadoInstall,
                    widget.img_url,
                    widget.oTextEditingControllerAnot.value.text,
                    widget.oDatoInstallPenAll.id);
              } else {
                if (widget.img_url != null && widget.img_url.isNotEmpty) {
                  ProviderInstall.updateInstall(
                      widget.estadoInstall,
                      widget.img_url,
                      widget.oTextEditingControllerAnot.value.text,
                      widget.oDatoInstallPenAll.id);
                } else {
                  ShowToastDialog.showToast('Ingresar imagen  / evidencia.');
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
    widget.estadoInstall = widget.oDatoInstallPenAll.estado;

    ///widget.oDatoInstallPenAll.estado!;

    widget.oTextEditingControllerName.text =
        "${widget.oDatoInstallPenAll.name}";

    widget.oTextEditingControllerFail.text =
        "${widget.oDatoInstallPenAll.tarea}";

    widget.oTextEditingControllerRef.text = "${widget.oDatoInstallPenAll.ref}";

    widget.oTextEditingControllerPhone.text =
        "${widget.oDatoInstallPenAll.cel}";

    widget.oTextEditingControllerAnot.text =
        "${widget.oDatoInstallPenAll.notas}";

    widget.oTextEditingControllerDir.text = "${widget.oDatoInstallPenAll.dir}";
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
}
