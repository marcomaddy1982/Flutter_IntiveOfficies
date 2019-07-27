import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intive_offices/bloc/office_bloc.dart';
import 'package:intive_offices/model/office.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intive_offices/model/office.dart' as prefix0;

class OfficePage extends StatefulWidget {
  final String locationId;

  OfficePage(this.locationId);

  @override
  State<StatefulWidget> createState() {
    var officeBloc = Injector.getInjector().get<OfficeBloc>();
    return OfficePageState(officeBloc, locationId);
  }
}

class OfficePageState extends State<OfficePage> {
  final String locationId;
  final OfficeBloc bloc;

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  OfficePageState(this.bloc, this.locationId) {
    bloc.start(locationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intive Offices"),
      ),
      body: Column(
        children: <Widget>[
          _buildOfficeStreamBuilder(),
        ],
      ),
    );
  }

  Widget _buildOfficeStreamBuilder() {
    return StreamBuilder(
              stream: bloc.office,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                    LatLng position = _buildOfficePosition(snapshot.data);
                    List<Marker> markers = _buildOfficeMarker(snapshot.data);
                    return _buildMap(position, markers);
                }
                return Container();
              },
            );
  }

  Widget _buildMap(LatLng position, List<Marker> markers) {
    return Expanded(
      child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: position,
                zoom: 11.0,
              ),
              markers: Set<Marker>.of(markers),
      ));
  }

  LatLng _buildOfficePosition(Office office) {
   return LatLng(double.parse(office.lat), double.parse(office.long));
  }

  List<Marker> _buildOfficeMarker(Office office) {
    return  [Marker(
      markerId: MarkerId("selectedOffice"),
      position: _buildOfficePosition(office),
      infoWindow: InfoWindow(title: office.address),
      onTap: () {
        
      },
    )];
  }
}