import 'package:flutter/material.dart';
import 'package:pari_test/api/service.dart';
import 'package:pari_test/models/gadget.dart';
import 'package:pari_test/views/add_view.dart';
import 'package:pari_test/views/detail_view.dart';

class HomeViewModel extends ChangeNotifier {
  List<Gadget>? gadgets = [];
  String errorText = "";

  Future<List<Gadget>?> getGadgetList(BuildContext context) async {
    return await Service().getGadgetList(errorText, context);
  }

  void navigateToDetail(BuildContext context, String id) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => DetailView(
                  id: id,
                )))
        .then((value) => notifyListeners());
  }

  void navigateToAdd(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AddView()))
        .then((value) => notifyListeners());
  }

  void setErrorText(String newErrorText) {
    errorText = newErrorText;
    notifyListeners();
  }
}
