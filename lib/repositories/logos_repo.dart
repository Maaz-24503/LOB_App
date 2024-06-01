import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';

class LogosRepo {
  LogosRepo._internal(); // Private constructor for singleton behavior

  static final LogosRepo _instance =
      LogosRepo._internal(); // Singleton instance

  factory LogosRepo() {
    return _instance;
  }

  Future<Map<String, CachedNetworkImage>> getLogosFromFirebase() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection('teams').get();
    Map<String, CachedNetworkImage> toBeReturned = {};
    for (var iter in qs.docs) {
      toBeReturned = {
        iter['name']: CachedNetworkImage(
            imageUrl: iter['namedLogo'],
            placeholder: (context, url) => const CircularProgressIndicator(
                  strokeWidth: 6,
                  color: LOBColors.secondary,
                ),
            errorWidget: (context, url, error) {
              return const Icon(
                Icons.error,
              );
            }),
        ...toBeReturned
      };
    }
    return toBeReturned;
  }
}
