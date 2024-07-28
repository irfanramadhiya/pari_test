import 'package:flutter/material.dart';
import 'package:pari_test/api/service.dart';
import 'package:pari_test/models/gadget.dart';
import 'package:pari_test/views/edit_view.dart';

class DetailViewModel extends ChangeNotifier {
  String getGadgetErrorText = "";
  String deleteGadgetErrorText = "";

  Future<Gadget?> getGadgetById(BuildContext context, String id) async {
    deleteGadgetErrorText = "";
    getGadgetErrorText = "";
    return await Service().getGadget(id, getGadgetErrorText, context);
  }

  Future<void> deleteGadgetById(BuildContext context, String id) async {
    deleteGadgetErrorText = "";
    notifyListeners();
    String response =
        await Service().deleteGadget(id, deleteGadgetErrorText, context);
    if (deleteGadgetErrorText == "") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"),
          content: Text("Gadget has been deleted\n response: $response"),
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
      ).then((value) => Navigator.of(context).pop());
    }
  }

  void navigateToEdit(BuildContext context, Gadget gadget) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => EditView(
                  gadget: gadget,
                )))
        .then((value) async {
      deleteGadgetErrorText = "";
      getGadgetErrorText = "";
      notifyListeners();
    });
  }

  void setGetGadgetErrorText(String newErrorText) {
    getGadgetErrorText = newErrorText;
    notifyListeners();
  }

  void setDeleteGadgetErrorText(String newErrorText) {
    deleteGadgetErrorText = newErrorText;
    notifyListeners();
  }
}
