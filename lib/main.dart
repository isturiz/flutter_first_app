// Mauricio Istúriz, 28.286.521
import 'package:flutter/material.dart';

void main() {
  runApp(FormularioApp());
}

class FormularioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormularioCapturaDatos(),
    );
  }
}

class FormularioCapturaDatos extends StatefulWidget {
  @override
  _FormularioCapturaDatosState createState() => _FormularioCapturaDatosState();
}

class _FormularioCapturaDatosState extends State<FormularioCapturaDatos> {
  bool trabaja = false;
  bool estudia = false;
  String genero = 'Masculino';
  bool activarNotificaciones = false;
  double precio = 0;
  DateTime fechaSeleccionada = DateTime.now();
  TimeOfDay horaSeleccionada = TimeOfDay.now();
  String estadoCivilSeleccionado = 'Soltero';
  final nombreController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de captura de datos'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/logoiujo.png',
              fit: BoxFit.contain,
            ),
            TextFormField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: trabaja,
                  onChanged: (value) {
                    setState(() {
                      trabaja = value!;
                    });
                  },
                ),
                Text('Trabaja'),
                Checkbox(
                  value: estudia,
                  onChanged: (value) {
                    setState(() {
                      estudia = value!;
                    });
                  },
                ),
                Text('Estudia'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Radio(
                  value: 'Masculino',
                  groupValue: genero,
                  onChanged: (value) {
                    setState(() {
                      genero = value.toString();
                    });
                  },
                ),
                Text('Masculino'),
                Radio(
                  value: 'Femenino',
                  groupValue: genero,
                  onChanged: (value) {
                    setState(() {
                      genero = value.toString();
                    });
                  },
                ),
                Text('Femenino'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Activar notificaciones'),
                Switch(
                  value: activarNotificaciones,
                  onChanged: (value) {
                    setState(() {
                      activarNotificaciones = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Precio: ${precio.toInt()}'),
            Slider(
              value: precio,
              onChanged: (value) {
                setState(() {
                  precio = value;
                });
              },
              min: 0,
              max: 100,
              divisions: 20,
              label: '${precio.toInt()}',
            ),
            SizedBox(height: 16),

            // Botón para seleccionar fecha // FECHA SÍ
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Introduzca la fecha",
              ),
              readOnly: true,
              onTap: () {
                _mostrarDatePicker(context);
              },
            ),

            TextField(
              controller: timeController,
              decoration: InputDecoration(
                icon: Icon(Icons.access_time),
                labelText: "Introduzca la hora",
              ),
              readOnly: true,
              onTap: () {
                _mostrarTimePicker(context);
              },
            ),

            // Estado civil
            DropdownButton<String>(
              value: estadoCivilSeleccionado,
              onChanged: (value) {
                setState(() {
                  estadoCivilSeleccionado = value!;
                });
              },
              items: ['Soltero', 'Casado', 'Viudo', 'Divorciado']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16),

            // Botones de enviar y cancelar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes realizar alguna acción con los datos capturados
                  },
                  child: Text('Enviar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes resetear los campos del formulario
                    nombreController.clear();
                    setState(() {
                      trabaja = false;
                      estudia = false;
                      genero = 'Masculino';
                      activarNotificaciones = false;
                      precio = 0;
                      estadoCivilSeleccionado = 'Soltero';
                      dateController.clear(); // Vaciar el controlador de fecha
                      timeController.clear(); // Vaciar el controlador de hora
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Background color
                  ),
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

   // Método para mostrar el DatePicker
   Future<void> _mostrarDatePicker(BuildContext context) async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: this.fechaSeleccionada ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
    );

    if (fechaSeleccionada != null) {
      setState(() {
        this.fechaSeleccionada = fechaSeleccionada;
        dateController.text =
            "${fechaSeleccionada.day.toString().padLeft(2, '0')}/${fechaSeleccionada.month.toString().padLeft(2, '0')}/${fechaSeleccionada.year.toString()}";
      });
    }
  }
   Future<void> _mostrarTimePicker(BuildContext context) async {
    final TimeOfDay? horaSeleccionada = await showTimePicker(
      context: context,
      initialTime: this.horaSeleccionada,
    );

    if (horaSeleccionada != null && horaSeleccionada != this.horaSeleccionada) {
      setState(() {
        this.horaSeleccionada = horaSeleccionada;
        timeController.text = horaSeleccionada.format(context);
      });
    }
  }
}
