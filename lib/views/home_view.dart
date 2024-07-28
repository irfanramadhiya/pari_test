import 'package:flutter/material.dart';
import 'package:pari_test/models/gadget.dart';
import 'package:pari_test/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PARI Test"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<HomeViewModel>().navigateToAdd(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: context.read<HomeViewModel>().getGadgetList(context),
        builder: (BuildContext context, AsyncSnapshot<List<Gadget>?> snapshot) {
          if (context.read<HomeViewModel>().errorText != "") {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                  "Something went wrong: ${Provider.of<HomeViewModel>(context, listen: true).errorText}"),
            ));
          } else if (snapshot.hasData) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Table(
                    border: TableBorder.all(color: Colors.black),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      const TableRow(
                          decoration: BoxDecoration(color: Colors.red),
                          children: [
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text("Name"),
                                )),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text("Color"),
                                )),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text("Capacity"),
                                ))
                          ]),
                      ...List.generate(
                          snapshot.data!.length,
                          (index) => TableRow(children: [
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<HomeViewModel>()
                                        .navigateToDetail(
                                            context, snapshot.data![index].id);
                                  },
                                  child: TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          snapshot.data![index].name,
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      )),
                                ),
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                          snapshot.data![index].data?.color ??
                                              "-"),
                                    )),
                                TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(snapshot
                                              .data![index].data?.capacity ??
                                          "-"),
                                    )),
                              ]))
                    ],
                  ),
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
