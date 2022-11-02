import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_listview/service/tasklist.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Task Baru"),
      ),
      body: const MyTextForm(),
    );
  }
}

class MyTextForm extends StatefulWidget {
  const MyTextForm({super.key});

  @override
  MyTextFormState createState() {
    return MyTextFormState();
  }
}

class MyTextFormState extends State<MyTextForm> {
  final TextEditingController _textName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _textName,
              decoration: const InputDecoration(
                hintText: "Masukkan Task Baru",
              ),
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value != '') {
                  if (value!.length < 3) {
                    return 'Inputan harus lebih dari 3';
                  } else {
                    return null;
                  }
                } else {
                  return "Inputan haus diisi!";
                }
              },
              onChanged: (value) {
                setState(() {
                  if (_textName.text.isNotEmpty) {
                    if (value.length < 3) {
                      _isEnabled = false;
                    } else {
                      _isEnabled = true;
                    }
                  } else {
                    _isEnabled = false;
                  }
                });
                context.read<Tasklist>().changeTaskName(value);
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isEnabled
                        ? () {
                            if (_textName.text.isNotEmpty) {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                context.read<Tasklist>().addTask();
                                Navigator.pop(context);
                              }
                            } else {
                              return;
                            }
                          }
                        : null,
                    child: const Text("Tambah Task Baru"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
