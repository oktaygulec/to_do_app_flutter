import 'package:flutter/material.dart';
import './picker_button.dart';

class Picker extends StatelessWidget {
  final String title;
  final List list;
  final Selected selected;
  final Function onSelected;

  Picker({
    required this.title,
    required this.list,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close),
            )
          ],
        ),
        content: Container(
          width: MediaQuery.of(context).size.width * .7,
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(list.length, (index) {
              return selected == Selected.color
                  ? PickerButton(
                      selected: selected,
                      color: list[index],
                      width: 92,
                      height: 92,
                      onPressed: () {
                        onSelected(list[index]);
                        Navigator.pop(context);
                      },
                    )
                  : PickerButton(
                      selected: selected,
                      icon: list[index],
                      width: 92,
                      height: 92,
                      onPressed: () {
                        onSelected(list[index]);
                        Navigator.pop(context);
                      },
                    );
            }),
          ),
        ));
  }
}
