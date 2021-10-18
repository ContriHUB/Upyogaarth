import 'dart:async';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';

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
  CompassEvent? _lastRead ;
  DateTime? _lastReadAt;

  @override
  void initState() {
    super.initState();
     timer=Timer.periodic(Duration(seconds: 2),(Timer t) => compassValue());
    _fetchPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compass'),
      ),
      body: Builder(builder: (context) {
        if (_hasPermissions) {
          return Column(
            children: <Widget>[
              _buildManualReader(),
              Expanded(child: _buildCompass()),
            ],
          );
        } else {
          return _buildPermissionSheet();
        }
      }),
    );
  }

  Widget _buildManualReader() {  
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[     
          Container(
            child: Column(
         mainAxisSize: MainAxisSize.min,
       children:<Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Card(
             margin: const EdgeInsets.all(20.0),
             color: Colors.white,
             child: 
              Container(
               decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 100),
                  border: Border.all(color: Colors.amber,width: 5.0),
                  boxShadow:const [
                      BoxShadow(
                      color: Colors.blue,
                      offset: Offset(5.0,5.0),
                    )]
               ),
               padding: const EdgeInsets.all(5.0),
               child:  Column(
                 mainAxisSize: MainAxisSize.min,
                 mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         if(_lastRead==null) ...[
                         Text(
                    'Last Read: $_lastRead',
                      style: const TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.start,
                    )]
                    else ...[
                      Text(
                      headtoString(_lastRead!) + '°',
                      style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
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
                    ],
                    const SizedBox(height: 5),
                    if(_lastReadAt==null) ...[Text(
                      'Last Read At: $_lastReadAt',
                      style: TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.start,
                    ),]
                    else ...[Text(
                      DateFormat.yMd().format(_lastReadAt!) + '\n' + DateFormat.jms().format(_lastReadAt!),
                      style: TextStyle(fontSize: 12.0),
                      textAlign: TextAlign.start,
                    )
                    ]
                       ],
                     ),),
               ),
          )
       ]
         ),
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

   String headtoString(CompassEvent e){
    int initialDeg = e.heading?.toInt() ?? 0;
    int deg = initialDeg >= 0 ? initialDeg : 360 + initialDeg ;  
    return deg.toString() ;
  }
  String headCamtoString(CompassEvent e){
    return 'CameraMode: ' + e.headingForCameraMode.toString();
  }
  String acctoString(CompassEvent e){
    return 'Accuracy: ' + e.accuracy.toString();
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
