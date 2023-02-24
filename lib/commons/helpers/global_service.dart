import '../commons.dart';

/// Singleton class for set and get global value

class GlobalService {
  static final GlobalService _instance = GlobalService._internal();

  // passes the instantiation to the object
  factory GlobalService() => _instance;

  // initialize variables in here
  GlobalService._internal() {
    flavor = Flavor.prod;
  }

  /// Using for environment flavour
  Flavor flavor = Flavor.prod;

  // getter for usageFlavor variable
  Flavor get usageFlavor => flavor;

  // setter for usageFlavor variable
  set usageFlavor(Flavor value) {
    flavor = value;
  }
}
