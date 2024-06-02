import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lob_app/pages/get_info.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'util/golden_tookit_helper.dart';

void main() async {
  setUpAll(() async {});

  // Remember this runs before EACH test or group
  setUp(() async {});

  group('golden integration infoPage test', () {
    testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
        (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.runAsync(
          () async {
            await tester.pumpDeviceBuilder(
              createGoldenBuilder(
                InfoPage(),
                'info_page',
              ),
            );
          },
        );
      });
      await tester.pump(const Duration(seconds: 5));
      await screenMatchesGolden(
        tester,
        'info_page_view',
        customPump: (tester) => tester.pump(const Duration(seconds: 2)),
      );
    });
  });
}
