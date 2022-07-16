import 'package:admin/config/constants.dart';
import 'package:admin/controllers/donation_campaigns/donation_campaigns_bloc.dart';
import 'package:admin/controllers/donation_operations/donation_operations_bloc.dart';
import 'package:admin/controllers/employees/employees_bloc.dart';
import 'package:admin/controllers/file/file_bloc.dart';
import 'package:admin/controllers/menu_controller/menu_controller.dart';
import 'package:admin/controllers/navigation/navigation_bloc.dart';
import 'package:admin/controllers/persons/persons_bloc.dart';
import 'package:admin/controllers/supportive_organizations/supportive_organizations_bloc.dart';
import 'package:admin/models/employee.dart';
import 'package:admin/screens/login_screen.dart';
import 'package:admin/screens/main_screen.dart';
import 'package:admin/services/employees_services.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

//  CREATE A [Logger] instance to make a logs
var _logger = Logger();

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// ! THIS FUNCTION IS CALLED FOR TESTING PURPOSES
void testEmployeesServices() async {
  var service = EmployeesServices();
  service.getEmployees().then((value) {
    for (var employee in value!) {
      _logger.d(employee);
    }
  });
  service
      .storeEmployee(Employee(
    firstName: 'Fares',
    lastName: 'Dobsi',
    phoneNumber: '+963991146587',
    email: 'fares.dobsi@gmail.com',
    password: '12345678',
    cityEn: 'Mohajirin',
    stateEn: 'Damascus',
    cvFileUrl: 'https://www.clickdimensions.com/links/TestPDFfile.pdf',
    isAdmin: false,
  ))
      .then((value) {
    _logger.i(value);
  });
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return MenuController();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FileBloc>(create: (context) => FileBloc()),
          BlocProvider<NavigationBloc>(
            create: (context) =>
                NavigationBloc()..add(NavigateToPage(pageIndex: 0)),
          ),
          BlocProvider<EmployeesBloc>(
            create: (context) => EmployeesBloc()..add(GetEmployees()),
          ),
          BlocProvider<DonationCampaignsBloc>(
            create: (context) =>
                DonationCampaignsBloc()..add(GetDonationCampaigns()),
          ),
          BlocProvider<DonationOperationsBloc>(
            create: (context) =>
                DonationOperationsBloc()..add(GetDonationOperations()),
          ),
          BlocProvider<SupportiveOrganizationsBloc>(
            create: (context) => SupportiveOrganizationsBloc()
              ..add(GetSupportiveOrganizations()),
          ),
          BlocProvider<PersonsBloc>(
            create: (context) =>
                PersonsBloc()..add(GetPersonsWithSpecialNeeds()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ataa Admin Panel',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: bgColor,
            textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.black),
            canvasColor: secondaryColor,
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routes: routes,
          home: const MainScreen(),
        ),
      ),
    );
  }
}
