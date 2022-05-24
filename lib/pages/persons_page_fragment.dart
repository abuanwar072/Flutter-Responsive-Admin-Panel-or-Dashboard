import 'package:admin/controllers/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsPageFragment extends StatelessWidget {
  const PersonsPageFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Center(child: Text(state.pageTitle));
      },
    );
  }
}

