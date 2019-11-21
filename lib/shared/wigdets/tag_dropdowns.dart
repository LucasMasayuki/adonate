import 'package:flutter/material.dart';

class TagDropdowns extends StatelessWidget {
  final tags;
  final String defaultPurpouseTagValue;
  final String defaultItemTypeTagValue;

  const TagDropdowns({
    Key key,
    this.tags,
    this.defaultPurpouseTagValue,
    this.defaultItemTypeTagValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 16.0, top: 12.0),
            child: Center(
              child: DropdownButton(
                hint: Text('Para quem', style: TextStyle(fontSize: 12, color: Colors.black)),
                value: this.defaultPurpouseTagValue,
                style: TextStyle(fontSize: 12, color: Colors.black),
                items: tags
                  .where((value) => value.entries.toList()[3].value == "PURPOSE")
                  .map<DropdownMenuItem<String>>((value) {
                    var tag = value.entries.toList();
                    var dropdownMenuItem = DropdownMenuItem<String>(
                      value: tag[1].value,
                      child: Text(tag[1].value),
                    );
                    return dropdownMenuItem;
                  }
                ).toList(),
                onChanged: (value) {
                }
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 16.0, top: 12.0),
            child: Center(
              child: DropdownButton(
                hint: Text('O que doar', style: TextStyle(fontSize: 12, color: Colors.black)),
                value: this.defaultItemTypeTagValue,
                style: TextStyle(fontSize: 12, color: Colors.black),
                items: tags
                  .where((value) => value.entries.toList()[3].value == "ITEM")
                  .map<DropdownMenuItem<String>>((value) {
                    var tag = value.entries.toList();
                    var dropdownMenuItem = DropdownMenuItem<String>(
                      value: tag[1].value,
                      child: Text(tag[1].value),
                    );
                    return dropdownMenuItem;
                  }
                ).toList(),
                onChanged: (value) {
                }
              ),
            ),
          ),
        ),
      ]
    );
  }
}



               