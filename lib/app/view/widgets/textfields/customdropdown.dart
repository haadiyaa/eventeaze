import 'package:eventeaze/app/bloc/functionBloc/functions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown({
    super.key,
    this.selectedItem,
    required List<String> items,
  }) : _items = items;

  String? selectedItem;
  final List<String> _items;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FunctionsBloc(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: BlocBuilder<FunctionsBloc, FunctionsState>(
          builder: (context, state) {
            if(state is DropdownState){
              selectedItem=state.value;
            }
            return DropdownButtonFormField(
              
              decoration: InputDecoration(
                labelText: 'Category',
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 170, 181, 135),
                ),
                filled: true,
                fillColor: const Color.fromARGB(99, 219, 219, 219),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 170, 181, 135), width: 0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 170, 181, 135)),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 170, 181, 135)),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 170, 181, 135)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              value: selectedItem,
              items: _items.map<DropdownMenuItem<String>>((String vaue) {
                return DropdownMenuItem<String>(
                  value: vaue,
                  child: Text(vaue),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select an item';
                }
              },
              onChanged: (value) {
                BlocProvider.of<FunctionsBloc>(context).add(DropdownEvent(value: selectedItem));
              },
            );
          },
        ),
      ),
    );
  }
}
