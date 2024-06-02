import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lob_app/models/standings.dart';
import 'package:lob_app/pages/admin/admin_season_details.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'util/golden_tookit_helper.dart';

void main() async {
  setUpAll(() async {});

  // Remember this runs before EACH test or group
  setUp(() async {});

  final List<TeamStanding> mockTeams = [
    TeamStanding(
      teamName: 'Team A',
      gamesWon: 8,
      gamesLost: 2,
    ),
    TeamStanding(
      teamName: 'Team B',
      gamesWon: 7,
      gamesLost: 3,
    ),
    TeamStanding(
      teamName: 'Team C',
      gamesWon: 6,
      gamesLost: 4,
    ),
    TeamStanding(
      teamName: 'Team D',
      gamesWon: 5,
      gamesLost: 5,
    ),
    TeamStanding(
      teamName: 'Team E',
      gamesWon: 4,
      gamesLost: 6,
    ),
    TeamStanding(
      teamName: 'Team F',
      gamesWon: 3,
      gamesLost: 7,
    ),
    TeamStanding(
      teamName: 'Team G',
      gamesWon: 2,
      gamesLost: 8,
    ),
    TeamStanding(
      teamName: 'Team H',
      gamesWon: 1,
      gamesLost: 9,
    ),
    TeamStanding(
      teamName: 'Team I',
      gamesWon: 0,
      gamesLost: 10,
    ),
    TeamStanding(
      teamName: 'Team J',
      gamesWon: 9,
      gamesLost: 1,
    ),
  ];

  group('golden integration table page test', () {
    testGoldens('DeviceBuilder - multiple scenarios - with onCreate',
        (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.runAsync(
          () async {
            await tester.pumpDeviceBuilder(
              createGoldenBuilder(
                AdminSeasonDetailsPage(teams: mockTeams, season: 1),
                'admin_season_details_page',
              ),
            );
          },
        );
      });
      await tester.pump(const Duration(seconds: 5));
      await screenMatchesGolden(
        tester,
        'admin_season_details_page_view',
        customPump: (tester) => tester.pump(const Duration(seconds: 2)),
      );
    });
  });
}
