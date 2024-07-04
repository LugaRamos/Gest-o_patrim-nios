import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:excel/excel.dart';
import 'dart:io';

class CadastrarScreen extends StatefulWidget {
  @override
  _CadastrarScreenState createState() => _CadastrarScreenState();
}

class _CadastrarScreenState extends State<CadastrarScreen> {
  final _formKey = GlobalKey<FormState>();
  String nome = '';
  int quantidade = 0;
  String setor = '';
  String descricao = '';
  String latitude = '';
  String longitude = '';
  File? _image;

  final picker = ImagePicker();

  Future<void> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _getLocation();
      } else {
        print('No image selected.');
      }
    });
  }

void _submitForm() async {
  if (_formKey.currentState?.validate() == true) {
    _formKey.currentState?.save();

    // Crie um novo objeto Excel
    var excel = Excel.createExcel();

    // Adicione uma nova planilha para os patrimônios
    Sheet sheetObject = excel['Patrimonios'];

    // Obtenha os dados do formulário
    String nome = _nomeController.text;
    int quantidade = int.parse(_quantidadeController.text);
    String setor = _setorController.text;
    double latitude = double.parse(_latitudeController.text);
    double longitude = double.parse(_longitudeController.text);
    String descricao = _descricaoController.text;

    // Adicione os dados à planilha
    List<String> headers = ['Nome', 'Quantidade', 'Setor', 'Latitude', 'Longitude', 'Descrição'];
    sheetObject.appendRow(headers);
    sheetObject.appendRow([nome, quantidade.toString(), setor, latitude.toString(), longitude.toString(), descricao]);

    // Salve o arquivo Excel no armazenamento local
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/dados.xlsx';
    File(filePath).writeAsBytesSync(await excel.encode());

    // Exiba uma mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Patrimônio cadastrado com sucesso!')),
    );

    // Feche a tela de cadastro
    Navigator.pop(context);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Patrimônio'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  nome = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade';
                  }
                  return null;
                },
                onSaved: (value) {
                  quantidade = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Setor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o setor';
                  }
                  return null;
                },
                onSaved: (value) {
                  setor = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
                onSaved: (value) {
                  descricao = value!;
                },
              ),
              SizedBox(height: 10),
              _image == null
                  ? Text('Nenhuma imagem selecionada.')
                  : Image.file(_image!),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Tirar Foto'),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Latitude'),
                readOnly: true,
                controller: TextEditingController(text: latitude),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Longitude'),
                readOnly: true,
                controller: TextEditingController(text: longitude),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
