import 'package:flavor/flavor.dart';

import 'bootstrap.dart';

void main() {
  Flavor.create(
    Environment.production,
    properties: {
      Keys.apiUrl: 'http://gutendex.com/',
    },
  );
  bootstrap();
}
