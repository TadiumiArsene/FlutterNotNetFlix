import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color forColor;
  const ActionButton(
      {Key? key,
      required this.label,
      required this.icon,
      required this.bgColor,
      required this.forColor})
      : super(key: key);

  get kBackgroundColor => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context)
          .size
          .width, //pour prendre toute la largeur de l'ecran.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: bgColor,
      ), //pour definir la bordure du containeur
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //pour centrer mon row et son contenu
        children: [
          Icon(
            icon,
            color: forColor,
          ),
          const SizedBox(
            height: 5,
          ), //pour separrer l'icon et le text
          Text(
            label,
            style: GoogleFonts.poppins(
              color: forColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
