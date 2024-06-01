import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/pages/admin/add_game_form.dart';

class AddGameCard extends StatelessWidget {
  final int season;
  const AddGameCard({super.key, required this.season});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return AddGameForm(season: season);
          },
        ));
      },
      child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: LOBColors.secondary,
              width: 1.0,
            ), // Customize the border color and width
          ),
          child: const Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Icon(Icons.add),
          ))),
    );
  }
}
