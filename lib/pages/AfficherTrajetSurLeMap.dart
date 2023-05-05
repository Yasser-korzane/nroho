import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AfficherTrajetSurLeMap extends StatefulWidget {
  final LatLng origin;
  final LatLng destination;
  AfficherTrajetSurLeMap(this.origin, this.destination);

  @override
  State<AfficherTrajetSurLeMap> createState() => _AfficherTrajetSurLeMapState();
}

class _AfficherTrajetSurLeMapState extends State<AfficherTrajetSurLeMap> {
  late GoogleMapController mapController;
  late PolylinePoints polylinePoints;
  Set<Polyline> _polylineSet = {};
  List<LatLng> polylineCoordinates = [];
  Set<Marker> _markerSet = {};

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    setPolylines(widget.origin, widget.destination);
  }

  void setPolylines(LatLng depart, LatLng arrive) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyC9sGlH43GL0Jer73n9ETKsxNpZqvrWn-k",
        PointLatLng(depart.latitude, depart.longitude),
        PointLatLng(arrive.latitude, arrive.longitude));
    for (var element in result.points) {
      polylineCoordinates.add(LatLng(element.latitude, element.longitude));
    }
    setState(() {
      _polylineSet.add(Polyline(
          polylineId: const PolylineId("Route"),
          points: polylineCoordinates,
          color: Colors.black,
          width: 8,)
      );
      _polylineSet.add(Polyline(
        polylineId: PolylineId("background"),
        points: polylineCoordinates,
        color: Colors.blue,
        width: 6,
      ));
      _markerSet.add(Marker(  // Add a marker for depart
        markerId: MarkerId('depart'),
        position: depart,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: 'Depart',
        ),
      ));
      _markerSet.add(Marker(  // Add a marker for arrive
        markerId: MarkerId('arrive'),
        position: arrive,
        infoWindow: InfoWindow(
          title: 'Arrive',
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Le trajet sur le Map'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()=> Navigator.pop(context),
        ),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        polylines: _polylineSet,markers: _markerSet,
        initialCameraPosition: CameraPosition(
          target: widget.origin,
          zoom: 11.0,
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.25,
        ),
      ),
    );
  }
}
