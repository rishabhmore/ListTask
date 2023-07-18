import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Item extends Equatable {
  final int index;
  final int count;

  const Item({required this.index, this.count = 0});

  @override
  List<Object> get props => [index, count];

  Item incrementCount() {
    return Item(
      index: index,
      count: count + 1,
    );
  }
}

// Create a Cubit for managing the state
class ItemCubit extends Cubit<List<Item>> {
  ItemCubit() : super(List.generate(100, (index) => Item(index: index)));

  void incrementItem(Item item) {
    final updatedList = List.of(state)
      ..[item.index] = state[item.index].incrementCount();
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
          buildWhen: (previous, current) {
            // Only rebuild if contents are not same
            return previous != current || previous.length != current.length;
          },
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

class ListItemWidget extends StatelessWidget {
  final Item item;

  const ListItemWidget({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ItemCubit>(context),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Text(item.count.toString()),
            MaterialButton(
              onPressed: () {
                context.read<ItemCubit>().incrementItem(item);
              },
              child: const Text("+"),
            )
          ],
        ),
      ),
    );
  }
}
