import 'package:admin/screens/login_screen.dart';
import 'package:admin/screens/screens.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF03716E);
const secondaryColor = Color(0xFFF5F5F5);
const bgColor = Color(0xFFECECEC);
const loadingColor = Color.fromARGB(255, 31, 172, 167);

// const primaryColor = Color(0xFF0DE0DA);
// const secondaryColor = Color(0xFF03716E);
// const bgColor = Color(0xFFFFFFFF);

const defaultPadding = 16.0;

Map<String, Widget Function(BuildContext)> routes = {
  '/login_screen': (context) => LoginScreen(),
  '/main_screen': (context) => const MainScreen(),
  '/employee_details': (context) => const EmployeesDetailsScreen(),
  '/person_details': (context) => const PersonDetailsScreen(),
  '/add_edit_employee': (context) => AddEditEmployeeScreen(),
  '/add_edit_person': (context) => AddEditPersonScreen(),
  '/add_donation_campaign': (context) => AddDonationCampaignScreen(),
  '/active_don_camps_screen': (context) => ActiveDonCampsScreen(),
  '/completed_don_camps_screen': (context) => CompletedDonCampsScreen(),
  '/add_don_op_screen': (context) => AddDonOpScreen(),
  '/add_sup_org_screen': (context) => AddSupportiveOrganizationScreen(),
  '/donations_history_screen': (context) => DonationsHistoryScreen(),
  '/sent_notifications_screen': (context) => const SentNotificationsScreen(),
  '/pdf_viewer_screen': (context) => const PDFViewerScreen(),
  '/donation_operations_screen': (context) => const DonationOperationsScreen(),
  '/org_don_history': (context) => const OrganizationDonationHistoryScreen(),
  '/supportive_organizations_screen': (context) =>
      SupportiveOraganizationsScreen(),
};
