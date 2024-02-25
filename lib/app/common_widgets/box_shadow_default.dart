import 'package:flutter/material.dart';

BoxShadow defaultBoxShadow() => BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 2, // Increase the blur radius to make the shadow softer
      spreadRadius: 2, // The extent of the shadow
      offset: const Offset(1, 1), // The position of the shadow
    );
