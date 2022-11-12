import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class SecondPage extends StatefulWidget {
  SecondPage({required this.city});

  String city;

  @override
  State<SecondPage> createState() => _SecondPageState();
}



class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('image/background1.jpeg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Results",
            style: TextStyle(
                fontSize: 30, color: Colors.white),
          ),
        ),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [FutureBuilder(future: apicall(widget.city),
                builder: (context, snapshot){
              if (snapshot.hasData) {
                return Column(
                  children: [

                    Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(snapshot.data["description"].toString(), style: TextStyle(color: Colors.white70)),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text("Temperature: "+ snapshot.data["temp"].toString()+ " degrees Celcius", style: TextStyle(color: Colors.white70),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text("Feels like: "+ snapshot.data["feelslike"].toString()+ " degrees Celcius", style: TextStyle(color: Colors.white70)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text("Minimum: " +snapshot.data["min"].toString()+ " degrees Celcius", style: TextStyle(color: Colors.white70)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text("Maximum: "+ snapshot.data["max"].toString()+ " degrees Celcius", style: TextStyle(color: Colors.white70)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text("Pressure: " +snapshot.data["pressure"].toString(), style: TextStyle(color: Colors.white70)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text("Humidity: " +snapshot.data["humidity"].toString(), style: TextStyle(color: Colors.white70)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text("wind speed: "+snapshot.data["windspd"].toString(), style: TextStyle(color: Colors.white70)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text("Direction of wind: "+snapshot.data["winddir"].toString()+" degrees with respect to North", style: TextStyle(color: Colors.white70)),
                    ),

                  ],
                );
               } else { return
                Text("");
               }

                }
            )



                ],
              )

          ),
        ),
      );

  }
}
Future apicall(city) async {
  final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q="+city+"&appid=8875a46932e3e98fc148dabdac8af3ff");
  final response = await http.get(url);
  print(response.body);
  final json = jsonDecode(response.body);
  print(json["weather"][0]["main"]);

  final output = {
    'windspd': json["wind"]['speed'],
    'winddir':json["wind"]['deg'],
    'description': json["weather"][0]['description'],
    'temp': json["main"]['temp'] - 273,
    'feelslike': json["main"]['feels_like'] - 273,
    'min': json["main"]['temp_min'] - 273,
    'max': (json["main"]['temp_max'] - 273),
    'pressure': json["main"]['pressure'],
    'humidity': json["main"]['humidity']

  };
  return output;
}
