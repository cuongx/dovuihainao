import 'package:flutter/material.dart';
import '../../configs/configs.dart';

class WidgetInput extends StatefulWidget {
  final TextEditingController inputController;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final String hint;
  final bool obscureText;
  final bool autovalidate;
  final TextInputType inputType;
  final Widget endIcon;
  final double height;
  final double width;
  final double paddingHorizontal;
  final double paddingVertical;
  final TextStyle style;
  final TextStyle hintStyle;
  final double radiusBorder;
  final int maxLines;
  final double elevation;
  final double paddingLeftMore;
  final TextAlign textAlign;

  WidgetInput(
      {this.inputController,
      this.onChanged,
      this.textAlign,
      this.validator,
      this.paddingLeftMore,
      this.hint,
      this.maxLines,
      this.inputType = TextInputType.text,
      this.obscureText = false,
      this.autovalidate = false,
      this.endIcon,
      this.elevation,
      this.style,
      this.hintStyle,
      this.radiusBorder,
      this.width,
      this.paddingHorizontal,
      this.paddingVertical,
      this.height});

  @override
  _WidgetInputState createState() => _WidgetInputState();
}

class _WidgetInputState extends State<WidgetInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      height: widget.height ?? AppValues.INPUT_FORM_HEIGHT,
      width: widget.width,
      child: Card(
        elevation: widget.elevation ?? 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radiusBorder ?? 20)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: widget.paddingHorizontal ?? 25,
              vertical: widget.paddingVertical ?? 0),
          child: Row(
            children: [
              SizedBox(
                width: widget.paddingLeftMore ?? 2,
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.inputController,
                  onChanged: (change) {
                    widget.onChanged(change);
                  },
                  autovalidate: widget.autovalidate ?? false,
                  validator: widget.validator,
                  style: widget.style ?? AppStyles.DEFAULT_MEDIUM,
                  maxLines: widget.maxLines ?? 1,
                  keyboardType: widget.inputType ?? TextInputType.text,
                  textAlign: widget.textAlign ?? TextAlign.left,
                  obscureText: widget.obscureText,
                  decoration: InputDecoration.collapsed(
                      hintText: widget.hint,
                      hintStyle: widget.hintStyle ??
                          AppStyles.DEFAULT_SMALL
                              .copyWith(fontStyle: FontStyle.italic)),
                ),
              ),
              widget.endIcon ?? const SizedBox()
            ],
          ),
        ),
      ),
    ));
  }
}
