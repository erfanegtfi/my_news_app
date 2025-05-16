import 'package:app_utils/flavor_config.dart';

class ApiDomain {
  static const String baseDomainDev = "https://newsapi.org//"; // dev
  static const String baseDomainProd = "https://newsapi.org//"; // prod
}

class ApiEndPoint {
  static const String apiUrl = "v2/everything/";
  static String baseApiUrl = FlavorConfig().apiBaseDomain + apiUrl;
  static String apiKey = FlavorConfig().apiKey;
}
