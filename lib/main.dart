import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController parentsNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController hostelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: batchController,
              decoration: InputDecoration(labelText: 'Batch'),
            ),
            TextField(
              controller: rollNoController,
              decoration: InputDecoration(labelText: 'Roll No'),
            ),
            TextField(
              controller: mobileNoController,
              decoration: InputDecoration(labelText: 'Mobile No'),
            ),
            TextField(
              controller: parentsNoController,
              decoration: InputDecoration(labelText: 'Parents No'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email ID'),
            ),
            TextField(
              controller: hostelController,
              decoration: InputDecoration(labelText: 'Hostel'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Here you can perform authentication and navigate to Dashboard page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  TextEditingController purposeController = TextEditingController();
  TextEditingController outTimeController = TextEditingController();
  TextEditingController inTimeController = TextEditingController();

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: purposeController,
              decoration: const InputDecoration(labelText: 'Outing Purpose'),
            ),
            TextField(
              controller: outTimeController,
              decoration: const InputDecoration(labelText: 'Out Time'),
            ),
            TextField(
              controller: inTimeController,
              decoration: const InputDecoration(labelText: 'In Time'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String purpose = purposeController.text;
                String outTime = outTimeController.text;
                String inTime = inTimeController.text;

                generateBarcode(context, purpose, outTime, inTime);
              },
              child: const Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }

  void generateBarcode(BuildContext context, String purpose, String outTime,
      String inTime) {
    String barcodeData = "Outing Purpose: $purpose\nOut Time: $outTime\nIn Time: $inTime";
    Barcode bc = Barcode.code128();

    // Encode the barcode data into SVG format
    String svgString = bc.toSvg(barcodeData);

    // // Create an SVG image widget
    // Image image = Image.memory(
    //   Uint8List.fromList(
    //     utf8.encode(svgString.substring(svgString.indexOf(',') + 1)),
    //   ),
    // );

    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: const Text('Generated Barcode'),
            content: Container(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.string(
                svgString,
                width: 200,
                height: 100,
              ),
            ), // Display the barcode image
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }
}
