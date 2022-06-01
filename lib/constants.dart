import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/screens.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF03716E);
const secondaryColor = Color(0xFFF5F5F5);
const bgColor = Color(0xFFECECEC);

// const primaryColor = Color(0xFF0DE0DA);
// const secondaryColor = Color(0xFF03716E);
// const bgColor = Color(0xFFFFFFFF);

const defaultPadding = 16.0;

Map<String, Widget Function(BuildContext)> routes = {
  '/main_screen': (context) => MainScreen(),
  '/employee_details': (context) => EmployeesDetailsScreen(),
  '/add_edit_employee': (context) => AddEditEmployeeScreen(),
};
