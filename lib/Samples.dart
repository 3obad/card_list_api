import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterlearn/Doctors.dart';
import 'package:http/http.dart' as http;



Future<List<SamStock>> fetchSamples() async {
  final response = await http.get(
      'http://192.168.5.1/flvis/v2/restaurants/fetch_result/fetch_with_restaurant_id.php/?userid=1');

  if (response.statusCode == 200) {
    var ddd = jsonDecode(response.body);

    var doctorObjectList =
    (ddd as List).map((data) => new SamStock.fromJson(data)).toList();
    return doctorObjectList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Samples');
  }
}


class Samples extends StatelessWidget {
  static const routeName = '/extractArguments';
  final Doctors doctors;
  Samples( {Key key, @required this.doctors,} ) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MySamplesList(doctors: doctors,),);
  }
}

class MySamplesList extends StatefulWidget {
  final Doctors doctors;
  MySamplesList( {Key key, @required this.doctors,} ) : super(key: key);
  @override
  _MySamplesListState createState() => _MySamplesListState(doctors);
}

class _MySamplesListState extends State<MySamplesList> {
  Future<List<SamStock>> futureAlbum;
  Doctors doctors;
  _MySamplesListState(this. doctors);


  @override
  void initState() {
    futureAlbum = fetchSamples();

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
          "${doctors.name}",
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
              (BuildContext context, AsyncSnapshot<List<SamStock>> snapshot) {
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
                      Text("${data.quantity}"),
                      Spacer(),
                      Text("${data.note}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MaterialButton(onPressed: () { print("tapped add ${data.name}"); },)
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

