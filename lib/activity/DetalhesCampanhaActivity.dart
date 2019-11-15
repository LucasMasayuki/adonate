import 'dart:async';

import 'package:adonate/campanhas/CampanhaModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalheCampanhaActivity extends StatefulWidget {
  DetalheCampanhaActivity({this.campanha});

  final CampanhaModel campanha;

  @override
  _DetalheCampanhaActivityState createState() =>
      _DetalheCampanhaActivityState();
}

class _DetalheCampanhaActivityState extends State<DetalheCampanhaActivity> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-23.572599, -46.531885),
    zoom: 18.4746,
  );

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd/MM/yyyy");
    String period = 'Desde ${formatter.format(widget.campanha.start)}';

    if (widget.campanha.end != null) {
      period = 'De ${formatter.format(widget.campanha.start)} \nAté ${formatter.format(widget.campanha.end)}';
    }

    final MarkerId markerId = MarkerId('marker_id_0');

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(-23.572599, -46.531885),
      infoWindow:
          InfoWindow(title: widget.campanha.name, snippet: 'ONG'),
    );

    Set<Marker> markers = Set<Marker>();
    markers.add(marker);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(0.0),
              title: Text(
                widget.campanha.name,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
              Container(
                color: Colors.grey[300],
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'ONG X',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Text(
                        period,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.campanha.description,
                        maxLines: 3,
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.blue,
              child: Center(
                  child: Text(
                'Localização',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
            Container(
              height: 300,
              width: 100,
              color: Colors.blue,
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
              color: Colors.blue,
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
                        elevation: 0,
                        child: Icon(Icons.email),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: FloatingActionButton(
                          heroTag: 'call',
                          backgroundColor: Colors.orange,
                          onPressed: _launchCellphone,
                          elevation: 0,
                          child: Icon(Icons.call)),
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
    String url =
        'mailto:ongx@gmail.com?subject=Doação%20para%20${widget.campanha.name}&body=Quero%20doar%20estes%20itens:';
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
