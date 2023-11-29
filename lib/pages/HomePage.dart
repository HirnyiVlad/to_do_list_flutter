import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_flutter/pages/MainViewModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<MainViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[850],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: viewmodel.textEditingController,
                  decoration: InputDecoration(
                      hintText: 'Enter a note',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[500])),
                  onChanged: viewmodel.updateTextField,
                )),
                ElevatedButton(
                    onPressed: viewmodel.textEditingController.text.isEmpty
                        ? null
                        : () {
                            viewmodel.addNote();
                          },
                    style: ButtonStyle(
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                        (Set<MaterialState> states) {
                          return const BorderSide(
                            color: Colors.white12, // Border color
                            width: 2.0, // Border width
                          );
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.black12;
                          }
                          return Colors.black;
                        },
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
          Expanded(child: Consumer<MainViewModel>(
            builder: (context, model, child) {
              return ListView.builder(
                  itemCount: model.notes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Colors.white.withOpacity(0.3),
                          child: Dismissible(
                              key: Key(model.notes[index]),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                child: const Icon(Icons.delete),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                model.deleteNote(index);
                              },
                              child: ListTile(
                                  title: Text(
                                model.notes[index],
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ))),
                        ),
                      ),
                    );
                  });
            },
          ))
        ],
      ),
    );
  }
}
