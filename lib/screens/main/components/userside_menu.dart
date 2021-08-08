import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserSideMenu extends StatelessWidget {
  const UserSideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/ic_logo.png"),
          ),
          DrawerListTile(
            title: "Panel de Control",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Billetera",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Enlaces",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Resumen",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Ranking",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Referidos",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Mi Perfil",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Ajustes",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Terminos y condiciones",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
