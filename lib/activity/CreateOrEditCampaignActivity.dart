import 'dart:convert';
import 'dart:io';
import 'package:adonate/shared/wigdets/tag_dropdowns.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:adonate/model/CampaignModel.dart';
import 'package:adonate/shared/api.dart';
import 'package:adonate/shared/constants.dart';
import 'package:adonate/shared/wigdets/raised_gradient_button.dart';

import 'CampaignActivity.dart';

class CreateOrEditCampaignActivity extends StatefulWidget {
  const CreateOrEditCampaignActivity({required this.campaign});

  final CampaignModel? campaign;

  @override
  CreateOrEditCampaignActivityState createState() =>
      CreateOrEditCampaignActivityState();
}

class CreateOrEditCampaignActivityState
    extends State<CreateOrEditCampaignActivity> {
  late TextEditingController _nameController;
  late TextEditingController _startController;
  late TextEditingController _endController;
  late TextEditingController _descriptionController;
  late TextEditingController _zipcodeController;
  late TextEditingController _streetController;
  late TextEditingController _numberController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;

  final formatter = DateFormat("dd/MM/yyyy");
  final pageController = PageController(initialPage: 0);
  final scrollDirection = Axis.horizontal;

  var steps;
  var defaultPurpouseTagValue;
  var defaultItemTypeTagValue;

  var basicInformationStepState = StepState.editing;
  var extraInformationStepState = StepState.indexed;
  var addressStepState = StepState.indexed;

  int currentStep = 0;
  File? _image;

  @override
  void initState() {
    _nameController = TextEditingController(
        text: widget.campaign != null ? widget.campaign!.name : null);

    _startController = TextEditingController(
        text: widget.campaign?.start != null
            ? formatter.format(widget.campaign!.start)
            : null);

    _endController = TextEditingController(
        text: widget.campaign?.end != null
            ? formatter.format(widget.campaign!.end!)
            : null);

    _descriptionController = TextEditingController(
        text: widget.campaign != null ? widget.campaign?.description : null);

    _zipcodeController = TextEditingController(
        text: widget.campaign != null
            ? widget.campaign!.zipcode.toString()
            : null);

    _streetController = TextEditingController(
        text: widget.campaign != null ? widget.campaign!.street : null);

    _numberController = TextEditingController(
        text: widget.campaign != null
            ? widget.campaign!.number.toString()
            : null);

    _cityController = TextEditingController(
        text: widget.campaign != null ? widget.campaign!.city : null);

    _stateController = TextEditingController(
        text: widget.campaign != null ? widget.campaign!.state : null);

    defaultPurpouseTagValue =
        widget.campaign != null ? widget.campaign!.purposeTagName : null;
    defaultItemTypeTagValue =
        widget.campaign != null ? widget.campaign!.itemTypeTagName : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    steps = getSteps();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 4,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          widget.campaign != null
              ? 'Editar ${widget.campaign!.name}'
              : 'Adicionar campanha',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: primaryColor,
      body: _builderStep(),
    );
  }

  Widget getPlaceHolder() {
    var photoUrl = widget.campaign != null ? widget.campaign!.photoUrl : null;
    if ((photoUrl == null || photoUrl == "") && _image == null) {
      return SizedBox(
        height: 120,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Card(
                color: Colors.grey,
                child: Center(
                  child: Text('Selecione uma imagem'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return FittedBox(
      fit: BoxFit.fill,
      child: Card(color: Colors.grey, child: returnPhotoOfFileOrUrl()),
    );
  }

  Widget _returnImageOfcampaign() {
    var placeholder = getPlaceHolder();
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            "Imagem da campanha",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: _getImage,
          child: placeholder,
        )
      ],
    );
  }

  Widget returnPhotoOfFileOrUrl() {
    if (widget.campaign!.photoUrl != "" && _image == null) {
      return CachedNetworkImage(
        imageUrl: widget.campaign!.photoUrl ?? '',
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.image),
      );
    }

    return Image.file(_image!);
  }

  _getImage() async {
    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 100, maxWidth: 200);

    setState(() {
      _image = image as File?;
    });
  }

  getSteps() => [
        Step(
          title: Text("Informações básicas"),
          state: basicInformationStepState,
          content: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black38),
                    labelText: 'Nome da campanha',
                  ),
                  controller: _nameController,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MaskTextInputFormatter(mask: '##/##/####')
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Inicio',
                          labelStyle: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                        controller: _startController,
                        style: TextStyle(fontSize: 14),
                      ),
                    )),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '##/##/####')
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Fim',
                        labelStyle: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                      controller: _endController,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  maxLength: 255,
                  minLines: 3,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descrição',
                    labelStyle: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                  controller: _descriptionController,
                ),
              ),
            ],
          ),
        ),
        Step(
          state: extraInformationStepState,
          title: Text("Informações adicionais"),
          content: Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: <Widget>[
                  _returnImageOfcampaign(),
                  Column(children: <Widget>[
                    ListTile(
                      title: Text(
                        "Tags da campanha",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: Api.getRequest('tags'),
                        builder: (
                          context,
                          AsyncSnapshot<Response> projectSnap,
                        ) {
                          if (projectSnap.connectionState ==
                                  ConnectionState.none &&
                              projectSnap.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          var statusCode;
                          if (!projectSnap.hasData ||
                              projectSnap.data!.statusCode != 200) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          Map<String, dynamic> body = jsonDecode(
                            utf8.decode(projectSnap.data!.bodyBytes),
                          );

                          var tags = body.entries.toList()[3].value;

                          return TagDropdowns(
                            reference: this,
                            tags: tags,
                            defaultPurpouseTagValue: defaultPurpouseTagValue,
                            defaultItemTypeTagValue: defaultItemTypeTagValue,
                          );
                        })
                  ])
                ],
              )),
        ),
        Step(
          state: addressStepState,
          title: Text("Endereço"),
          content: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      color: Colors.black38,
                    ),
                    labelText: 'Rua',
                  ),
                  controller: _streetController,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MaskTextInputFormatter(mask: '########')
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CEP',
                          labelStyle: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                        controller: _zipcodeController,
                        style: TextStyle(fontSize: 14),
                      ),
                    )),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Número',
                        labelStyle: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                      controller: _numberController,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ]),
              Row(children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextField(
                        maxLength: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Cidade',
                          labelStyle: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                        controller: _cityController,
                        style: TextStyle(fontSize: 14),
                      ),
                    )),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextField(
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Estado',
                        labelStyle: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                      controller: _stateController,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ];

  Widget _builderStep() => Container(
        color: Colors.white,
        child: Stepper(
          type: StepperType.vertical,
          steps: steps,
          currentStep: currentStep,
          onStepTapped: (step) => goTo(step),
          controlsBuilder:
              (BuildContext context, ControlsDetails controlsDetails) {
            var cancelLabel = 'Voltar';
            var nextLabel = 'Continuar';
            var paddingCancelButton = defaultPaddingRaisedButtonFormSecondary;
            var paddingNextButton = EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 12.0, top: 12.0);

            if (currentStep == 0) {
              cancelLabel = 'Cancelar';
              paddingCancelButton = EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 12.0, top: 12.0);
            }

            if (currentStep == steps.length - 1) {
              nextLabel = 'Salvar';
              paddingNextButton = defaultPaddingRaisedButtonFormSecondary;
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: RaisedGradientButton(
                    child: Text(
                      cancelLabel,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    gradient: LinearGradient(colors: <Color>[
                      gradientOfCancelButtonPrimary,
                      gradientOfCancelButtonSecondary
                    ]),
                    onPressed: () => cancel(),
                    padding: paddingCancelButton,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: RaisedGradientButton(
                    child: Text(
                      nextLabel,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[
                        primaryGradientColorButton,
                        secondaryGradientColorButton,
                      ],
                    ),
                    onPressed: () => currentStep + 1 != steps.length
                        ? goTo(currentStep + 1)
                        : showProgress(context),
                    padding: paddingNextButton,
                  ),
                ),
              ],
            );
          },
        ),
      );

  formatDate(date) {
    var split = date.split('/');
    return split[2] + '-' + split[1] + '-' + split[0];
  }

  formatImage() {
    if (_image == null) {
      return null;
    }

    String base64Image = base64Encode(_image!.readAsBytesSync());
    String fileName = _image!.path.split("/").last;

    return {
      "img_name": fileName,
      "encoded_img": base64Image,
    };
  }

  save() async {
    bool isValid = validateAddressStep();
    if (!isValid) {
      setState(() => addressStepState = StepState.error);
      return;
    }

    Map data = {
      "campaign": {
        "id": widget.campaign != null ? widget.campaign!.campaignId : null,
        "name": _nameController.text,
        "start": formatDate(_startController.text),
        "end": formatDate(_endController.text),
        "description": _descriptionController.text,
      },
      "tags": {
        "purpouse": defaultPurpouseTagValue,
        "item_type": defaultItemTypeTagValue
      },
      "address": {
        "zipcode": _zipcodeController.text,
        "state": _stateController.text,
        "city": _cityController.text,
        "number": _numberController.text,
        "street": _streetController.text,
      },
      "photo": formatImage()
    };

    var response;

    if (widget.campaign == null) {
      response = await Api.putRequest('save_campaign', data: json.encode(data));
    } else {
      response =
          await Api.postRequest('save_campaign', data: json.encode(data));
    }

    if (response.statusCode != 200) {
      return response;
    }

    int indexOfTab = 1;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CampaignActivity(
          passedIndex: indexOfTab,
        ),
      ),
    );

    return response;
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    } else {
      Navigator.pop(context);
    }
  }

  goTo(int step) {
    bool isValid = false;
    switch (currentStep) {
      case 0:
        isValid = validateBasicInformationStep();
        if (!isValid) {
          setState(() => basicInformationStepState = StepState.error);
          return;
        }

        break;

      case 1:
        isValid = validateExtraInformationStep();
        if (!isValid) {
          setState(() => extraInformationStepState = StepState.error);
          return;
        }

        break;
    }

    setState(() {
      switch (currentStep) {
        case 0:
          basicInformationStepState = StepState.complete;
          break;

        case 1:
          extraInformationStepState = StepState.complete;
          break;
      }

      switch (step) {
        case 0:
          basicInformationStepState = StepState.editing;
          break;

        case 1:
          extraInformationStepState = StepState.editing;
          break;

        case 2:
          addressStepState = StepState.editing;
          break;
      }

      currentStep = step;
    });
  }

  validateBasicInformationStep() {
    String name = _nameController.text;
    String start = _startController.text;
    String end = _endController.text;

    bool isValid = name != "" && start != "" && end != "";
    return isValid;
  }

  validateExtraInformationStep() {
    String? porpouse = defaultPurpouseTagValue;
    String? itemType = defaultItemTypeTagValue;

    bool isValid = porpouse != null && itemType != null;
    return isValid;
  }

  validateAddressStep() {
    String zipcode = _zipcodeController.text;
    String street = _streetController.text;
    String number = _numberController.text;
    String city = _cityController.text;
    String state = _stateController.text;

    bool isValid = zipcode != "" &&
        street != "" &&
        number != "" &&
        city != "" &&
        state != "";
    return isValid;
  }

  Future<void> showProgress(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        save(),
        message: Text('Salvando campainha...'),
      ),
    );
    showResultDialog(context, result);
  }

  void showResultDialog(BuildContext context, Response response) {
    if (response.statusCode == 500) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Algo deu errado"),
          content: Text("Tente novamente mais tarde"),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
