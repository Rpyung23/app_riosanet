import 'package:app_riosanet/page/client/mapa_client.dart';
import 'package:app_riosanet/provider/ProviderTransfer.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/quickalert.dart';
import '../../model/model_response.dart';
import '../../model/transfer_all_client/transfer_all_client.dart';
import '../../util/dimens.dart';
import '../../util/icons.dart';
import '../../util/string.dart';

class UpdateDomicilioPageClient extends StatefulWidget {
  final oGlobalKeyFail = GlobalKey<FormState>();

  TransferAllClientModel? oTransferAllClientModel;

  UpdateDomicilioPageClient({super.key});

  @override
  State<UpdateDomicilioPageClient> createState() =>
      _UpdateDomicilioPageClientState();
}

class _UpdateDomicilioPageClientState extends State<UpdateDomicilioPageClient> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readApiTransferClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color_white),
        backgroundColor: color_primary,
        title: Text(
          txt_my_update_domicilio,
          style: TextStyle(color: color_white),
        ),
      ),
      body: Container(
        child: RefreshIndicator(
          child: widget.oTransferAllClientModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _getListTransfer(),
          onRefresh: _readApiTransferClient,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _ShowCreateDomiclio();
        },
        child: icon_add,
        backgroundColor: color_primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _getListTransfer() {
    return ListView.builder(
      itemCount: widget.oTransferAllClientModel == null
          ? 0
          : widget.oTransferAllClientModel!.datos == null
              ? 0
              : widget.oTransferAllClientModel!.datos!.length,
      itemBuilder: (context, index) {
        return _getItemTransfer(widget.oTransferAllClientModel!.datos![index]);
      },
    );
  }

  _getItemTransfer(DatoTransferClient oDatoTransferClient) {
    return ListTile(
      title: Text('CAMBIO DE DOMICLIO'),
      leading: oDatoTransferClient.estado == 3
          ? null
          : IconButton(
              onPressed: () {
                showAlertDeleteDomicilio(oDatoTransferClient.id!);
              },
              icon: icon_trash),
      subtitle: Text(oDatoTransferClient!.dir!),
      enabled: oDatoTransferClient.estado == 3 ? false : true,
      trailing: oDatoTransferClient.estado == 1
          ? icon_pen
          : oDatoTransferClient.estado == 2
              ? icon_prog
              : icon_check,
    );
  }

  Future<void> _readApiTransferClient() async {
    widget.oTransferAllClientModel = null;
    setState(() {});
    widget.oTransferAllClientModel =
        await ProviderTransfer.readTransferClientAll();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  showAlertDeleteDomicilio(int id_domicilio) {
    return QuickAlert.show(
        context: context,
        title: 'ELIMINAR CAMBIO DE DOMICILIO',
        headerBackgroundColor: color_danger,
        type: QuickAlertType.error,
        confirmBtnText: confirmTxtButton,
        cancelBtnText: cancelTxtButton,
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
          _consumirApiDelete(id_domicilio);
        });
  }

  _consumirApiDelete(int id_domicilio) async {
    print("id_domicilio : " + id_domicilio.toString());
    ModelResponse oM = await ProviderTransfer.deleteTransfers(id_domicilio);
    if (oM.statusCode == 200) {
      _readApiTransferClient();
    } else {
      Fluttertoast.showToast(
          msg: oM.msm!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: color_danger,
          textColor: color_white,
          fontSize: textMedium);
    }
  }

  _ShowCreateDomiclio() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("CAMBIO DE DOMICLIO"),
            backgroundColor: color_white,
            surfaceTintColor: color_white,
            content: Container(
              child: _getAlert(),
              width: double.maxFinite,
            ),
          );
        });
  }

  _getAlert() {
    return Form(
        key: widget.oGlobalKeyFail,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
                autofocus: false,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => MapClient()));
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return txt_ingrese_note;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: hint_ubicacion,
                    alignLabelWithHint: true,
                    prefixIcon: icon_map,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder())),
            SizedBox(
              height: marginSmall,
            ),
            TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return txt_ingrese_note;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: hint_telefono,
                    alignLabelWithHint: true,
                    prefixIcon: icon_phone,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder())),
            SizedBox(
              height: marginSmall,
            ),
            TextFormField(
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return txt_ingrese_note;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: hint_referencia,
                    alignLabelWithHint: true,
                    prefixIcon: icon_task_square,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder())),
            SizedBox(
              height: marginSmall,
            ),
            TextFormField(
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return txt_ingrese_note;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: hint_notes,
                    alignLabelWithHint: true,
                    prefixIcon: icon_task_square,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder())),
            SizedBox(
              height: marginMediumSmall,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: color_primary,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width, altoMedium)),
                child: Text(
                  text_save,
                  style: TextStyle(fontSize: textBigMedium, color: color_white),
                ))
          ],
        ));
  }
}
