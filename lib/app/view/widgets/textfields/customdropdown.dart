import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    this.selectedItem,
    required this.items,
    this.validator, required this.text, this.onChanged,
  }) ;
  final String? selectedItem;
  final List<String> items;
  final String? Function(String?)? validator;
  final String text;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color:Color.fromARGB(255, 81, 87, 64),
          ),
          filled: true,
          fillColor:const Color.fromARGB(170, 243, 242, 242),
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
        items: items.map<DropdownMenuItem<String>>((String vaue) {
          print(selectedItem);
          return DropdownMenuItem<String>(
            value: vaue,
            child: Text(vaue),
          );
        }).toList(),
        validator: validator,
        onChanged: onChanged,
        
      ),
    );
  }
}
