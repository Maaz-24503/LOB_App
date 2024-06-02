import 'package:flutter/material.dart';

// const String kTemporaryPath = 'temporaryPath';
// const String kApplicationSupportPath = 'applicationSupportPath';
// const String kDownloadsPath = 'downloadsPath';
// const String kLibraryPath = 'libraryPath';
// const String kApplicationDocumentsPath = 'applicationDocumentsPath';
// const String kExternalCachePath = 'externalCachePath';
// const String kExternalStoragePath = 'externalStoragePath';

class TestHelpers {
  // static Future<void> setupTestLocator() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await setupAppLocator(
  //     environment: Environment.test,
  //     stackedRouter: stackedRouter,
  //   );
  // }

  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Proxima',
      ),
      home: child,
      debugShowCheckedModeBanner: false,
    );
  }
}
