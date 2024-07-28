import 'package:flutter/material.dart';
import 'package:pari_test/models/gadget.dart';
import 'package:pari_test/viewmodels/detail_viewmodel.dart';
import 'package:provider/provider.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gadget Detail"),
      ),
      body: FutureBuilder(
        future: context.read<DetailViewModel>().getGadgetById(context, id),
        builder: (BuildContext context, AsyncSnapshot<Gadget?> snapshot) {
          if (context.read<DetailViewModel>().getGadgetErrorText != "") {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                  "Something went wrong: ${Provider.of<DetailViewModel>(context, listen: true).getGadgetErrorText}"),
            ));
          } else if (snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("name: ${snapshot.data!.name}"),
                    Text("color: ${snapshot.data?.data?.color ?? "-"}"),
                    Text("capacity: ${snapshot.data?.data?.capacity ?? "-"}"),
                    TextButton(
                        onPressed: () {
                          context
                              .read<DetailViewModel>()
                              .navigateToEdit(context, snapshot.data!);
                        },
                        child: const Text("Edit")),
                    Text(Provider.of<DetailViewModel>(context, listen: true)
                        .deleteGadgetErrorText),
                    TextButton(
                        onPressed: () {
                          context
                              .read<DetailViewModel>()
                              .deleteGadgetById(context, id);
                        },
                        child: const Text("Delete"))
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}
