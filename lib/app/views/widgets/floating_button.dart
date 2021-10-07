import 'package:batiturbo_erp/app/utils/theme_data.dart';
import 'package:batiturbo_erp/app/views/widgets/base_widgets/base_widgets.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  const FloatingButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        onPressed: onPressed,
        color: color_dark_blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: color_white),
            addHorizontalSpace(10),
            Text(text, style: TextStyle(color: color_white))
          ],
        ),
      ),
    );
  }
}
