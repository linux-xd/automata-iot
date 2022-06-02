// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class CartHome extends StatefulWidget {
  const CartHome({Key? key}) : super(key: key);

  @override
  State<CartHome> createState() => _CartHomeState();
}

class _CartHomeState extends State<CartHome> {
  List<VoltageDetails> voltage = [];

  Future<String> getJasonFromFirebase() async {
    String url = "https://iot-esp-fa661-default-rtdb.firebaseio.com/data.json";
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  Future loadSalesData() async {
    final String jsonString = await getJasonFromFirebase();
    final dynamic jsonResponse = jsonDecode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      voltage.add(VoltageDetails.fromJson(i));
    }
  }

  @override
  void initState() {
    loadSalesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
                top: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
                left: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
                right: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(138, 237, 246, 1),
                  Color.fromRGBO(96, 162, 245, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: FutureBuilder(
              future: getJasonFromFirebase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return (SfCartesianChart(
                    //backgroundColor: Colors.white,
                    borderWidth: 2,
                    plotAreaBorderWidth: 0.8,
                    borderColor: Colors.transparent,
                    enableAxisAnimation: true,

                    primaryXAxis: CategoryAxis(
                      autoScrollingMode: AutoScrollingMode.start,
                      labelRotation: 270,
                      // title: AxisTitle(
                      //   text: 'days',
                      //   textStyle: const TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.normal,
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ),

                    series: <ChartSeries>[
                      LineSeries<VoltageDetails, String>(
                        dataSource: voltage,
                        xValueMapper: (VoltageDetails details, _) =>
                            details.day,
                        yValueMapper: (VoltageDetails details, _) =>
                            details.voltageCount,
                        color: Colors.black,
                        width: 2,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.auto,
                        ),
                        markerSettings: const MarkerSettings(
                          isVisible: true,
                          height: 10,
                          width: 10,
                          shape: DataMarkerType.circle,
                          borderColor: Colors.black,
                          borderWidth: 2,
                        ),
                      ),
                    ],
                  ));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class VoltageDetails {
  VoltageDetails(this.day, this.voltageCount);
  final String day;
  final int voltageCount;

  factory VoltageDetails.fromJson(Map<String, dynamic> parsedJson) {
    return VoltageDetails(
      parsedJson['day'].toString(),
      parsedJson['voltageCount'],
    );
  }
}
