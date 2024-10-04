import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  TextEditingController _edtTexto1 = TextEditingController();
  List<String> tarefas = [];
  List<bool> tarefasConcluidas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "To do List",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: TextField(
                  controller: _edtTexto1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: ("Tarefa"),
                    labelStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.task),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_edtTexto1.text.isNotEmpty) {
                                tarefas.add(_edtTexto1.text);
                                tarefasConcluidas.add(false);
                                _edtTexto1.clear();
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side:
                                    BorderSide(color: Colors.blue, width: 1.0),
                              )),
                          child: Text(
                            "Cadastrar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tarefas.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(
                        tarefas[index],
                        style: TextStyle(
                            decoration: tarefasConcluidas[index]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      value: tarefasConcluidas[index],
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            tarefasConcluidas[index] = value!;
                            String tarefaConcluida = tarefas.removeAt(index);
                            bool estadoConcluida = tarefasConcluidas.removeAt(index);
                            tarefas.add(tarefaConcluida);
                            tarefasConcluidas.add(estadoConcluida);
                          } else {
                            tarefasConcluidas[index] = value!;
                            String tarefaDesmarcada = tarefas.removeAt(index);
                            bool estadoDesmarcada = tarefasConcluidas.removeAt(index);
                            tarefas.insert(0, tarefaDesmarcada);
                            tarefasConcluidas.insert(0, estadoDesmarcada);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
