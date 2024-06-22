import 'package:flutter_easyloading/flutter_easyloading.dart';

class ShowToastDialog {
  static showToast(String? message,
      {EasyLoadingToastPosition position = EasyLoadingToastPosition.top}) {
    EasyLoading.showToast(message!, toastPosition: position);
  }

  static showLoader() {
    EasyLoading.show(status: "Por favor espere..");
  }

  static closeLoader() {
    EasyLoading.dismiss();
  }
}
