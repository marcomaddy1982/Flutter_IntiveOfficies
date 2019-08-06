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
              itemCount: widget.office.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        "http://localhost:8080/offices/" + widget.office.images[index],
                        width: widget.office.images.length > 1 
                        ? MediaQuery.of(context).size.width-40 
                        : MediaQuery.of(context).size.width-20,
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
              _buildEmailRow(),
              SizedBox(height: 20),
              _buildPhoneRow(),
              SizedBox(height: 20),
              _buildEmployeesRow(),
              SizedBox(height: 20),
              _buildDetailTitle(),
              _buildDetailText(),
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

  Widget _buildEmailRow() {
      return Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Icon(
                    Icons.email,
                    size: 20,
                    color: Colors.black,
                  ),
                  Expanded(child: 
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                        child: Text(
                          widget.office.email,
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

  Widget _buildEmployeesRow() {
      return Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Icon(
                    Icons.people,
                    size: 20,
                    color: Colors.black,
                  ),
                  Expanded(child: 
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                        child: Text(
                          widget.office.employeesNumber.toString(),
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

  Widget _buildDetailTitle() {
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

  Widget _buildDetailText() {
    return Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.office.description,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.left,
                ),
              );
  }
}
