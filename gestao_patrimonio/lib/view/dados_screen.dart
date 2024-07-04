import 'package:flutter/material.dart';
import 'setores_sreen.dart';
import 'patrimonio_screen.dart';

class DadosScreen extends StatelessWidget {
  final List<Map<String, String>> patrimonios;
  final List<Map<String, String>> setores;

  const DadosScreen({Key? key, required this.patrimonios, required this.setores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Setores'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SetoresScreen(setores: setores)),
              );
            },
          ),
          ...setores.map((setor) => ListTile(
            title: Text(setor['nome']!),
            subtitle: Text(setor['descricao']!),
          )),
          ListTile(
            title: Text('Patrimônios'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatrimoniosScreen(patrimonios: patrimonios)),
              );
            },
          ),
          ...patrimonios.map((patrimonio) => ListTile(
            title: Text(patrimonio['nome']!),
            subtitle: Text('Quantidade: ${patrimonio['quantidade']}'),
          )),
        ],
      ),
    );
  }
}
