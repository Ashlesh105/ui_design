import 'package:flutter/material.dart';

class AddFarmer extends StatelessWidget {
  const AddFarmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Farmer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Farmer Name',
                hintText: 'Enter farmer name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Farmer Number',
                hintText: 'Enter farmer number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Implement save logic here
                // You can access the entered values using controllers
                // and then perform the save operation.
                // Example:
                // String name = nameController.text;
                // String number = numberController.text;
                // Save to database or perform other actions.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Farmer data saved!'),
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}