import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown({
    super.key,
    this.selectedItem,
    required List<String> items,
    this.validator,
  }) : _items = items;

  String? selectedItem;
  final List<String> _items;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: BlocBuilder<FunctionsBloc, FunctionsState>(
        builder: (context, state) {
          if (state is DropdownState) {
            selectedItem = state.value;
            print('state emittteed ${state.value} and $selectedItem');
          }
          return DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Category',
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color:Color.fromARGB(255, 81, 87, 64),
              ),
              filled: true,
              fillColor: const Color.fromARGB(170, 235, 235, 235),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 170, 181, 135), width: 0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 170, 181, 135)),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 170, 181, 135)),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 170, 181, 135)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            value: selectedItem,
            items: _items.map<DropdownMenuItem<String>>((String vaue) {
              print(selectedItem);
              return DropdownMenuItem<String>(
                value: vaue,
                child: Text(vaue),
              );
            }).toList(),
            validator: validator,
            onChanged: (value) {
              BlocProvider.of<FunctionsBloc>(context)
                  .add(DropdownEvent(value: value));
              print('oooonnnn change$selectedItem paassseeeddd');
            },
          );
        },
      ),
    );
  }
}
