import 'package:flutter/material.dart';

class CurrencyConverterScreen extends StatelessWidget {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final knobSize = 306.0; // Уменьшено на 15% от предыдущего размера (360)
    final screenHeight = 400.0;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Positioned(
            top: screenSize.height * 0.10, // Сдвинуто на 15% вниз по вертикали
            left: 0, // Заполняет весь экран по горизонтали
            right: 0, // Заполняет весь экран по горизонтали
            child: Container(
              height: screenHeight,
              decoration: BoxDecoration(
                color: Colors.blue[50], // Бледно-голубой фон
                border: Border.all(color: Colors.black, width: 2), // Черная рамка
              ),
            ),
          ),
          Positioned(
            bottom: screenSize.height * 0.05, // Сдвинуто вниз на 10% (было 0.1, стало 0.05)
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: knobSize,
                height: knobSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200], // Простой серый фон
                  border: Border.all(color: Colors.black, width: 2), // Черная рамка
                ),
                child: Center(
                  child: Icon(
                    Icons.power_settings_new,
                    size: knobSize * 0.25,
                    color: Colors.blue[400],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}