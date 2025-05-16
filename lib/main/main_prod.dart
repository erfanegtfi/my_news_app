import 'package:app_utils/constants.dart';
import 'package:app_utils/flavor_config.dart';
import 'package:data/remote/api_end_points.dart';
import 'package:my_news_app/main/main.dart';

void main() async {
  var appConfig = FlavorConfig();
  appConfig.setApiBaseDomain(ApiDomain.baseDomainProd);
  appConfig.setApiKey(Constants.API_KEY_PROD);
  appConfig.setFlavor(Flavor.prod);

  await appStarter();
}
