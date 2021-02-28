import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Row(
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Stations",
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue,
            ),
            width: 50,
            height: 50,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.search),
                iconSize: 30,
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
