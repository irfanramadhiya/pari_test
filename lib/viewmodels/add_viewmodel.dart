import 'package:flutter/material.dart';
import 'package:pari_test/api/service.dart';
import 'package:pari_test/models/gadget.dart';
import 'package:pari_test/models/gadget_data.dart';

class AddViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController capacityController = TextEditingController();

  String errorText = "";

  void handleAddGadget(BuildContext context) async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      errorText = "";
      notifyListeners();
      GadgetData data = GadgetData(
          color: colorController.text, capacity: capacityController.text);
      Gadget gadget = Gadget(name: nameController.text, id: "0", data: data);
      String response = await Service().addGadget(gadget, errorText, context);
      if (errorText == "") {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Success"),
            content: Text(
                "Gadget ${nameController.text} has been added\n response: $response"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Close",
                  )),
            ],
          ),
        ).then((value) {
          Navigator.of(context).pop();
          nameController.text = "";
          colorController.text = "";
          capacityController.text = "";
        });
      }
    }
  }

  void setErrorText(String newErrorText) {
    errorText = newErrorText;
    notifyListeners();
  }
}
