import 'package:flutter/material.dart';
import 'package:pari_test/api/service.dart';
import 'package:pari_test/models/gadget.dart';
import 'package:pari_test/models/gadget_data.dart';

class EditViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController capacityController = TextEditingController();

  String errorText = "";

  TextEditingController getNameController(String initalValue) {
    nameController.text = initalValue;
    return nameController;
  }

  TextEditingController getColorController(String initalValue) {
    colorController.text = initalValue;
    return colorController;
  }

  TextEditingController getCapacityController(String initalValue) {
    capacityController.text = initalValue;
    return capacityController;
  }

  void handleEditGadget(BuildContext context, String id) async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      errorText = "";
      notifyListeners();
      GadgetData data = GadgetData(
          color: colorController.text, capacity: capacityController.text);
      Gadget gadget = Gadget(name: nameController.text, id: id, data: data);
      String response =
          await Service().updateGadget(gadget, errorText, context);
      if (errorText == "") {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Success"),
            content: Text(
                "Gadget ${nameController.text} has been edited\n response: $response"),
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
        });
      }
    }
  }

  void setErrorText(String newErrorText) {
    errorText = newErrorText;
    notifyListeners();
  }
}
