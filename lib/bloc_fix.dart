import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Item {
  int index;
  int count = 0;

  Item(this.index);
}

// Create a Cubit for managing the state
class ItemCubit extends Cubit<List<Item>> {
  ItemCubit() : super(List.generate(100, (index) => Item(index)));

  void incrementItem(Item item) {
    final updatedList = List.of(state)
      ..[item.index].count = state[item.index].count + 1;
    // Emit new state with updated items
    emit(updatedList);
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocProvider(
        create: (context) => ItemCubit(),
        child: BlocBuilder<ItemCubit, List<Item>>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                return ListItemWidget(item: state[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class ListItemWidget extends StatefulWidget {
  final Item item;

  const ListItemWidget({required this.item, Key? key}) : super(key: key);

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ItemCubit>(context),
      child: Builder(builder: (context) {
        return Container(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Text(widget.item.count.toString()),
              MaterialButton(
                onPressed: () {
                  context.read<ItemCubit>().incrementItem(widget.item);
                },
                child: const Text("+"),
              )
            ],
          ),
        );
      }),
    );
  }
}
