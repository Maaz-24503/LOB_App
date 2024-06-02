import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'util/local_file_comparator_with_threshold.dart';

// All tests in this folder and its subfolders will have the configuration defined here

/// Customise your threshold here
/// Golden tests will pass if the pixel difference is equal to or below provided threshold in percentage
const _kGoldenTestsThreshold = 1.5 / 100;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      if (goldenFileComparator is LocalFileComparator) {
        final testUrl = (goldenFileComparator as LocalFileComparator).basedir;

        goldenFileComparator = LocalFileComparatorWithThreshold(
          // flutter_test's LocalFileComparator expects the test's URI to be passed
          // as an argument, but it only uses it to parse the baseDir in order to
          // obtain the directory where the golden tests will be placed.
          // As such, we use the default `testUrl`, which is only the `baseDir` and
          // append a generically named `test.dart` so that the `baseDir` is
          // properly extracted.
          Uri.parse('$testUrl/test.dart'),
          _kGoldenTestsThreshold,
        );
      } else {
        throw Exception(
          'Expected `goldenFileComparator` to be of type `LocalFileComparator`, '
          'but it is of type `${goldenFileComparator.runtimeType}`',
        );
      }

      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      // Currently, goldens are not generated/validated in CI for this repo. We have settled on the goldens for this package
      // being captured/validated by developers running on MacOSX. We may revisit this in the future if there is a reason to invest
      // in more sophistication
      skipGoldenAssertion: () => !Platform.isWindows,
      enableRealShadows: true,
    ),
  );
}