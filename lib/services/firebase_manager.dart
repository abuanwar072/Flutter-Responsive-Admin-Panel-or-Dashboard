import 'package:admin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseManager {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Map? tokenPrices;

  static Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    getTokenPrices();
  }

  static Future getTokenPrices() async {
    DatabaseEvent event = await database.ref().child('token_prices').once();
    DataSnapshot snapshot = event.snapshot;

    tokenPrices = snapshot.value as Map?;
  }

  static Future saveTokenPrice(String address, Map data, String chain) async {
    await database.ref().child('token_prices').child(chain).child(address).set(data);
  }
}
