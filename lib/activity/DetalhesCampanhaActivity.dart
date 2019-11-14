import 'dart:async';

import 'package:adonate/campanhas/CampanhaModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd/MM/yyyy h:mm a");
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.campanha.nomeCampanha),
              background: Container(
                color: Colors.blue,
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text(
                      formatter.format(widget.campanha.dataInicioCampanha),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.campanha.shortDesc,
                      maxLines: 3,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Scaffold(
              body: Container(
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
          ]))
        ],
      ),
    );
  }

  final children = [];
}
