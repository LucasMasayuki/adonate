import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:adonate/shared/constants.dart';
import 'package:adonate/campanhas/CampanhaModel.dart';

class DetalheCampanhaActivity extends StatefulWidget {
  DetalheCampanhaActivity({this.campanha});

  final CampanhaModel campanha;

  @override
  _DetalheCampanhaActivityState createState() => _DetalheCampanhaActivityState();
}

class _DetalheCampanhaActivityState extends State<DetalheCampanhaActivity> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd/MM/yyyy");
    String period = 'Desde ${formatter.format(widget.campanha.start)}';

    if (widget.campanha.end != null) {
      period = 'De ${formatter.format(widget.campanha.start)} \nAté ${formatter.format(widget.campanha.end)}';
    }

    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(widget.campanha.lat, widget.campanha.lng),
      zoom: 18.4746,
    );

    final MarkerId markerId = MarkerId('marker_id_0');

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(widget.campanha.lat, widget.campanha.lng),
      infoWindow: InfoWindow(title: widget.campanha.name, snippet: widget.campanha.adonatorName),
    );

    Set<Marker> markers = Set<Marker>();
    markers.add(marker);

    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 160,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                widget.campanha.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
            Card(
              color: Colors.white,
              elevation: 3,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 16),
                    child: Text(
                      period,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    child: Text(
                      'Criado por: ${widget.campanha.adonatorName}',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.campanha.description,
                      maxLines: 3,
                      style: TextStyle(color: Colors.grey)
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              color: primaryColor,
              child: Center(
                child: Text(
                  'Localização',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ),
            ),
            Container(
              height: 300,
              width: 100,
              color: primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GoogleMap(
                  mapType: MapType.terrain,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapToolbarEnabled: true,
                  markers: markers,
                  initialCameraPosition: _kGooglePlex,
                  compassEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 18.0),
              color: primaryColor,
              child: ButtonTheme.bar(
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: FloatingActionButton(
                        heroTag: 'email',
                        backgroundColor: Colors.orange,
                        onPressed: _launchEmail,
                        elevation: 3,
                        child: Icon(Icons.email),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: FloatingActionButton(
                        heroTag: 'call',
                        backgroundColor: Colors.orange,
                        onPressed: _launchCellphone,
                        elevation: 3,
                        child: Icon(Icons.call)
                      ),
                    )
                  ],
                ),
              ),
            )
          ]))
        ],
      ),
    );
  }

  _launchEmail() async {
    String url = 'mailto:${widget.campanha.adonatorEmail}?subject=Doação%20para%20${widget.campanha.name}&body=Quero%20doar%20estes%20itens:';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCellphone() async {
    String url = 'tel:992542757';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
