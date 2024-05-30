import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';
import 'package:lob_app/components/admin/new_team_form.dart';

class AdminAddTeam extends StatelessWidget {
  const AdminAddTeam({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: LOBColors.secondary,
            width: 2.0,
          ), // Customize the border color and width
        ),
        color: LOBColors.secondaryBackGround,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: LOBColors.secondaryBackGround,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return NewTeamForm();
                },
              );
            },
            child: const Center(
              child: Icon(
                Icons.add,
                size: 50,
                color: LOBColors.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
