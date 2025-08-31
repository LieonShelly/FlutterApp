import 'package:basic_widgets/ui/theme/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

typedef OnChecked = void Function(bool);

class IngredientCard extends ConsumerStatefulWidget {
  final String name;
  final bool initiallyChecked;
  final bool evenRow;
  final bool showCheckbox;
  final OnChecked onChecked;

  const IngredientCard({
    Key? key,
    required this.name,
    required this.initiallyChecked,
    required this.evenRow,
    this.showCheckbox = true,
    required this.onChecked,
  }) : super(key: key);

  @override
  ConsumerState<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends ConsumerState<IngredientCard> {
  bool checked = false;

  @override
  void initState() {
    super.initState();
    checked = widget.initiallyChecked;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final eveSelectedColor = isDarkMode
        ? darkBackgroundColor
        : smallCardBackgroundColor;
    final oddSelectedColor = isDarkMode ? darkBackgroundColor : Colors.white;
    final side = !widget.evenRow
        ? const BorderSide(color: Colors.black, width: 1)
        : BorderSide.none;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: side,
      ),
      color: widget.evenRow ? eveSelectedColor : oddSelectedColor,
      child: _buildTitle(),
    );
  }

  Widget _buildTitle() {
    if (widget.showCheckbox) {
      return CheckboxListTile(
        value: checked,
        title: Text(
          widget.name,
          style: TextStyle(
            decoration: checked
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              checked = value;
              widget.onChecked(value);
            });
          }
        },
      );
    } else {
      return ListTile(
        title: Text(
          widget.name,
          style: TextStyle(
            decoration: checked
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      );
    }
  }
}
