
import 'package:flutter_test/flutter_test.dart';
import 'package:lob_app/pages/game_keeper.dart';

void main() {
  group('GameKeeperPageState Unit Tests', () {
    late GameKeeperPageState pageState;

    setUp(() {
      pageState = GameKeeperPageState();
    });

    test('Initial values are correct', () {
      expect(pageState.team1Score, 0);
      expect(pageState.team2Score, 0);
      expect(pageState.shotClockSeconds, 24);
      expect(pageState.quarterSeconds, 600);
      expect(pageState.currentQuarter, 1);
    });

    test('Increment and decrement team scores', () {
      pageState.incrementTeam1Score();
      expect(pageState.team1Score, 1);

      pageState.decrementTeam1Score();
      expect(pageState.team1Score, 0);

      pageState.incrementTeam2Score();
      expect(pageState.team2Score, 1);

      pageState.decrementTeam2Score();
      expect(pageState.team2Score, 0);
    });

    test('Reset shot clock', () {
      pageState.shotClockSeconds = 10;
      pageState.resetShotClock();
      expect(pageState.shotClockSeconds, 24);
    });

    test('Reset quarter clock', () {
      pageState.quarterSeconds = 100;
      pageState.shotClockSeconds = 10;
      pageState.resetQuarterClock();
      expect(pageState.quarterSeconds, 600);
      expect(pageState.shotClockSeconds, 24);
    });

    test('Next and previous quarters', () {
      pageState.goToNextQuarter();
      expect(pageState.currentQuarter, 2);

      pageState.goToPreviousQuarter();
      expect(pageState.currentQuarter, 1);
    });

    test('Format time correctly', () {
      expect(pageState.formatTime(600), '10:00');
      expect(pageState.formatTime(65), '01:05');
      expect(pageState.formatTime(0), '00:00');
    });
  });
}
