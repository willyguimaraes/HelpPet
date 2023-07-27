import 'package:flutter/material.dart';

class VetButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const VetButton({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 60, 
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
           ), // Valor de arredondamento
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
