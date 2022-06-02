// ignore_for_file: file_names
import 'package:automata/Pages/chartHome.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final database = FirebaseDatabase.instance.ref();
  String _tempText = "0";
  String _humidText = "0";

  var linear = const BoxDecoration(
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
  );

  var buttonColor = const Color.fromRGBO(240, 249, 255, 1);

  @override
  void initState() {
    super.initState();
    _activatelistners();
  }

  void _activatelistners() {
    database.child("DTH/Temperature").onValue.listen((event) {
      setState(() {
        _tempText = event.snapshot.value.toString();
      });
    });
    database.child("DTH/Humidity").onValue.listen((event) {
      setState(() {
        _humidText = event.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final acRef = database.child("AC_STATUS/");
    final fanRef = database.child("FAN_STATUS/");
    final lightRef = database.child("LED_STATUS/");
    final fridgeRef = database.child("FRIDGE_STATUS/");

    return Scaffold(
      backgroundColor: buttonColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromRGBO(145, 143, 222, 1),
            expandedHeight: 200,
            floating: false,
            pinned: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              side: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                //color: Colors.deepPurple[300],
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(145, 143, 222, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              title: const Text(
                "A U T O M A T A - I O T",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //items01
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 150,
                  decoration: linear,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VxCircle(
                        radius: 100,
                        backgroundColor: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        child: LottieBuilder.asset('assets/lightbulb.json'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              lightRef
                                  .set(
                                    {
                                      "LED_STATUS": 1,
                                    },
                                  )
                                  .then(
                                    (_) => print("Value has been set"),
                                  )
                                  .catchError(
                                    (error) =>
                                        print("you have an error! $error"),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: buttonColor,
                              onPrimary: Colors.black,
                              enableFeedback: true,
                              elevation: 10,
                              shadowColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            child: "Light ON".text.black.xl.make(),
                          ),
                          const HeightBox(10),
                          ElevatedButton(
                            onPressed: () {
                              lightRef
                                  .set(
                                    {
                                      "LED_STATUS": 0,
                                    },
                                  )
                                  .then(
                                    (_) => print("Value has been set"),
                                  )
                                  .catchError(
                                    (error) =>
                                        print("you have an error! $error"),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: buttonColor,
                              onPrimary: Colors.black,
                              enableFeedback: true,
                              elevation: 10,
                              shadowColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            child: "Light OFF".text.black.xl.make(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //items02
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 150,
                  decoration: linear,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VxCircle(
                        radius: 100,
                        backgroundColor: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        child: LottieBuilder.asset('assets/fan.json'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              fanRef
                                  .set(
                                    {
                                      "FAN_STATUS": 1,
                                    },
                                  )
                                  .then(
                                    (_) => print("Value has been set"),
                                  )
                                  .catchError(
                                    (error) =>
                                        print("you have an error! $error"),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: buttonColor,
                              elevation: 10,
                              onPrimary: Colors.black,
                              enableFeedback: true,
                              shadowColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            child: "Fan ON".text.black.xl.make(),
                          ),
                          const HeightBox(10),
                          ElevatedButton(
                            onPressed: () {
                              fanRef
                                  .set(
                                    {
                                      "FAN_STATUS": 0,
                                    },
                                  )
                                  .then(
                                    (_) => print("Value has been set"),
                                  )
                                  .catchError(
                                    (error) =>
                                        print("you have an error! $error"),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: buttonColor,
                              elevation: 10,
                              onPrimary: Colors.black,
                              enableFeedback: true,
                              shadowColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            child: "Fan OFF".text.black.xl.make(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //items03
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 150,
                  decoration: linear,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VxCircle(
                        radius: 100,
                        backgroundColor: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                        child: LottieBuilder.asset(
                          'assets/cooler.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                      // backgroundImage: const DecorationImage(
                      //   image: NetworkImage(
                      //     "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                      //   ),
                      //   fit: BoxFit.fill,
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              acRef
                                  .set(
                                    {
                                      "AC_STATUS": 1,
                                    },
                                  )
                                  .then(
                                    (_) => print("Value has been set"),
                                  )
                                  .catchError(
                                    (error) =>
                                        print("you have an error! $error"),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: buttonColor,
                              elevation: 10,
                              onPrimary: Colors.black,
                              enableFeedback: true,
                              shadowColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            child: "AC ON".text.black.xl.make(),
                          ),
                          const HeightBox(10),
                          ElevatedButton(
                            onPressed: () {
                              acRef
                                  .set(
                                    {
                                      "AC_STATUS": 0,
                                    },
                                  )
                                  .then(
                                    (_) => print("Value has been set"),
                                  )
                                  .catchError(
                                    (error) =>
                                        print("you have an error! $error"),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: buttonColor,
                              elevation: 10,
                              onPrimary: Colors.black,
                              enableFeedback: true,
                              shadowColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            child: "AC OFF".text.black.xl.make(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //item04
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 150,
                  decoration: linear,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VxCircle(
                        radius: 100,
                        backgroundColor: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        backgroundImage: const DecorationImage(
                          image: AssetImage('assets/fridge.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              fridgeRef
                                  .set(
                                    {
                                      "FRIDGE_STATUS": 1,
                                    },
                                  )
                                  .then(
                                    (_) => print("Value has been set"),
                                  )
                                  .catchError(
                                    (error) =>
                                        print("you have an error! $error"),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: buttonColor,
                              elevation: 10,
                              onPrimary: Colors.black,
                              enableFeedback: true,
                              shadowColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            child: "Fridge ON".text.black.xl.make(),
                          ),
                          const HeightBox(10),
                          ElevatedButton(
                            onPressed: () {
                              fridgeRef
                                  .set(
                                    {
                                      "FRIDGE_STATUS": 0,
                                    },
                                  )
                                  .then(
                                    (_) => print("Value has been set"),
                                  )
                                  .catchError(
                                    (error) =>
                                        print("you have an error! $error"),
                                  );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: buttonColor,
                              elevation: 10,
                              onPrimary: Colors.black,
                              enableFeedback: true,
                              shadowColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            child: "Fridge OFF".text.black.xl.make(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //item05
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 250,
                  decoration: linear,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 210,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(145, 143, 222, 50),
                          borderRadius: BorderRadius.circular(20),
                          border: const Border(
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
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              VxCircle(
                                radius: 80,
                                backgroundColor: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                child: LottieBuilder.asset(
                                    'assets/temperature.json'),
                              ),
                              Text(
                                "Temperature:\n \t$_tempText",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ).centered(),
                              const HeightBox(10),
                              ElevatedButton(
                                onPressed: () {
                                  _activatelistners();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: buttonColor,
                                  elevation: 10,
                                  onPrimary: Colors.black,
                                  enableFeedback: true,
                                  shadowColor: buttonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                child: "Update".text.black.xl.make(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 210,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(145, 143, 222, 50),
                          borderRadius: BorderRadius.circular(20),
                          border: const Border(
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
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              VxCircle(
                                radius: 80,
                                backgroundColor: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                backgroundImage: const DecorationImage(
                                  image: AssetImage(
                                    "assets/humidity.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                "Humidity:\n\t$_humidText",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ).centered(),
                              const HeightBox(10),
                              ElevatedButton(
                                onPressed: () {
                                  _activatelistners();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: buttonColor,
                                  elevation: 10,
                                  onPrimary: Colors.black,
                                  enableFeedback: true,
                                  shadowColor: buttonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                child: "Update".text.black.xl.make(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //item06

        ],
      ),
    );
  }
}
