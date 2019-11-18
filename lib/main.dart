import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timezone/standalone.dart' as standalone;
import 'package:timezone/timezone.dart';

void main() async {
  var byteData = await rootBundle.load('packages/timezone/data/2019b.tzf');
  initializeDatabase(byteData.buffer.asUint8List());
  runApp(MaterialApp(theme: ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black
  ),
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  String currentLocation;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> listOfTimeZones = [];

  @override
  void initState() {
    print('hey');
    setup();
    // TODO: implement initState
    super.initState();
  }

  Future<void> setup() async {
    Map map = standalone.timeZoneDatabase.locations;
    map.forEach((key, value) => listOfTimeZones.add(value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(left: 46.0, right: 8, top: 64, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Select time zone',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 30.0, right: 8, top: 24, bottom: 0),
              child: ListTile(
                onTap: () async {
                  widget.currentLocation = await showSearch(
                    context: context,
                    delegate: SearchTimeZones(timeZones: listOfTimeZones),
                  );
                  setState(() {});
                },
                title: Text(
                  'Region',
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
                subtitle: Text(
                  widget.currentLocation == null
                      ? 'Asia/Calcutta'
                      : '${widget.currentLocation}',
                  style: TextStyle(color: Color(0xFF7D7D7D), fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchTimeZones extends SearchDelegate<String> {
  List<String> timeZones;

  SearchTimeZones({this.timeZones});

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          close(context, null);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return Icon(Icons.search);
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<String> suggestion = timeZones
        .where((zone) => zone.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          color: Colors.black,
          child: ListTile(
            title: Text(
              suggestion[index],
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              close(context, suggestion[index]);
            },
          ),
        );
      },
      itemCount: suggestion.length,
      shrinkWrap: true,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestion = timeZones
        .where((zone) => zone.toLowerCase().contains(query.toLowerCase()))
        .toList();
    // TODO: implement buildSuggestions
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              suggestion[index],
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              close(context, suggestion[index]);
            },
          ),
        );
      },
      itemCount: suggestion.length,
      shrinkWrap: true,
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.black,

    );
  }
}
