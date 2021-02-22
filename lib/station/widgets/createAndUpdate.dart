import 'package:addis_teller_app/station/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddAndUpdateField extends StatefulWidget {
  AddAndUpdateField({@required this.edit, this.station});
  final bool edit;
  final Station station;

  @override
  _AddAndUpdateFieldState createState() => _AddAndUpdateFieldState();
}

class _AddAndUpdateFieldState extends State<AddAndUpdateField> {
  List<Station> _selectedStations = [];

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> newStation = {"stations": []};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
              initialValue: widget.edit ? widget.station.name : '',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter course code';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'name'),
              onSaved: (value) {
                setState(() {
                  newStation["name"] = value;
                });
              }),
          TextFormField(
              initialValue: widget.edit ? widget.station.latLong : '',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter staion\'s latLong';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'latLong'),
              onSaved: (value) {
                setState(() {
                  newStation["latLong"] = value;
                });
              }),
          BlocBuilder<StationBloc, StationState>(builder: (_, state) {
            if (state is StationsLoadSuccess) {
              List<Station> _stations = state.stations;
              final _items = _stations
                  .map((station) =>
                      MultiSelectItem<Station>(station, station.name))
                  .toList();
              return MultiSelectDialogField(
                items: _items,
                title: Text("Stations"),
                selectedColor: Colors.blue,
                searchable: true,
                buttonIcon: Icon(
                  Icons.car_rental,
                ),
                buttonText: Text(
                  "Add Stations",
                ),
                onConfirm: (results) {
                  _selectedStations = results;
                  results.forEach((element) {
                    print(results);
                    newStation["stations"].add(element.id);
                  });
                },
              );
            }
            return CircularProgressIndicator();
          }),
          // TextFormField(
          //     initialValue: widget.edit
          //         ? widget.station.postStations
          //         : '',
          //     validator: (value) {
          //       if (value.isEmpty) {
          //         return 'Please enter course ects';
          //       }
          //       return null;
          //     },
          //     decoration: InputDecoration(labelText: 'Course ECTS'),
          //     onSaved: (value) {
          //       setState(() {
          //         this._station["ects"] = int.parse(value);
          //       });
          //     }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                print("newStation=> $newStation");
                final form = _formKey.currentState;
                if (form.validate()) {
                  form.save();
                  final StationEvent event = widget.edit
                      ? StationUpdate(
                          Station(
                              id: widget.station.id,
                              name: newStation["name"],
                              latLong: newStation["latLong"],
                              stations: newStation["stations"]),
                        )
                      : StationCreate(
                          Station(
                              name: newStation["name"],
                              latLong: newStation["latLong"],
                              stations: newStation["stations"]),
                        );
                  BlocProvider.of<StationBloc>(context).add(event);
                  Navigator.pop(context);
                }
              },
              label: Text('SAVE'),
              icon: Icon(Icons.save),
            ),
          ),
        ],
      ),
    );
  }
}
