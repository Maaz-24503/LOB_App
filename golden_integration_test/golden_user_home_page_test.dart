import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import for Provider
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lob_app/models/team.dart';
import 'package:lob_app/pages/user/user_home_page.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'util/golden_tookit_helper.dart';

// Mock data for teams
final List<Team> mockTeams = [
  Team(name: 'Team A', namelessLogo: 'logo.png', namedLogo: 'logo_colored.png'),
  Team(
      name: 'Team B',
      namelessLogo: 'logo2.png',
      namedLogo: 'logo2_colored.png'),
];

// Custom mock provider
final mockTeamsProvider = StateProvider<List<Team>>((ref) => mockTeams);

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
                const ProviderScope(
                  child: UserHomePage(),
                ),
                'user_home_page', // Consider renaming for clarity
              ),
            );

            // Assertions for UserHomePage
            expect(find.text('Team A'),
                findsOneWidget); // Assert team name presence
            expect(find.text('Team B'),
                findsOneWidget); // Assert another team name
            // Add more assertions based on your UI elements and data
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
