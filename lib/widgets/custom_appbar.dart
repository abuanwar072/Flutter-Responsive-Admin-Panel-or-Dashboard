import 'package:admin/controllers/menu_controller/menu_controller.dart';
import 'package:admin/controllers/navigation/navigation_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.leading,
    this.actions,
  }) : super(key: key);
  final Widget? leading;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black45,
          ),
          onPressed: Provider.of<MenuController>(context).controlMenu,
          splashRadius: 20,
        ),
        BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return Text(
              state.pageTitle,
              style: Theme.of(context).textTheme.headline6,
            ).tr();
          },
        ),
        if (leading != null) leading!,
      ],
    );
  }
}
