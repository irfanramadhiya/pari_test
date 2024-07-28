import 'package:flutter/material.dart';
import 'package:pari_test/reusable_widget/custom_text_form_field_widget.dart';
import 'package:pari_test/viewmodels/add_viewmodel.dart';
import 'package:provider/provider.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Gadget"),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
              key: context.read<AddViewModel>().formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormFieldWidget(
                      controller: context.read<AddViewModel>().nameController,
                      label: "Name"),
                  CustomTextFormFieldWidget(
                      controller: context.read<AddViewModel>().colorController,
                      label: "Color"),
                  CustomTextFormFieldWidget(
                      controller:
                          context.read<AddViewModel>().capacityController,
                      label: "Capacity"),
                  Text(Provider.of<AddViewModel>(context, listen: true)
                      .errorText),
                  TextButton(
                      onPressed: () {
                        context.read<AddViewModel>().handleAddGadget(context);
                      },
                      child: const Text("Add Gadget"))
                ],
              )),
        ),
      ),
    );
  }
}
