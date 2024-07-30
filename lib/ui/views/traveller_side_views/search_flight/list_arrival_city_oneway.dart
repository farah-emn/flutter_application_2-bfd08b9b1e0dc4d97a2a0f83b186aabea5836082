// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ListCityArrivalOneWay extends StatefulWidget {
  @override
  _ListCityArrivalOneWayState createState() => _ListCityArrivalOneWayState();
}

class _ListCityArrivalOneWayState extends State<ListCityArrivalOneWay> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> arrivalCity = [];
  List<Map<String, dynamic>> filtered_list = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/arrival_city.json');
    final data = await json.decode(response);
    arrivalCity = data.cast<Map<String, dynamic>>();
    setState(() {
      filtered_list = List.from(arrivalCity);
    });
  }

  void _filterSearchResults(String enteredKeyword) {
    List<Map<String, dynamic>> results;
    if (enteredKeyword.isEmpty) {
      results = List.from(arrivalCity);
    } else {
      results = arrivalCity.where((map) {
        return map['ArrivalCity']!
            .toLowerCase()
            .startsWith(enteredKeyword.toLowerCase());
      }).toList();
    }

    setState(() {
      filtered_list = results;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
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
                        final arrivalCity = filtered_list[index];
                        final bool isExisting = arrivalCity['ArrivalCity']!
                            .toLowerCase()
                            .startsWith(_searchController.text.toLowerCase());

                        return ListTile(
                            title: Text(
                              arrivalCity['ArrivalCity']!,
                              style: TextStyle(
                                backgroundColor: isExisting &&
                                        _searchController.text.isNotEmpty
                                    ? Color.fromARGB(255, 127, 198, 202)
                                        .withOpacity(0.2)
                                    : Colors.transparent,
                              ),
                            ),
                            leading: Icon(Icons.airplanemode_active),
                            subtitle: Text(arrivalCity['airport']!),
                            trailing: Text(arrivalCity['city']!),
                            onTap: () async {
                              final ArivalCiry = arrivalCity['ArrivalCity'];
                              Navigator.pop(context, {
                                'ArrivalCity': ArivalCiry,
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
