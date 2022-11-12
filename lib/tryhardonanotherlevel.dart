import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/secondpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //   home:  Container(
      //     constraints: BoxConstraints.expand(),
      //     decoration: const BoxDecoration(
      //       image: DecorationImage(
      //           image:  AssetImage('image/background1.jpeg'),
      //           fit: BoxFit.cover),
      //     ),
      //     child: MyHomePage(),
      //  ),
      home : MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String city = "";
  final _citycon = TextEditingController();

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
            "Weather App",
            style: TextStyle(
                fontSize: 30, color: Colors.white),
          ),
        ),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 400, vertical: 16),
                    child: TextField(
                      style: TextStyle(color: Colors.white70),
                      controller: _citycon,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: Colors.deepPurpleAccent,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white70)
                          ),
                          hoverColor: Colors.deepPurpleAccent,
                          hintText: 'Enter city',
                          hintStyle: TextStyle(color: Colors.white70)
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: () {
                    setState(() {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> SecondPage(city: city)));

                      city = _citycon.text;

                      print("city: " + city);
                    });

                  }, child: Text("Search", style: TextStyle(
                      fontSize: 15, color: Colors.white70),))
                ],
              )
            ],
          ),
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


