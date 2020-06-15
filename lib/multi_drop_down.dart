import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';

typedef OnConfirm(List selectedValues);

/// 下拉多选
/// Created by Shusheng.
class MultipleDropDown extends StatefulWidget {
  final List values;
  final List<MultipleSelectItem> elements;
  final String placeholder;
  final bool disabled;

  MultipleDropDown({
    Key key,
    @required this.values,
    @required this.elements,
    this.placeholder,
    this.disabled = false,
  })  : assert(values != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => MultipleDropDownState();
}

class MultipleDropDownState extends State<MultipleDropDown> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Opacity(
        opacity: this.widget.disabled ? 0.4 : 1,
        child: Card(
          elevation: 0.7,
          color: Colors.white,
          margin: EdgeInsets.only(right: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: this._getContent(),
              ),
            ],
          ),
        //  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey[350]))),
        ),
      ),
      onTap: () {
        if (!this.widget.disabled)
          MultipleSelect.showMultipleSelector(
            context,
            elements: this.widget.elements,
            values: this.widget.values,
            title: this.widget.placeholder,
          ).then((values) {
            this.setState(() {});
          });
      },
    );
  }

  Widget _getContent() {
    if (this.widget.values.length <= 0 && this.widget.placeholder != null) {
      return Padding(
        child: Text(
          this.widget.placeholder,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            decoration: TextDecoration.none,
          ),
        ),
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 10),
      );
    } else {
      return Wrap(
        children: this
            .widget
            .elements
            .where((element) => this.widget.values.contains(element.value))
            .map(
              (element) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: RawChip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      backgroundColor: Colors.white,
                      isEnabled: !this.widget.disabled,
                      elevation: 1,
                      label: Text(element.display),
                      onDeleted: () {
                        if (!this.widget.disabled) {
                          this.widget.values.remove(element.value);
                          this.setState(() {});
                        }
                      },
                    ),
                  ),
            )
            .toList(),
      );
    }
  }
}
