import 'package:app_riosanet/provider/ProviderTransfer.dart';
import 'package:app_riosanet/util/color.dart';
import 'package:flutter/material.dart';
import '../../model/transfer_all_client/transfer_all_client.dart';
import '../../util/icons.dart';
import '../../util/string.dart';

class UpdateDomicilioPageClient extends StatefulWidget {
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
          child: _getListTransfer(),
          onRefresh: _readApiTransferClient,
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
    widget.oTransferAllClientModel =
        await ProviderTransfer.readTransferClientAll();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
