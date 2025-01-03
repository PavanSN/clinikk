import 'package:clinikk/app/app.dart';
import 'package:clinikk/bootstrap.dart';
import 'package:clinikk/flavor_config.dart';

void main() {
  FlavorHandler.currFlavor = ProdFlavor();
  bootstrap(() => const MyApp());
}
