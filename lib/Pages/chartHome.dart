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
  List<SalesDetails> sales = [];

  Future<String> getJasonFromFirebase() async {
    String url = "https://iot-esp-fa661-default-rtdb.firebaseio.com/data.json";
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  Future loadSalesData() async {
    final String jsonString = await getJasonFromFirebase();
    final dynamic jsonResponse = jsonDecode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      sales.add(SalesDetails.fromJson(i));
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
            height: 400,
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

                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      LineSeries<SalesDetails, String>(
                        dataSource: sales,
                        xValueMapper: (SalesDetails details, _) =>
                            details.month,
                        yValueMapper: (SalesDetails details, _) =>
                            details.salesCount,
                        color: Colors.black,
                        width: 2,
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

class SalesDetails {
  SalesDetails(this.month, this.salesCount);
  final String month;
  final int salesCount;

  factory SalesDetails.fromJson(Map<String, dynamic> parsedJson) {
    return SalesDetails(
      parsedJson['month'].toString(),
      parsedJson['salesCount'],
    );
  }
}
