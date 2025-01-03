abstract class FlavorConfig {
  String get name;
  String get baseUrl;
}

class ProdFlavor extends FlavorConfig {
  @override
  String get baseUrl => 'https://jsonplaceholder.typicode.com';

  @override
  String get name => 'PROD';
}

class DevFlavor extends FlavorConfig {
  @override
  String get baseUrl => 'https://jsonplaceholder.typicode.com';

  @override
  String get name => 'DEV';
}

class FlavorHandler {
  static FlavorConfig currFlavor = DevFlavor();
}
