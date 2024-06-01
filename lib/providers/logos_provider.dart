import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/repositories/logos_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logos_provider.g.dart';

@riverpod
class Logos extends _$Logos {
  @override
  Future<Map<String, CachedNetworkImage>> build() async =>
      LogosService().getLogos();

  Future<void> add(String teamName, String imgUrl) async {
    final previousState = await future;
    // Mutable the previous list of todos.
    previousState[teamName] = CachedNetworkImage(
        imageUrl: imgUrl,
        placeholder: (context, url) => const CircularProgressIndicator(
              strokeWidth: 6,
              color: LOBColors.secondary,
            ),
        errorWidget: (context, url, error) {
          return const Icon(
            Icons.error,
          );
        });
    // Manually notify listeners.
    ref.notifyListeners();
  }
}

class LogosService {
  final LogosRepo _scheduleRepo = LogosRepo();
  LogosService._internal(); // Private constructor for singleton behavior

  static final LogosService _instance =
      LogosService._internal(); // Singleton instance

  factory LogosService() {
    return _instance;
  }

  Future<Map<String, CachedNetworkImage>> getLogos() async {
    return await _scheduleRepo.getLogosFromFirebase();
  }
}
