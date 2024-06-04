import 'package:app_riosanet/provider/ProviderFail.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/quickalert.dart';

import '../../model/fail_pen_all_client/fail_pen_all_client_model.dart';
import '../../model/list_type_fail/data_list_type_fail_model.dart';
import '../../model/list_type_fail/list_type_fail_model.dart';
import '../../model/model_response.dart';
import '../../util/dimens.dart';
import '../../util/icons.dart';
import '../../util/string.dart';

class FailClientPage extends StatefulWidget {
  final oGlobalKeyFail = GlobalKey<FormState>();

  List<DropdownMenuItem<DatoTypeFail>> oListDropdownMenuItemTypeFail = [];
  FailAllPenClientModel? oFailAllPenClientModel;
  TextEditingController oTextEditingControllerNotas = TextEditingController();
  DatoTypeFail? oDatoTypeFail;
  FailClientPage({super.key});

  @override
  State<FailClientPage> createState() => _FailClientPageState();
}

class _FailClientPageState extends State<FailClientPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readTypeFail();
    _readApiFailClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color_white),
        backgroundColor: color_primary,
        title: Text(
          txt_my_fail,
          style: TextStyle(color: color_white),
        ),
      ),
      body: Container(
        child: RefreshIndicator(
          child: _getListFail(),
          onRefresh: _readApiFailClient,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlertCreateFail();
        },
        child: icon_add,
        backgroundColor: color_primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _getListFail() {
    return widget.oFailAllPenClientModel == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: widget.oFailAllPenClientModel == null
                ? 0
                : widget.oFailAllPenClientModel!.datos == null
                    ? 0
                    : widget.oFailAllPenClientModel!.datos!.length,
            itemBuilder: (context, index) {
              return _getItemFail(widget.oFailAllPenClientModel!.datos![index]);
            },
          );
  }

  _getItemFail(DatoFailAllPenClientModel oDatoFailAllPenClientModel) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(0),
      enabled: oDatoFailAllPenClientModel.estado == 3 ? false : true,
      leading: oDatoFailAllPenClientModel.estado == 3
          ? null
          : IconButton(
              onPressed: () {
                showAlertDeleteFail(oDatoFailAllPenClientModel.id!);
              },
              icon: icon_close),
      title: Text(oDatoFailAllPenClientModel!.tarea!),
      subtitle: Text(oDatoFailAllPenClientModel!.direccion!),
      /*trailing: oDatoFailAllPenClientModel.estado == 1
          ? icon_pen
          : oDatoFailAllPenClientModel.estado == 2
              ? icon_prog
              : icon_check,*/
    );
  }

  Future<void> _readApiFailClient() async {
    widget.oFailAllPenClientModel = null;
    setState(() {});
    widget.oFailAllPenClientModel = await ProviderFail.readFailPenAllClient();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  showAlertDeleteFail(int id_fail) {
    return QuickAlert.show(
        context: context,
        title: 'ELIMINAR FALLO',
        headerBackgroundColor: color_danger,
        type: QuickAlertType.error,
        confirmBtnText: confirmTxtButton,
        cancelBtnText: cancelTxtButton,
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
          _consumirApiDelete(id_fail);
        });
  }

  _consumirApiDelete(int id_fail) async {
    ModelResponse oM = await ProviderFail.deleteFail(id_fail);
    if (oM.statusCode == 200) {
      _readApiFailClient();
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

  showAlertCreateFail() {
    widget.oTextEditingControllerNotas.clear();
    widget.oDatoTypeFail = null;

    setState(() {});

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("REGISTRAR NUEVO FALLO"),
            backgroundColor: color_white,
            surfaceTintColor: color_white,
            content: Form(
                key: widget.oGlobalKeyFail,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField(
                        value: widget.oDatoTypeFail,
                        isExpanded: true,
                        validator: (value) {
                          if (value == null) {
                            return txt_ingrese_type_Fail;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder()),
                        items: widget.oListDropdownMenuItemTypeFail,
                        onChanged: (value) {
                          widget.oDatoTypeFail = value;
                        }),
                    SizedBox(
                      height: marginSmall,
                    ),
                    TextFormField(
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return txt_ingrese_note;
                          }
                          return null;
                        },
                        controller: widget.oTextEditingControllerNotas,
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
                        onPressed: () {
                          _crearNuevoFail();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: color_primary,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width, altoMedium)),
                        child: Text(
                          text_save,
                          style: TextStyle(
                              fontSize: textBigMedium, color: color_white),
                        ))
                  ],
                )),
          );
        });
  }

  _readTypeFail() async {
    ModelListTypeFail oM = await ProviderFail.readTypeFail();
    if (oM.statusCode == 200) {
      for (int i = 0; i < oM.datos!.length; i++) {
        widget.oListDropdownMenuItemTypeFail.add(DropdownMenuItem<DatoTypeFail>(
          child: Text(oM.datos![i].nombre!),
          value: oM.datos![i],
        ));
      }
    }
    //setState(() {});
  }

  _crearNuevoFail() async {
    if (!widget.oGlobalKeyFail.currentState!.validate()) {
      return;
    }

    if (widget.oDatoTypeFail != null) {
      ModelResponse oM = await ProviderFail.createFail(
          widget.oDatoTypeFail!.nombre!,
          widget.oTextEditingControllerNotas.text);
      if (oM.statusCode != 200) {
        Fluttertoast.showToast(
            msg: oM.msm!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: color_danger,
            textColor: color_white,
            fontSize: textMedium);
      } else {
        Navigator.of(context).pop();
        _readApiFailClient();
      }
    }
  }
}
