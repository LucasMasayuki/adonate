import 'package:flutter/material.dart';

class TagDropdowns extends StatefulWidget {
  const TagDropdowns({
    this.reference,
    this.tags,
    this.defaultPurpouseTagValue,
    this.defaultItemTypeTagValue,
  });

  final reference;
  final tags;
  final defaultPurpouseTagValue;
  final defaultItemTypeTagValue;

  @override
  TagDropdownsState createState() => TagDropdownsState();
}

class TagDropdownsState extends State<TagDropdowns> {
  String _purposeTag;
  String _typeItemTag;
  var purposeTagList;
  var itemTypeTagList;

  @override
  void initState() {
    _purposeTag = widget.defaultPurpouseTagValue;
    _typeItemTag = widget.defaultItemTypeTagValue;

    purposeTagList = widget.tags
      .where((value) => value.entries.toList()[3].value == "PURPOSE")
      .map<DropdownMenuItem<String>>((value) {
          var tag = value.entries.toList();
          var dropdownMenuItem = DropdownMenuItem<String>(
            value: tag[1].value,
            child: Text(tag[1].value),
          );
          return dropdownMenuItem;
        }
      ).toList();

    itemTypeTagList = widget.tags
      .where((value) => value.entries.toList()[3].value == "ITEM")
      .map<DropdownMenuItem<String>>((value) {
        var tag = value.entries.toList();
        var dropdownMenuItem = DropdownMenuItem<String>(
          value: tag[1].value,
          child: Text(tag[1].value),
        );
        return dropdownMenuItem;
      }
    ).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Center(
            child: DropdownButton(
              hint: Text('Beneficiado / Objetivo', style: TextStyle(fontSize: 12, color: Colors.black)),
              style: TextStyle(fontSize: 12, color: Colors.black),
              items: purposeTagList,
              value: _purposeTag,
              onChanged: (value) {
                _purposeTag = value;
                setState(() {
                  _purposeTag = value;
                  widget.reference.defaultPurpouseTagValue = value;
                });
              }
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: DropdownButton(
              hint: Text('O que doar', style: TextStyle(fontSize: 12, color: Colors.black)),
              style: TextStyle(fontSize: 12, color: Colors.black),  
              items: itemTypeTagList,
              value: _typeItemTag,
              onChanged: (value) {
                _typeItemTag = value;
                setState(() {
                  _typeItemTag = value;
                  widget.reference.defaultItemTypeTagValue = value;
                });
              }
            ),
          ),
        ),
      ]
    );
  }
}



               