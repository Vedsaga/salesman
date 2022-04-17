// flutter import

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:salesman/config/theme/colors.dart';
import 'package:salesman/config/theme/theme.dart';

class DeleteConfirmation extends StatelessWidget {
  const DeleteConfirmation({
    Key? key,
    required this.context,
    required this.title,
    required this.message,
    required this.textYes,
    required this.textNo,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final String message;
  final String textYes;
  final String textNo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 55,
      backgroundColor: lightGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      title:  Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: dark,
          fontFamily: 'Montserrat',
        ),
      ),
      content:  Text(
        message,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: grey,
          fontFamily: 'Montserrat',
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            textNo,
            style: of(context).textTheme.overline?.copyWith(
                  color: skyBlue,
                  fontWeight: FontWeight.bold,
                ),
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        TextButton(
          child: Text(
            textYes,
            style: of(context).textTheme.overline?.copyWith(
                  color: red,
                  fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, textYes);
          },
        ),
      ],
    );
  }
}
