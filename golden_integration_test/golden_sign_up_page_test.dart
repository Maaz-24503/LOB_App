import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lob_app/pages/signup.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'util/golden_tookit_helper.dart';

void main() async {
  setUpAll(() async {});

  // Remember this runs before EACH test or group
  setUp(() async {});

  group('golden integration signUp test', () {
    testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
        (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.runAsync(
          () async {
            await tester.pumpDeviceBuilder(
              createGoldenBuilder(
                Signup(),
                'signup_page',
              ),
            );
          },
        );
      });
      await tester.pump(const Duration(seconds: 5));
      await screenMatchesGolden(
        tester,
        'signup_page_view',
        customPump: (tester) => tester.pump(const Duration(seconds: 2)),
      );
    });
  });
}
