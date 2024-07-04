import 'package:flutter/material.dart';

class PatrimoniosScreen extends StatelessWidget {
  final List<Map<String, String>> patrimonios;

  const PatrimoniosScreen({Key? key, required this.patrimonios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrimônios'),
      ),
      body: ListView.builder(
        itemCount: patrimonios.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(patrimonios[index]['nome']!),
            subtitle: Text('Quantidade: ${patrimonios[index]['quantidade']}'),
            // Adicione aqui a navegação para detalhes do patrimônio, se necessário
          );
        },
      ),
    );
  }
}
