import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import for Provider
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/pages/user/user_home_page.dart';
import 'package:lob_app/providers/teams_provider.dart'; // Assuming TeamsProvider is here
import 'package:network_image_mock/network_image_mock.dart';

import 'util/golden_tookit_helper.dart';

final mockTeamsProvider = Provider<List<Team>>((ref) {
  // Replace with your desired mock data for teams
  return [
    Team(name: 'Team A', namelessLogo: 'logo.png', namedLogo: 'logo_colored.png'),
    Team(name: 'Team B', namelessLogo: 'logo2.png', namedLogo: 'logo2_colored.png'),
  ];
});

void main() async {
  setUpAll(() async {});

  setUp(() async {});

  group('golden integration UserHomePage test', () {
    testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
        (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.runAsync(
          () async {
            await tester.pumpDeviceBuilder(
              createGoldenBuilder(
                ProviderScope(
                  overrides: [
                    // Correctly override the teamsProvider
                    teamsProvider.overrideWithValue(mockTeamsProvider),
                  ],
                  child: const UserHomePage(),
                ),
                'user_home_path', // Consider renaming for clarity
              ),
            );
          },
        );
      });
      await tester.pump(const Duration(seconds: 5));
      await screenMatchesGolden(
        tester,
        'user_home_page_view', // Ensure filename matches golden file
        customPump: (tester) => tester.pump(const Duration(seconds: 2)),
      );
    });
  });
}
