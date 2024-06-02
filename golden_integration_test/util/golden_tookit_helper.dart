import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test/test_helpers.dart';

DeviceBuilder createGoldenBuilder(Widget widget, String title) {
  return DeviceBuilder()
    ..overrideDevicesForAllScenarios(
      devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait.copyWith(size: const Size(768, 1024)),
        Device.tabletLandscape,
        const Device(
          name: 'strange_device',
          size: Size(320, 640),
        ),
      ],
    )
    ..addScenario(
      widget: TestHelpers().makeTestableWidget(child: widget),
      name: title,
    );
}


//flutter test .\golden_integration_test\golden_user_home_page_test.dart --update-goldens