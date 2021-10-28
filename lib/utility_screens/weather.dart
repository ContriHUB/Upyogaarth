import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/weather.dart';
import 'package:location/location.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String apiKey;
  late WeatherFactory ws;
  List<Weather> _data = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  double? lat, lon;
  String? city;
  bool searchByCity=false;
  final latController = TextEditingController();
  final longController = TextEditingController();
  final cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiKey = dotenv.env["OPENWEATHERMAP_API_KEY"] ?? 'nothing';
    ws = WeatherFactory(apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Weather"),
      ),
      body: apiKey == "nothing"
          ? const Center(child: Text("API key not provided"))
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _cityInput(),
                  _coordinateInputs(),
                  _buttons(),
                  const Text(
                    'Output:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Divider(
                    height: 20.0,
                    thickness: 2.0,
                  ),
                  Flexible(child: _resultView())
                ],
              ),
            ),
    );
  }

  void queryForecast() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    List<Weather> forecasts;

    if(!searchByCity) {
      forecasts = await ws.fiveDayForecastByLocation(lat!, lon!);
    }
    else{
      searchByCity=false;
      forecasts = await ws.fiveDayForecastByCityName(city!);
    }

    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  void queryWeather() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather;

    if(!searchByCity){
      weather = await ws.currentWeatherByLocation(lat!, lon!);
    }
    else {
      searchByCity=false;
      weather = await ws.currentWeatherByCityName(city!);
    }

    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });

  }

  Widget contentFinishedDownload() {
    return Center(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_data[index].toString()),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  Widget contentDownloading() {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(children: [
        const Text(
          'Fetching Weather...',
          style: TextStyle(fontSize: 20),
        ),
        Container(
            margin: const EdgeInsets.only(top: 50),
            child:
                const Center(child: CircularProgressIndicator(strokeWidth: 10)))
      ]),
    );
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'Press the button to download the Weather forecast',
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
          ? contentDownloading()
          : contentNotDownloaded();

  void _saveLat(String input) {
    lat = double.tryParse(input);
    print(lat);
  }

  void _saveLon(String input) {
    lon = double.tryParse(input);
    print(lon);
  }

  void _saveCity(String input) {
    searchByCity = true;
    city = input;
    print(city);
  }

  Widget _coordinateInputs() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
              child: TextField(
                controller: latController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter latitude'),
                  keyboardType: TextInputType.number,
                  onChanged: _saveLat,
                  onSubmitted: _saveLat)),
        ),
        Expanded(
            child: Container(
                margin: const EdgeInsets.all(5),
                child: TextField(
                  controller: longController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter longitude'),
                    keyboardType: TextInputType.number,
                    onChanged: _saveLon,
                    onSubmitted: _saveLon))),
        ElevatedButton(
            onPressed: () async {
              cityController.text='';
              latController.text='';
              longController.text='';

              Location location = Location();
              bool _serviceEnabled = await location.serviceEnabled();
              if (!_serviceEnabled) {
                _serviceEnabled = await location.requestService();
              }
              if (_serviceEnabled) {
                PermissionStatus _permissionGranted =
                    await location.hasPermission();
                //print(_permissionGranted);
                if (_permissionGranted == PermissionStatus.denied) {
                  _permissionGranted = await location.requestPermission();
                }
                //print(_permissionGranted);
                if (_permissionGranted == PermissionStatus.granted) {
                  LocationData _locationData = await location.getLocation();
                  lat = _locationData.latitude;
                  lon = _locationData.longitude;
                  print(lat);
                  print(lon);
                }
              }
            },
            child: const Text("Get current location"))
      ],
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(5),
          child: TextButton(
              child: const Text('Fetch weather'), onPressed: queryWeather),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: TextButton(
              child: const Text('Fetch forecast'), onPressed: queryForecast),
        ),
      ],
    );
  }

  Widget _cityInput() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                controller: cityController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter city name'),
                  keyboardType: TextInputType.text,
                  onChanged: _saveCity,
                  onSubmitted: _saveCity)),
        ),
      ],
    );
  }

}
