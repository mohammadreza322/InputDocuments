import 'package:flutter/material.dart';
import "package:universal_html/js.dart" as js;

Future<bool?> showAddHomePageDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Icon(
                    Icons.add_circle,
                    size: 70,
                    color: Theme.of(context).primaryColor,
                  )),
              SizedBox(height: 20.0),
              Text(
                'Add to Homepage',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.0),
              Text(
                'Want to add this application to home screen?',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () {
                    js.context.callMethod("presentAddToHome");
                    Navigator.pop(context, false);
                  },
                  child: Text("Yes!"))
            ],
          ),
        ),
      );
    },
  );
}