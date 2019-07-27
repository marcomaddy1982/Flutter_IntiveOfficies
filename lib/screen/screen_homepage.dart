import 'package:flutter/material.dart';
import 'package:intive_offices/bloc/locations_bloc.dart';
import 'package:intive_offices/model/locations.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:intive_offices/screen/screen_office.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    var locationsBloc = Injector.getInjector().get<LocationsBloc>();
    return HomePageState(locationsBloc);
  }
}

class HomePageState extends State<HomePage> {
  final LocationsBloc bloc;

  HomePageState(this.bloc) {
    bloc.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intive Offices"),
      ),
      body: Column(
        children: <Widget>[
          _buildLocationsStreamBuilder(),
        ],
      ),
    );
  }

  Widget _buildLocationsStreamBuilder() {
    return StreamBuilder(
              stream: bloc.locations,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                    return _buildLocationList(snapshot.data);
                }
                return Container();
              },
            );
  }

  Widget _buildLocationList(List<Location> locations) {
    return Expanded(
      child: ListView.separated(
        key: Key('locations-list'),
        itemCount: locations.length,
        itemBuilder: (BuildContext ctxt, int index) =>_buildLocationItem(locations[index]),
        separatorBuilder: (context, index) { return Divider(); },
      )
    );
  }

  Widget _buildLocationItem(Location location) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(location.imageUrl)),
      trailing: Icon(Icons.keyboard_arrow_right),
      title: Text(location.city),
      onTap: () { 
          _pushOfficeDetail(location.id);
       }
    );
  }

  void _pushOfficeDetail(String locationId) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OfficePage(locationId)));
  }
}
