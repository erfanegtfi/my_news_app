enum Flavor { stage, prod }

class FlavorConfig {
  static Flavor _flavor = Flavor.stage;
  static String _apiBaseDomain = "";
  static String _apiKey = "";

  Flavor get flavor => _flavor;
  String get apiBaseDomain => _apiBaseDomain;
  String get apiKey => _apiKey;

  void setFlavor(Flavor fl) {
    _flavor = fl;
  }

  void setApiBaseDomain(String apiUrl) {
    _apiBaseDomain = apiUrl;
  }

  void setApiBaseDomainDev(String apiKey) {
    _apiKey = apiKey;
  }

  static final FlavorConfig _instance = FlavorConfig._internal();

  factory FlavorConfig() => _instance;

  FlavorConfig._internal();
}
