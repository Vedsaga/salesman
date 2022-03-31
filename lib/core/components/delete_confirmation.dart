// flutter import

import 'package:flutter/material.dart';
import 'package:salesman/config/theme/colors.dart';

class DeleteConfirmation extends StatelessWidget {
  const DeleteConfirmation({
    Key? key,
    required this.context, required this.title, required this.message,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 55,
      backgroundColor: AppColors.lightGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      title:  Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.dark,
          fontFamily: 'Montserrat',
        ),
      ),
      content:  Text(
        message,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.grey,
          fontFamily: 'Montserrat',
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'No',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.skyBlue,
              fontFamily: 'Montserrat',
            ),
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        TextButton(
          child: const Text(
            'Remove',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.red,
              fontFamily: 'Montserrat',
            ),
          ),
          onPressed: () {
            Navigator.pop(context, 'remove');
          },
        ),
      ],
    );
  }
}
