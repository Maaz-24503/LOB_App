import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Helper {
  Helper._internal(); // Private constructor for singleton behavior

  static final Helper _instance = Helper._internal(); // Singleton instance
  
  factory Helper() {
    return _instance;
  }

  Future<T> executeWithInternetCheck<T>(
      BuildContext context, Future<T> Function() asyncFunction) async {
    // Check for internet connectivity
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // If there is internet connectivity, execute the provided async function
      final tbr = await asyncFunction();
      Navigator.pop(context);
      return tbr;
    } else {
      // If there is no internet connectivity, show a SnackBar
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Center(
            child: Text('No Internet Connection'),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      // Return null to indicate that the operation failed due to no internet connection
      return Future.value(null);
    }
  }
}
