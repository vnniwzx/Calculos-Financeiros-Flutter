import 'package:flutter/material.dart';
 
 Widget campoTexto({
    required String label,
    required TextEditingController controller,
    bool senha = false,
    TextInputType tipo = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,  vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: senha,
        keyboardType: tipo,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
