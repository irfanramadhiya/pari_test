import 'package:flutter/material.dart';
import 'package:pari_test/models/gadget.dart';
import 'package:pari_test/reusable_widget/custom_text_form_field_widget.dart';
import 'package:pari_test/viewmodels/edit_viewmodel.dart';
import 'package:provider/provider.dart';

class EditView extends StatelessWidget {
  const EditView({super.key, required this.gadget});

  final Gadget gadget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Gadget"),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
              key: context.read<EditViewModel>().formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormFieldWidget(
                    controller: context
                        .read<EditViewModel>()
                        .getNameController(gadget.name),
                    label: "Name",
                  ),
                  CustomTextFormFieldWidget(
                    controller: context
                        .read<EditViewModel>()
                        .getColorController(gadget.data?.color ?? ""),
                    label: "Color",
                  ),
                  CustomTextFormFieldWidget(
                    controller: context
                        .read<EditViewModel>()
                        .getCapacityController(gadget.data?.capacity ?? ""),
                    label: "Capacity",
                  ),
                  Text(Provider.of<EditViewModel>(context, listen: true)
                      .errorText),
                  TextButton(
                      onPressed: () {
                        context
                            .read<EditViewModel>()
                            .handleEditGadget(context, gadget.id);
                      },
                      child: const Text("Edit Gadget"))
                ],
              )),
        ),
      ),
    );
  }
}
