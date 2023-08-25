import 'package:flutter/material.dart';

class PetButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;

  PetButton({required this.imagePath, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350, // Largura ajustável conforme necessário
      height: 150, // Altura ajustável conforme necessário
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Valor de arredondamento
          ),
          padding: EdgeInsets.all(5.0), // Espaçamento interno para ajustar a imagem e o texto
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover
            
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                buttonText,
                style: TextStyle(fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Montserrat',
                 ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
