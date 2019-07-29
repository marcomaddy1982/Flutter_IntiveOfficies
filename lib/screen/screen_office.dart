import 'package:flutter/material.dart';
import 'package:intive_offices/model/office.dart';


class OfficePage extends StatefulWidget {
  final Office office;

  OfficePage(this.office);

  @override
  OfficePageState createState() => OfficePageState();
}

class OfficePageState extends State<OfficePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intive Offices"),
      ),
      body: _buildOfficeDetail()
    );
  }

  Widget _buildOfficeDetail() {
    // return Container();
    return ListView(
        children: <Widget>[
          SizedBox(height: 10),
          _buildImageCarousel(),
          _buildOfficeInfos()
        ],
      );
  }

  Widget _buildImageCarousel() {
    return Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                // Map place = places[index];
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        "https://munichnow.com/wp-content/uploads/2017/03/59628-17082366_304.jpg",
                        width: MediaQuery.of(context).size.width-40,
                        fit: BoxFit.cover
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget _buildOfficeInfos() {
    return ListView(
            padding: EdgeInsets.only(top: 20),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              _buildLocationRow(),
              SizedBox(height: 20),
              _buildPhoneRow(),
              SizedBox(height: 20),
              buildDetailTitle(),
              buildDetailText(),
              SizedBox(height: 10),
            ],
          );
  }

  Widget _buildLocationRow() {
    return Row(
            children: <Widget>[
              SizedBox(width: 20),
              Icon(
                Icons.location_on,
                size: 20,
                color: Colors.black,
              ),
              Expanded(child: 
                Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                          widget.office.address,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          ),
                  ),
                ),
              ],
            );
  }

  Widget _buildPhoneRow() {
      return Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Icon(
                    Icons.phone,
                    size: 20,
                    color: Colors.black,
                  ),
                  Expanded(child: 
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                        child: Text(
                          widget.office.phone,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              );
  }

  Widget buildDetailTitle() {
    return Container(
                padding: EdgeInsets.only(left:20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              );
  }

  Widget buildDetailText() {
    return Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              );
  }
}
