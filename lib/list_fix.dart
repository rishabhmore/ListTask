import 'package:flutter/material.dart';

class Item {
  int index;
  int count = 0;

  Item(this.index);
}

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  var list = <Item>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i <= 100; i++) {
      list.add(Item(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListItemWidget(
          item: list[index],
          onIncrement: (widgetItem) {
            setState(() => list[widgetItem.index].count++);
          },
        );
      },
    );
  }
}

class ListItemWidget extends StatefulWidget {
  final Item item;
  final Function(Item item) onIncrement;

  const ListItemWidget({
    required this.item,
    required this.onIncrement,
    super.key,
  });

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Text(widget.item.count.toString()),
          MaterialButton(
            onPressed: () => widget.onIncrement(widget.item),
            child: const Text("+"),
          )
        ],
      ),
    );
  }
}
