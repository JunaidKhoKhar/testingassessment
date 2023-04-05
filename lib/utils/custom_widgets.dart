import 'package:flutter/material.dart';

Widget customSelectionButton({
  required Color borderColor,
  required String title,
  required void Function() onTap
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 3)),
        alignment: Alignment.center,
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
      ),
    ),
  );
}

const listOFBrand = ['Casio', 'SmartWatch', 'Siko'];
