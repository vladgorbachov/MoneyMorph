import 'package:flutter/material.dart';
import '../services/currency_service.dart';
import '../services/location_service.dart';
import '../widgets/glass_container.dart';
import '../widgets/glossy_button.dart';
import '../widgets/three_d_container.dart';
import 'package:geolocator/geolocator.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  List<String> topCurrencies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
  }

  Future<void> _loadCurrencies() async {
    try {
      Position position = await LocationService.determinePosition();
      List<String> currencies = await CurrencyService.getTopCurrencies(position);
      setState(() {
        topCurrencies = currencies;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading currencies: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey[300]!, Colors.grey[100]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ThreeDContainer(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50]!.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GlassContainer(
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.5,
                          ),
                          itemCount: topCurrencies.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white.withOpacity(0.7),
                              child: Center(
                                child: Text(
                                  topCurrencies[index],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GlossyButton(
                    onPressed: _loadCurrencies,
                    child: Center(
                      child: Text(
                        'MM',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}