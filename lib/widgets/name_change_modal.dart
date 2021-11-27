import 'package:flutter/material.dart';

class NameChangeModal {
  void show({
    required BuildContext context,
    required String initialName,
    required Function onChanged,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            height: 120,
            color: Colors.amber,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    initialValue: initialName,
                    onChanged: (value) => onChanged(value),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Pedal Name",
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Close BottomSheet'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
