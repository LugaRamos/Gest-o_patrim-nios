import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String barcode = '';

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        barcode = result.rawContent;
      });
      // Verificar se o patrimônio está cadastrado e exibir os dados ou a opção de cadastrar
    } catch (e) {
      setState(() {
        barcode = 'Falha na leitura do código de barras: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: scanBarcode,
              child: Text('Escanear Código de Barras'),
            ),
            SizedBox(height: 20),
            Text('Código de Barras: $barcode'),
            // Implementar lógica para exibir dados ou opção de cadastrar novo patrimônio
          ],
        ),
      ),
    );
  }
}
