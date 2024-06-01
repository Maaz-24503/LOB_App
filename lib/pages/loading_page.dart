import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';

class TranslucentPage extends StatelessWidget {
  const TranslucentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          const Center(
            child: CircularProgressIndicator(color: LOBColors.secondary,),
          ),
        ],
      ),
    );
  }
}
