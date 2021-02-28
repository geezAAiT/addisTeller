import 'package:addis_teller_app/main.dart';
import 'package:addis_teller_app/post/bloc/bloc.dart';
import 'package:addis_teller_app/post/post.dart';
import 'package:addis_teller_app/station/screens/homepage.dart';
import 'package:addis_teller_app/station/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StationDetail extends StatefulWidget {
  StationDetail({this.station});
  final Station station;
  static String routeName = '/detailPage';

  @override
  _StationDetailState createState() => _StationDetailState();
}

class _StationDetailState extends State<StationDetail> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> post = {};
  final _kTabs = <Tab>[
    const Tab(icon: Icon(Icons.cloud), text: 'Tab1'),
    const Tab(icon: Icon(Icons.alarm), text: 'Tab2'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: _kTabs,
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Hero(
                        tag: widget.station.id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                          child: Image(
                            image: AssetImage('images/hotel0.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            iconSize: 30.0,
                            color: Colors.black,
                            onPressed: () => Navigator.pop(context),
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.search),
                                iconSize: 30.0,
                                color: Colors.black,
                                onPressed: () => Navigator.pop(context),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                iconSize: 25.0,
                                color: Colors.black,
                                onPressed: () {
                                  BlocProvider.of<StationBloc>(context)
                                      .add(StationDelete(this.widget.station));
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      Homepage.routeName, (route) => false);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      bottom: 20.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.station.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.station.latLong,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                              Icon(
                                Icons.location_city,
                                size: 20.0,
                                color: Colors.black,
                              ),
                              // SizedBox(width: 5.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 20.0,
                      bottom: 20.0,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white70,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                    itemCount: widget.station.stations.length,
                    itemBuilder: (BuildContext context, int index) {
                      final childStation = this.widget.station.stations[index];
                      return Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                            height: 150.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(80.0, 20.0, 20.0, 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 90.0,
                                        child: Text(
                                          childStation["name"],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            '${childStation["stations"].length}',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    childStation["latLong"],
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(5.0),
                                        width: 65.0,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'lorem ipsum',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Container(
                                        padding: EdgeInsets.all(5.0),
                                        width: 65.0,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "lorem",
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20.0,
                            top: 15.0,
                            bottom: 15.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image(
                                width: 90.0,
                                height: 40,
                                image: AssetImage(
                                  'images/hotel1.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          autofocus: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter course code';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'name'),
                          onSaved: (value) {
                            setState(() {
                              post["body"] = value;
                            });
                          }),
                      ElevatedButton.icon(
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            final PostEvent event = PostCreate(
                                Post(
                                  body: post["body"],
                                ),
                                this.widget.station.id);

                            BlocProvider.of<PostBloc>(context).add(event);
                          }
                        },
                        label: Text('SAVE'),
                        icon: Icon(Icons.save),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                  if (state is PostLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is StationPostsLoadSuccess) {
                    final posts = state.stationPosts;
                    print("ther user id is $userID");
                    return Column(
                        children: List.generate(
                            posts.length,
                            (index) => SingleChildScrollView(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      child: Icon(
                                          Icons.picture_in_picture_outlined),
                                    ),
                                    title: Text("${posts[index].user["name"]}"),
                                    subtitle: Text("${posts[index].body}"),
                                    trailing: posts[index].user["_id"] == userID
                                        ? PopupMenuButton(
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          BlocProvider.of<
                                                                      PostBloc>(
                                                                  context)
                                                              .add(PostDelete(
                                                                  post: posts[
                                                                      index],
                                                                  stationID: this
                                                                      .widget
                                                                      .station
                                                                      .id));
                                                        },
                                                        child: Text("delete"))),
                                                PopupMenuItem(
                                                    child: GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) =>
                                                            Text("DS"));
                                                  },
                                                  child: Text("ed"),
                                                ))
                                              ];
                                            },
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                )));
                  } else if (state is PostOperationFailure) {
                    return Text(state.message);
                  }
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
