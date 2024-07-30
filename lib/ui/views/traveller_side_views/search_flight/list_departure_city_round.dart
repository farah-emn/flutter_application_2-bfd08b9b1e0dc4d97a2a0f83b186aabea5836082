// // ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ListDepartureCityRound extends StatefulWidget {
  @override
  _ListDepartureCityRoundState createState() => _ListDepartureCityRoundState();
}

class _ListDepartureCityRoundState extends State<ListDepartureCityRound> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> DepartureCity = [];
  List<Map<String, dynamic>> filtered_list = [];
  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/departure_city.json');
    final data = await json.decode(response);
    DepartureCity = data.cast<Map<String, dynamic>>();
    setState(() {
      filtered_list = List.from(DepartureCity);
    });
  }

  void _filterSearchResults(String enteredKeyword) {
    List<Map<String, dynamic>> results;
    if (enteredKeyword.isEmpty) {
      results = List.from(DepartureCity);
    } else {
      results = DepartureCity.where((map) {
        return map['DepartureCity']!
            .toLowerCase()
            .startsWith(enteredKeyword.toLowerCase());
      }).toList();
    }

    setState(() {
      filtered_list = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: Text(
                'Search Origin',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20, right: 15, left: 15),
                child: Container(
                  height: 50,
                  child: TextField(
                    onChanged: _filterSearchResults,
                    controller: _searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 237, 241, 244),
                      hintText: 'Where are you flying from?',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                )),
            Expanded(
              child: filtered_list.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filtered_list.length,
                      itemBuilder: (context, index) {
                        final DepartureCity = filtered_list[index];
                        final bool isExisting = DepartureCity['DepartureCity']!
                            .toLowerCase()
                            .startsWith(_searchController.text.toLowerCase());

                        return ListTile(
                            title: Text(
                              DepartureCity['DepartureCity']!,
                              style: TextStyle(
                                backgroundColor: isExisting &&
                                        _searchController.text.isNotEmpty
                                    ? Color.fromARGB(255, 127, 198, 202)
                                        .withOpacity(0.2)
                                    : Colors.transparent,
                              ),
                            ),
                            leading: Icon(Icons.airplanemode_active),
                            subtitle: Text(DepartureCity['airport']!),
                            trailing: Text(DepartureCity['city']!),
                            onTap: () async {
                              final Departurecity =
                                  DepartureCity['DepartureCity'];
                              Navigator.pop(context, {
                                'DepartureCity': Departurecity,
                              });
                            });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
