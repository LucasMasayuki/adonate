import 'dart:ui';

class CampanhaModel {
  const CampanhaModel(
      {this.nomeCampanha,
      this.dataInicioCampanha,
      this.tag1,
      this.tag2,
      this.corTag1,
      this.corTag2,
      this.shortDesc});
  final String nomeCampanha;
  final DateTime dataInicioCampanha;
  final String shortDesc;
  final String tag1;
  final String tag2;
  final Color corTag1;
  final Color corTag2;
}
