import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterlearn/Samples.dart';
import 'package:http/http.dart' as http;

import 'Doctors.dart';


void main() {
  runApp(MyApp());
}

Future<List<Doctors>> fetchDatum() async {
  final response = await http.get(
      'http://192.168.5.1/flvis/v2/restaurants/fetch_result.php/?userarea=0');

  if (response.statusCode == 200) {
    var ddd = jsonDecode(response.body);

    var doctorObjectList =
        (ddd as List).map((data) => new Doctors.fromJson(data)).toList();
    return doctorObjectList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Doctors');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: (settings) {
          // If you push the PassArguments route
          if (settings.name == Samples.routeName) {
            // Cast the arguments to the correct type: ScreenArguments.
            final Doctors args = settings.arguments;

            // Then, extract the required data from the arguments and
            // pass the data to the correct screen.
            return MaterialPageRoute(
              builder: (context) {
                return Samples(

                  doctors: args,
                );
              },
            );
          }
          // The code only supports PassArgumentsScreen.routeName right now.
          // Other values need to be implemented if we add them. The assertion
          // here will help remind us of that higher up in the call stack, since
          // this assertion would otherwise fire somewhere in the framework.
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
        title: 'Navigation with Arguments',

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Doctors>> futureAlbum;
  List<Doctors> _userDetails = [];
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    futureAlbum = fetchDatum();
    futureAlbum.then((result) {
      setState(() => _userDetails.addAll(result));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: false,
        shape: ContinuousRectangleBorder(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(80.0),
          ),
        ),
        automaticallyImplyLeading: true,
        title: Text(
          "first",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        elevation: 18,
      ),
      drawer: DrawerHeader(
        child: Text("ff"),
      ),
      body: Container(
        child: FutureBuilder(
          future: futureAlbum,
          builder:
              (BuildContext context, AsyncSnapshot<List<Doctors>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return card(snapshot.data[i]);
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget card(data) {
    return Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 6,
      child: new InkWell(
        onTap: () {
          print("tapped ${data.name}");
          Navigator.pushNamed(
            context,
            Samples.routeName,
            arguments:  data,);
        },
        child: Flex(direction: Axis.horizontal, children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${data.id}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.red.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        "${data.name}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.red.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("${data.spi}"),
                      Spacer(),
                      Text("${data.clas}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("${data.area}"),
                      Spacer(),
                      Text("${data.address}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
