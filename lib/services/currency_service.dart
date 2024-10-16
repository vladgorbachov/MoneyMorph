import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyService {
  static Future<double> getExchangeRate(String from, String to) async {
    final response = await http.get(
      Uri.parse('https://v6.exchangerate-api.com/v6/YOUR_API_KEY/latest/$from'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['conversion_rates'][to];
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }
}
