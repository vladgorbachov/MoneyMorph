import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/currency_converter_screen.dart';
import 'services/currency_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: '.env');

    bool apiAvailable = await CurrencyService.checkApiAvailability();
    if (!apiAvailable) {
      print('API is not available. Please check your internet connection or API key.');
    }
  } catch (e) {
    print('Error loading .env file or checking API availability: $e');
  }

  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const CurrencyConverterScreen(),
    );
  }
}