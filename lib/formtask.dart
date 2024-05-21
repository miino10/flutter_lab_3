import 'package:flutter/material.dart';

class FormTasks extends StatefulWidget {
  const FormTasks({super.key});
  @override
  State<FormTasks> createState() => _FormTasksState();
}

class _FormTasksState extends State<FormTasks> {
  List<Widget> list = [];
  int fieldCount = 0;
  List<Map<String, dynamic>> items = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Work Tasks"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            fieldCount == 0
                ? const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "No Tasks!",
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      ListView.builder(
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (_, i) => buildField(i),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Work Tasks"),
                                    content: SizedBox(
                                      width: double.maxFinite,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: items
                                            .map((e) => Text(e["TodoList"].trim()))
                                            .toList(),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Validation error! Please add tasks.")));
                            }
                          },
                          child: const Text("Submit")),
                    ],
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("ADD\nNEW"),
        onPressed: () {
          setState(() {
            fieldCount++;
            list.add(buildField(fieldCount));
          });
        },
      ),
    );
  }

  Widget buildField(int i) {
    return ListTile(
      leading: CircleAvatar(
        child: Text((i + 1).toString()),
      ),
      title: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          labelText: "TodoList ${i + 1}",
        ),
        onChanged: (data) => storeValue(i + 1, data),
        validator: (val) => val!.isEmpty ? "Required" : null,
      ),
      trailing: InkWell(
        child: const Icon(Icons.delete_outlined, color: Colors.red),
        onTap: () {
          setState(() {
            fieldCount--;
            list.removeAt(i);
            items.removeAt(i);
          });
        },
      ),
    );
  }

  void storeValue(int i, String v) {
    bool valueFound = false;
    for (int j = 0; j < items.length; j++) {
      if (items[j]["field_id"] == i) {
        valueFound = true;
        items[j]["TodoList"] = v;
        break;
      }
    }
    if (!valueFound) {
      items.add({
        "field_id": i,
        "TodoList": v,
      });
    }
  }
}
