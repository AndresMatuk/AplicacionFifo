import 'package:flutter/material.dart';

class VectorFufosApp extends StatefulWidget {
  @override
  _VectorFufosAppState createState() => _VectorFufosAppState();
}

class _VectorFufosAppState extends State<VectorFufosApp> {
  TextEditingController sizeController = TextEditingController();
  TextEditingController elementsController = TextEditingController();
  TextEditingController initialPositionController = TextEditingController();

  List<int> column = [];
  List<int> fufo = [];

  int sumaTiempo = 0;
  double promedio = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              'Vector Fufos',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text('Ingrese el tamaño del array:', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  child: TextField(
                    controller: sizeController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('Ingrese los elementos del array (en el rango de 0 a 250, separados por espacios):', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  child: TextField(
                    controller: elementsController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('Ingrese la posición inicial (en el rango de 0 a 250):', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  child: TextField(
                    controller: initialPositionController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      column.clear();
                      fufo.clear();
                      sumaTiempo = 0;
                      promedio = 0;

                      int size = int.parse(sizeController.text);
                      String elementsText = elementsController.text;
                      List<String> elementsList = elementsText.split(' ');
                      for (int i = 0; i < size; i++) {
                        int num = int.parse(elementsList[i]);
                        if (num < 0 || num > 250) {
                          print("Error: El número debe estar en el rango de 0 a 250. Inténtelo de nuevo.");
                          return;
                        } else {
                          column.add(num);
                        }
                      }

                      int solicitud = int.parse(initialPositionController.text);
                      if (solicitud < 0 || solicitud > 250) {
                        print("Error: La posición inicial debe estar en el rango de 0 a 250.");
                        return;
                      }

                      for (int i = 0; i < size; i++) {
                        if (i == 0) {
                          fufo.add((column[i] - solicitud).abs());
                        } else {
                          fufo.add((column[i] - column[i - 1]).abs());
                        }
                        sumaTiempo += fufo[i];
                      }

                      promedio = sumaTiempo / (size + 1);
                    });
                  },
                  child: Text('Calcular'),
                ),
                SizedBox(height: 20),
                Text('TABLA CON DATOS', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: column.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Posición: $index'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Valor: ${column[index]}'),
                            Text('Diferencia con solicitud: ${fufo[index]}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text('El total del tiempo es: $sumaTiempo', style: TextStyle(fontSize: 16)),
                Text('El promedio del tiempo es: ${promedio.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(VectorFufosApp());
}
