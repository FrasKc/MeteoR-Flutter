import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoCityWidget extends StatelessWidget {
  const NoCityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(121, 33, 149, 243),
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pas de ville selectionnée".toUpperCase(),
            style: GoogleFonts.acme(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: const Color.fromARGB(211, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
