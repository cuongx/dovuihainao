import 'package:flutter/material.dart';

typedef Widget FunctionToWidget(Function action);
typedef Widget DataToWidget(data, Function action(data));

class WidgetWrapAutomate<T> extends StatefulWidget {
  static final String keyData = 'data';
  static final String keyStatus = 'status';

  final Axis axis;
  final double spacing;
  final double runSpaceing;
  final WrapAlignment wrapAlignment;
  final WrapAlignment runWrapAlignment;
  final WrapCrossAlignment crossAxisAlignment;

  final Map<String, dynamic> result;
  final FunctionToWidget widgetMore;
  final DataToWidget widgetChild;
  final List<T> data;

  const WidgetWrapAutomate(
      {Key key,
      this.axis,
      this.data,
      this.spacing,
      this.runSpaceing,
      this.runWrapAlignment,
      this.crossAxisAlignment,
      this.result,
      this.wrapAlignment,
      this.widgetChild,
      this.widgetMore})
      : assert(widgetChild != null),
        assert(data != null),
        assert(result != null),
        super(key: key);

  @override
  _WidgetWrapAutomateState<T> createState() => _WidgetWrapAutomateState<T>();
}

class _WidgetWrapAutomateState<T> extends State<WidgetWrapAutomate> {
  List<Widget> children = [];
  List<T> values = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < (widget.data?.length ?? 0); i++) {
      children.add(widget.widgetChild(widget.data[i], (value) {
        reactionChanged(value, i);
        return;
      }));
      values.add(widget.data[i]);
    }
    widget.result[WidgetWrapAutomate.keyData] = values;
    if (widget.widgetMore != null)
      children.add(widget.widgetMore(createWidget));
    else
      children.add(_buildWidgetMore(createWidget));
  }

  void reactionChanged(T value, int index) {
    values[index] = value;
    widget.result[WidgetWrapAutomate.keyData] = values;
  }

  void createWidget() {
    List<Widget> widgets = [];
    for (int i = 0; i < children.length; i++) {
      if (i == children.length - 1) {
        values.add(null);
        widgets.add(widget.widgetChild(values[i], (value) {
          reactionChanged(value, i);
          return;
        }));
      }
      widgets.add(children[i]);
    }
    setState(() {
      children = widgets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
      children: children,
      alignment: widget.wrapAlignment ?? WrapAlignment.center,
      runAlignment: widget.runWrapAlignment ?? WrapAlignment.center,
      spacing: widget.spacing ?? 4,
      runSpacing: widget.runSpaceing ?? 4,
      direction: widget.axis ?? Axis.horizontal,
      crossAxisAlignment:
          widget.crossAxisAlignment ?? WrapCrossAlignment.center,
      key: widget.key,
    ));
  }

  Widget _buildWidgetMore(Function action) {
    return Container(
      child: FlatButton(
        onPressed: action,
        child: Icon(Icons.add),
        shape: CircleBorder(),
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
