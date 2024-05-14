
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/';
  final List<Weather> cities = []; // step 2

  Future<void> weatherReport() async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q': 'Bangladesh',
      'appid': '6d1b70aa32bcff7b1b5c4fa496000b7a',
      'units': 'metric', // Use 'metric' for Celsius
    });

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);


    double temp = jsonData['main']['temp'];
    double windSpeed = jsonData['wind']['speed'];
    String city = jsonData['sys']['country'];


    Weather cityWeather = Weather(temp: temp, wind: windSpeed, country:city);
    cities.add(cityWeather);
  }


  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather'),backgroundColor: Colors.teal,),
      body: SafeArea(
        child: FutureBuilder(
            future: weatherReport(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: cities.length,
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        decoration: BoxDecoration(

                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text('${cities[index].temp.toStringAsFixed(2)} °C'), // Convert double to String
                          subtitle: Text(cities[index].country),// put the api data name
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}