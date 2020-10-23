import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_maps/backend/markers.dart';
import 'package:google_maps/screens/mainPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  final int userId;
  Home({Key key, this.userId}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer _mapcontroller = Completer();
  Set<Marker> gmarkers = Set<Marker>();
  int mid = 0;
  bool show = false;

  var markerLen = 0;

  Future getMarkers() async {
    var markers = await MarkerDb().getMarkers(widget.userId);
    markerLen = markers.length;
    for (var marker in markers) {
      gmarkers.add(
        Marker(
            markerId: MarkerId(marker.id.toString()),
            draggable: true,
            position: LatLng(marker.latitude, marker.longitude),
            // consumeTapEvents: true,
            infoWindow: InfoWindow(
                title: "Mark ${marker.id}", snippet: "This place is beautiful"),
            onDragEnd: (latlng) async {
              await MarkerDb()
                  .updateMarker(latlng.latitude, latlng.longitude, marker.id);
            },
            onTap: () {
              setState(() {
                show = true;  
                mid = marker.id;
              });
            }),
      );
    }
    return markers;
  }

  CameraPosition initPosition = CameraPosition(
    target: LatLng(15.834536, 78.029366),
    zoom: 7,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMarkers(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    trafficEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: initPosition,
                    markers: gmarkers,
                    onMapCreated: (GoogleMapController controller) {
                      _mapcontroller.complete(controller);
                    },
                    onTap: (latlng) async {
                      var id = await MarkerDb().addMarker(
                          latlng.latitude, latlng.longitude, widget.userId);
                      gmarkers.add(
                        Marker(
                            markerId: MarkerId("$id"),
                            draggable: true,
                            position: latlng,
                            consumeTapEvents: true,
                            infoWindow: InfoWindow(title: "Sreehari"),
                            onDragEnd: (latlng) {},
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Confirm"),
                                    content: Text("Are you sure to delete."),
                                    actions: [
                                      FlatButton(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("OK"),
                                        onPressed: () async {
                                          gmarkers.removeWhere((element) =>
                                              element.markerId.value ==
                                              id.toString());
                                          setState(() {});
                                          // print(gmarkers);
                                          await MarkerDb()
                                              .deleteMarker(id);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                      );
                      markerLen = markerLen + 1;
                      setState(() {});
                    },
                  ),
                ),
                Positioned(
                  top: 50.0,
                  right: 10.0,
                  // child: Icon(Icons.exit_to_app,size: 30.0,)
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 5.0,
                              spreadRadius: 2.0)
                        ]),
                    child: IconButton(
                        icon: Icon(
                          Icons.exit_to_app,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MainPage()));
                        }),
                  ),
                ),
                Positioned(
                  bottom: 100.0,
                  right: 10.0,
                  // child: Icon(Icons.exit_to_app,size: 30.0,)
                  child: show ? Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 5.0,
                              spreadRadius: 2.0)
                        ]),
                    child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Confirm"),
                                content: Text("Are you sure to delete. $mid"),
                                actions: [
                                  FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () async {
                                      gmarkers.removeWhere((element) =>
                                          element.markerId.value == mid.toString());
                                      setState(() {});
                                      // print(gmarkers);
                                      await MarkerDb().deleteMarker(mid);
                                      Navigator.of(context).pop();
                                      mid = 0;
                                      show = false;
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }),
                  ) :Container(),
                )
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
