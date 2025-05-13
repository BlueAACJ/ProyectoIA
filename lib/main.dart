import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(DigitalizadorApp());
}

class DigitalizadorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digitalizador de Lista',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: OCRHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OCRHomePage extends StatefulWidget {
  @override
  _OCRHomePageState createState() => _OCRHomePageState();
}

class _OCRHomePageState extends State<OCRHomePage> {
  File? _image;
  String _ocrResultado = 'Aquí se mostrará el texto reconocido.';

  Future<void> _tomarFoto() async {
    final picker = ImagePicker();
    final XFile? foto = await picker.pickImage(source: ImageSource.camera);

    if (foto != null) {
      setState(() {
        _image = File(foto.path);
        _ocrResultado = 'Procesando imagen...';
      });

      // Simulación de procesamiento (aquí irá luego el OCR real)
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _ocrResultado = '''
📅 Fecha: 19/04/2025

👨‍🎓 Lista de Estudiantes:
- Juan Pérez
- Ana Gómez
- Carlos Rivas
- Marta Díaz
- Luis Hernández
        ''';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digitalizador de Lista')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image != null
                ? Image.file(_image!)
                : Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[300],
                    child: Icon(Icons.camera_alt, size: 100, color: Colors.grey[700]),
                  ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _tomarFoto,
              icon: Icon(Icons.camera_alt),
              label: Text('Tomar Foto'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _ocrResultado,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
