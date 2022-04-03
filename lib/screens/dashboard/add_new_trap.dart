import 'dart:async';


import 'package:event_bus/event_bus.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


class AddNewTrapScreen extends StatefulWidget {
  const AddNewTrapScreen({Key? key}) : super(key: key);

  @override
  AddNewTrapScreenState createState() => AddNewTrapScreenState();
}

enum WorkflowStep { SelectDockStep, PinStep, ConfirmStep, LockedStep }


class AddNewTrapScreenState extends State<AddNewTrapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  TextStyle styleText = const TextStyle(color: Colors.white);
  final DateFormat formatter = DateFormat('MMMM, dd, yyyy');

  final _formKey = GlobalKey<FormBuilderState>();

  String nameTrap = "";

  String descriptionTrap = "";

  ScrollController? _scrollController;

  Position? currentPosition;

  WorkflowStep currentStep = WorkflowStep.SelectDockStep;

  bool isKeypad = false;

  bool isOpened = true;

  String keyValue = "";

  String dockId = "";

  LatLng dockPosition = LatLng(0,0);

  Set<Marker> lockedMarker = Set();

  BitmapDescriptor? pinLocationIcon;

  late String imageUrl;

  LatLng? selectedPosition;


  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _determinePosition();

  }

  Set<Marker> markers = Set();


  _showModal(LatLng selectedPosition) {

    showModalBottomSheet(
        isScrollControlled: true,

        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)) ,
        ),
        context: context,
        builder: (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setStater) {
                      return _buildAddNewTrapForm(setStater, selectedPosition);


            }));
  }

  Widget _buildAddNewTrapForm(StateSetter setStater, LatLng selectedPosition) {

    return Stack(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text( "Nuevo trap", style: TextStyle(fontSize: 26),),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:  Column(
                    children: [
                      FormBuilder(
                        key: _formKey,
                        child:
                        Column(
                          children: [
                            FormBuilderTextField(
                            name: 'name',
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              labelText:
                              'Nombre del Trap (Alias)',
                            ),

                            onChanged: (value){
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context, errorText: "El alias es requerido"),
                              FormBuilderValidators.max(context, 30, errorText: "Max 30 caracteres"),
                            ]),
                            keyboardType: TextInputType.name,
                      ),
                            FormBuilderTextField(

                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              name: 'description',
                              decoration: InputDecoration(
                                labelText:
                                'Descripción',
                              ),
                              onChanged: (value){
                                    descriptionTrap = value ?? "";
                              },

                              // valueTransformer: (text) => num.tryParse(text),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,errorText: "La descripsión es requerida"),
                                FormBuilderValidators.max(context, 70, errorText: "Max 70 caracteres"),

                              ]),
                              keyboardType: TextInputType.name,
                            ),
                          ],
                        ),

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        child: Text('Submit'),
                        onPressed: ()  {

                          _formKey.currentState?.save() ;
                          if (_formKey.currentState?.validate() ?? false) {
                            print(_formKey.currentState?.value);
                          } else {
                            print("validation failed");
                          }

                         // debugPrint("Name " + _formKey.currentState?.value["name"] + "Description " + _formKey.currentState?.value["description"] + "position " + selectedPosition.toString() );
                            // Either invalidate using Form Key



                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3 - 30,
                      )
                    ],
                  ),

              )
            ]
        )

      ],
    );

  }


  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
              // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    currentPosition = await Geolocator.getCurrentPosition();
   /*_addDataFake();
    _manager = _initClusterManager();*/
    setState(() {});

  }

  Widget buildDashboard(BuildContext context, ) {
    return Stack(
      children: [
        currentPosition == null
            ? Container()
            : GoogleMap(
                mapType: MapType.normal,
                markers: lockedMarker,
                initialCameraPosition: CameraPosition(
                  target: LatLng(currentPosition?.latitude ?? 0.0,
                      currentPosition?.longitude ?? 0.0),
                  zoom: 14.4746,
                ),
                onLongPress: (LatLng selectedPosition){
                  Marker point = Marker(markerId: MarkerId("id"), position: selectedPosition);
                setState(() {
                  lockedMarker.add(point);
                });
                _showModal(selectedPosition);
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                }),
        Container(
          height: 80,

          child: AppBar(

            centerTitle: true,
            automaticallyImplyLeading: true,
            titleSpacing: 15,
            title: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF212332),
                ),
                child: Text("Press in the map for add a new Trap", style: TextStyle(color: Colors.white, fontSize: 14),)
            ),

            backgroundColor: Color(0xFF212332),
            bottomOpacity: 0.0,
            elevation: 0,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xFFF1F5F8),
        // drawer: DrawerWidget(),

        resizeToAvoidBottomInset: true,
        body: buildDashboard(context));
  }

  Widget child(BuildContext context) {
    return Positioned.fill(
        child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero),
          gradient: LinearGradient(
              colors: [Colors.red, Colors.blue],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),
    ));
  }

  void _showError(BuildContext context, String message) {
    //TODO: Error message
    //FlushBarService.getFlushBar(context, "Error", message);
  }

  decoration(String text, IconData icon) {
    return InputDecoration(
      fillColor: Colors.white,
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white30)),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      hintText: text,
      hintStyle: styleText,
    );
  }
}
