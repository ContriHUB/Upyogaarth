import 'dart:async';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upyogaarth/main.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CompassScreenAnimation extends StatelessWidget {
  const CompassScreenAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showAlert(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Compass"),
      ),
      body: const Center(
        child: Text("demo text"),
      ),
    );
  }

  void showAlert(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CompassScreen()));
      },
    );

    showDialog(
        context: context,
        builder: (BuildContext buildContext) => AlertDialog(
              title: Text(
                'Compass Calibration',
                textAlign: TextAlign.center,
              ),
              contentPadding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
              content: Container(
                child: Image.asset(
                  'assets/calibrate.gif',
                  height: 300.0,
                  width: 300.0,
                ),
              ),
              actions: [okButton],
            ));
  }
}

class CompassScreen extends StatefulWidget {
  const CompassScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CompassScreenState createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  bool _hasPermissions = false;
  late Timer timer;
  CompassEvent? _lastRead;
  DateTime? _lastReadAt;

  List<double>? _accelerometerValues;
  List<double>? _magnetometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  late double roll=0.0, pitch=0.0, yaw=0.0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => compassValue());
    _fetchPermissionStatus();

    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );

    _streamSubscriptions.add(
      magnetometerEvents.listen(
        (MagnetometerEvent event) {
          setState(() {
            _magnetometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }

  void updateCompassValues() {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final magnetometer =
        _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    if(_accelerometerValues!=null) {
      double ax = _accelerometerValues!.elementAt(0);
      double ay = _accelerometerValues!.elementAt(1);
      double az = _accelerometerValues!.elementAt(2);
      roll = 180 * math.atan2(ax, math.sqrt(ay * ay + az * az)) / math.pi;
      pitch = 180 * math.atan2(ay, math.sqrt(ax * ax + az * az)) / math.pi;
    }

    if(_magnetometerValues!=null) {
      double magReadX = _magnetometerValues!.elementAt(0);
      double magReadY = _magnetometerValues!.elementAt(1);
      double magReadZ = _magnetometerValues!.elementAt(2);

      yaw = math.atan2(magReadY, magReadX);
      yaw = yaw * (180 / math.pi);
      yaw = yaw + 90;
      yaw = (yaw + 360) % 360;
      yaw = yaw - 180;
    }

    pitch = pitch * -1;
    roll = roll * -1;
  }

  @override
  Widget build(BuildContext context) {
    updateCompassValues();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const MyApp())),
        ),
        title: const Text('Compass'),
      ),
      body: Builder(builder: (context) {
        if (_hasPermissions) {
          if (MediaQuery.of(context).orientation == Orientation.landscape) {
            return Row(
              children: <Widget>[
                Expanded(child: _buildCompass()),
                _buildManualReader(0.3, 0.5),
              ],
            );
          }
          return Column(
            children: <Widget>[
              _buildManualReader(0.7, 0.26),
              Expanded(child: _buildCompass()),
            ],
          );
        } else {
          return _buildPermissionSheet();
        }
      }),
    );
  }

  Widget _buildManualReader(double w, double h) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * w,
                height: MediaQuery.of(context).size.height * h,
                child: Card(
                  margin: const EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 100),
                        border: Border.all(color: Colors.amber, width: 5.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.blue,
                            offset: Offset(5.0, 5.0),
                          )
                        ]),
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_lastRead == null) ...[
                          Text(
                            'Last Read: $_lastRead',
                            style: const TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.start,
                          )
                        ] else ...[
                          Text(
                            headtoString(_lastRead!) + '°',
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            headCamtoString(_lastRead!) + '°',
                            style: TextStyle(fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            acctoString(_lastRead!) + '°',
                            style: TextStyle(fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                          //to be edited from here
                          const SizedBox(height: 5),
                          Text(
                            azitoString() + '°',
                            style: TextStyle(fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            pitchtoString() + '°',
                            style: TextStyle(fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            rolltoString() + '°',
                            style: TextStyle(fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                        const SizedBox(height: 5),
                        if (_lastReadAt == null) ...[
                          Text(
                            'Last Read At: $_lastReadAt',
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.start,
                          ),
                        ] else ...[
                          Text(
                            DateFormat.yMd().format(_lastReadAt!) +
                                '\n' +
                                DateFormat.jms().format(_lastReadAt!),
                            style: TextStyle(fontSize: 12.0),
                            textAlign: TextAlign.start,
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }

        return Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Transform.rotate(
              angle: (direction * (math.pi / 180) * -1),
              child: Image.asset('assets/gold_compass.png'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Location Permission Required'),
          ElevatedButton(
            child: const Text('Request Permissions'),
            onPressed: () {
              Permission.locationWhenInUse.request().then((ignored) {
                _fetchPermissionStatus();
              });
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Open App Settings'),
            onPressed: () {
              openAppSettings().then((opened) {
                //
              });
            },
          )
        ],
      ),
    );
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }

  String headtoString(CompassEvent e) {
    int initialDeg = e.heading?.toInt() ?? 0;
    int deg = initialDeg >= 0 ? initialDeg : 360 + initialDeg;
    return deg.toString();
  }

  String headCamtoString(CompassEvent e) {
    return 'CameraMode: ' + e.headingForCameraMode.toString();
  }

  String acctoString(CompassEvent e) {
    return 'Accuracy: ' + e.accuracy.toString();
  }

  String azitoString() {
    return 'Azimuth: ' + yaw.toString();
  }

  String pitchtoString() {
    return 'Pitch: ' + pitch.toString();
  }

  String rolltoString() {
    return 'Roll: '+ roll.toString();
  }

  Future<void> compassValue() async {
    final CompassEvent tmp = await FlutterCompass.events!.first;
    setState(() {
      _lastRead = tmp;
      _lastReadAt = DateTime.now();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
