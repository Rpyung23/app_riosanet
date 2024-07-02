// ignore_for_file: prefer_const_constructors
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app_riosanet/page/user/fail_pen_user.dart';
import 'package:app_riosanet/page/user/install_pen_user.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../util/color.dart';
import '../../util/dimens.dart';
import '../../util/icons.dart';
import '../../widget/toolbar.dart';
import 'domicilio_pen_user.dart';

class HomeUser extends StatefulWidget {
  int current_index = 0;
  HomeUser();

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PopScope(
      // ignore: sort_child_properties_last
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color_white),
          backgroundColor: color_primary,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  _showAlert();
                },
                icon: Icon(
                  Iconsax.logout,
                  color: color_white,
                ))
          ],
          title: Text(
            widget.current_index == 0
                ? "INSTALACIONES PENDIENTES"
                : widget.current_index == 1
                    ? "FALLOS PENDIENTES"
                    : "CAMBIOS DE DOMICILIOS",
            style: TextStyle(color: color_white),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(
              top: 0, left: marginSmallSmall, right: marginSmallSmall),
          child: _getBody(),
        ),
        bottomNavigationBar: _getBottomNavigator(),
      ),
      canPop: false,
    ));
  }

  _getBody() {
    if (widget.current_index == 0) {
      return InstallPenUser();
    }

    if (widget.current_index == 1) {
      return FailPenUser();
    }

    return DomicilioPenUser();
  }

  _getBottomNavigator() {
    return AnimatedBottomNavigationBar(
        backgroundColor: color_white,
        elevation: elevation,
        activeColor: color_secondary,
        icons: [icon_data_plann, icon_warning, icon_domicilio],
        activeIndex: widget.current_index,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) {
          if (widget.current_index != index) {
            widget.current_index = index;
            setState(() {});
          }
        });
  }

  _showAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cerrar Sesión'),
            content: Text('¿Está seguro que desea cerrar sesión?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red, // color rojo para el botón "Continuar"
                ),
                child: Text(
                  'Continuar',
                  style: TextStyle(color: color_white),
                ),
                onPressed: () {
                  Navigator.of(context).popAndPushNamed('login_page');
                  // Lógica para cerrar sesión
                },
              ),
            ],
          );
        });
  }
}
