import 'package:admin/constants.dart';
import 'package:admin/controllers/navigation/navigation_bloc.dart';
import 'package:admin/models/drawer_listitem.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                SvgPicture.asset("assets/icons/logo.svg"),
                SizedBox(height: defaultPadding * 0.5),
                Text(
                  tr('charity_name'),
                  style: TextStyle(
                    color: Color(0xFF03716E),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          for (int index = 0; index < sideMenuOptions.length; index++)
            DrawerListTile(
              press: () {
                BlocProvider.of<NavigationBloc>(context)
                    .add(NavigateToPage(pageIndex: index));
              },
              drawerItem: sideMenuOptions[index],
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
    required this.press,
    required this.drawerItem,
  }) : super(key: key);

  final DrawerListItem drawerItem;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        drawerItem.svgSrc,
        color: Colors.black54,
        height: 16,
      ),
      title: Text(
        drawerItem.titleKey,
        style: TextStyle(color: Colors.black54),
      ).tr(),
    );
  }
}
