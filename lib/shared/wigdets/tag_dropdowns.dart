import 'package:adonate/model/TagModel.dart';
import 'package:flutter/material.dart';

class TagDropdowns extends StatefulWidget {
  const TagDropdowns({
    this.reference,
    required this.tags,
    this.defaultPurpouseTagValue,
    this.defaultItemTypeTagValue,
  });

  final reference;
  final List<TagModel> tags;
  final defaultPurpouseTagValue;
  final defaultItemTypeTagValue;

  @override
  TagDropdownsState createState() => TagDropdownsState();
}

class TagDropdownsState extends State<TagDropdowns> {
  late String? _purposeTag;
  late String? _typeItemTag;
  var purposeTagList;
  var itemTypeTagList;

  @override
  void initState() {
    _purposeTag = widget.defaultPurpouseTagValue;
    _typeItemTag = widget.defaultItemTypeTagValue;

    purposeTagList = widget.tags
        .where((value) => value.tag_type == "PURPOSE")
        .map<DropdownMenuItem<String>>((value) {
      var dropdownMenuItem = DropdownMenuItem<String>(
        value: value.name,
        child: Text(value.name ?? ''),
      );
      return dropdownMenuItem;
    }).toList();

    itemTypeTagList = widget.tags
        .where((value) => value.tag_type == "ITEM")
        .map<DropdownMenuItem<String>>(
      (value) {
        var dropdownMenuItem = DropdownMenuItem<String>(
          value: value.name,
          child: Text(value.name ?? ''),
        );
        return dropdownMenuItem;
      },
    ).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        flex: 4,
        child: Center(
          child: DropdownButton(
            hint: Text(
              'O que doar',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            style: TextStyle(fontSize: 12, color: Colors.black),
            items: itemTypeTagList,
            value: _typeItemTag,
            onChanged: (String? value) {
              _typeItemTag = value!;
              setState(() {
                _typeItemTag = value;
                widget.reference.defaultItemTypeTagValue = value;
              });
            },
          ),
        ),
      ),
      Expanded(
        flex: 4,
        child: Center(
          child: DropdownButton(
            hint: Text('Destino',
                style: TextStyle(fontSize: 12, color: Colors.black)),
            style: TextStyle(fontSize: 12, color: Colors.black),
            items: purposeTagList,
            value: _purposeTag,
            onChanged: (String? value) {
              _purposeTag = value!;
              setState(
                () {
                  _purposeTag = value;
                  widget.reference.defaultPurpouseTagValue = value;
                },
              );
            },
          ),
        ),
      ),
    ]);
  }
}
