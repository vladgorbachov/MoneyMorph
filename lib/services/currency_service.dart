import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

class CurrencyService {
  static String get _exchangeRateApiKey => dotenv.env['EXCHANGE_RATE_API_KEY'] ?? '';

  static Future<bool> checkApiAvailability() async {
    try {
      final response = await http.get(
        Uri.parse('https://v6.exchangerate-api.com/v6/$_exchangeRateApiKey/latest/USD'),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error checking API availability: $e');
      return false;
    }
  }

  static Future<List<String>> getTopCurrencies(Position position) async {
    // First, get the country code based on the position
    final String countryCode = await _getCountryCode(position);

    // Then, get the local currency for that country
    final String localCurrency = await _getLocalCurrency(countryCode);

    // Now, fetch exchange rates with the local currency as base
    final response = await http.get(
      Uri.parse('https://v6.exchangerate-api.com/v6/$_exchangeRateApiKey/latest/$localCurrency'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rates = data['conversion_rates'] as Map<String, dynamic>;

      // Sort currencies by exchange rate
      var sortedCurrencies = rates.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));

      // Ensure the local currency is included and at the top of the list
      sortedCurrencies.removeWhere((element) => element.key == localCurrency);
      sortedCurrencies.insert(0, MapEntry(localCurrency, 1.0));

      // Return top 15 currencies (3 columns x 5 rows)
      return sortedCurrencies.take(15).map((e) => e.key).toList();
    } else {
      throw Exception('Failed to load currencies');
    }
  }

  static Future<String> _getCountryCode(Position position) async {
    final response = await http.get(
      Uri.parse('https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${position.latitude}&longitude=${position.longitude}&localityLanguage=en'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['countryCode'];
    } else {
      throw Exception('Failed to get country code');
    }
  }

  static Future<String> _getLocalCurrency(String countryCode) async {
    final response = await http.get(
      Uri.parse('https://restcountries.com/v3.1/alpha/$countryCode'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data[0]['currencies'].keys.first;
    } else {
      throw Exception('Failed to get local currency');
    }
  }
}