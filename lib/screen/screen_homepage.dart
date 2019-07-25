import 'package:flutter/material.dart';
import 'package:intive_offices/bloc/locations_bloc.dart';
import 'package:intive_offices/model/socket_event.dart';
import 'package:intive_offices/model/locations.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';


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
          _buildSocketStreamBuilder()
        ],
      ),
    );
  }

  Widget _buildSocketStreamBuilder() {
    return StreamBuilder(
              stream: bloc.channel.stream,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  SocketEvent event = eventFromJson(snapshot.data);
                  if(event.data.isNotEmpty) {
                    List<Location> locations = locationFromJson(event.data);
                    return _buildLocationList(locations);
                  }
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
      title: Text(location.city)
    );
  }
}

/*
Widget _buildStateWidget(BuildContext context, SocketEventState state) {
    if (state.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (state.error) {
      return ScreenError();
    } else if (state.event == null || state.event.isEmpty) {
      return ScreenEmpty();
    } else {
      return Center(child: Text("Here, we will show the locations"));
    }
  }
*/
