import 'package:app_riosanet/provider/ProviderFail.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/fail_pen_all_client/fail_pen_all_client_model.dart';
import '../../util/icons.dart';
import '../../util/string.dart';

class FailClientPage extends StatefulWidget {
  FailAllPenClientModel? oFailAllPenClientModel;

  FailClientPage({super.key});

  @override
  State<FailClientPage> createState() => _FailClientPageState();
}

class _FailClientPageState extends State<FailClientPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        onPressed: () {},
        child: icon_add,
        backgroundColor: color_primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _getListFail() {
    return ListView.builder(
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
      enabled: oDatoFailAllPenClientModel.estado == 3 ? false : true,
      title: Text(oDatoFailAllPenClientModel!.tarea!),
      subtitle: Text(oDatoFailAllPenClientModel!.direccion!),
      trailing: oDatoFailAllPenClientModel.estado == 1
          ? icon_pen
          : oDatoFailAllPenClientModel.estado == 2
              ? icon_prog
              : icon_check,
    );
  }

  Future<void> _readApiFailClient() async {
    widget.oFailAllPenClientModel = null;
    widget.oFailAllPenClientModel = await ProviderFail.readFailPenAllClient();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
