// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ListPickupLocation extends StatefulWidget {
  @override
  _ListPickupLocationState createState() => _ListPickupLocationState();
}

class _ListPickupLocationState extends State<ListPickupLocation> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> Destination = [];
  List<Map<String, dynamic>> filtered_list = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/pickup_location.json');
    final data = await json.decode(response);
    Destination = data.cast<Map<String, dynamic>>();
    setState(() {
      filtered_list = List.from(Destination);
    });
  }

  void _filterSearchResults(String enteredKeyword) {
    List<Map<String, dynamic>> results;
    if (enteredKeyword.isEmpty) {
      results = List.from(Destination);
    } else {
      results = Destination.where((map) {
        return map['location']!
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
                'Choose destination',
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
                        final Destination = filtered_list[index];
                        final bool isExisting = Destination['location']!
                            .toLowerCase()
                            .startsWith(_searchController.text.toLowerCase());

                        return ListTile(
                            title: Text(
                              Destination['location']!,
                              style: TextStyle(
                                backgroundColor: isExisting &&
                                        _searchController.text.isNotEmpty
                                    ? Color.fromARGB(255, 127, 198, 202)
                                        .withOpacity(0.2)
                                    : Colors.transparent,
                              ),
                            ),
                            leading: Icon(Icons.airplanemode_active),
                            // subtitle: Text(Destination['location']!),
                            // trailing: Text(arrivalCity['city']!),'

                            onTap: () async {
                              print(Destination['location']);
                              Navigator.pop(context, {
                                'PickUpLocation': Destination['location'],
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
