import 'package:flutter/material.dart';

class SetoresScreen extends StatelessWidget {
  final List<Map<String, String>> setores;

  const SetoresScreen({Key? key, required this.setores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setores'),
      ),
      body: ListView.builder(
        itemCount: setores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(setores[index]['nome']!),
            subtitle: Text(setores[index]['descricao']!),
            // Adicione aqui a navegação para detalhes do setor, se necessário
          );
        },
      ),
    );
  }
}
