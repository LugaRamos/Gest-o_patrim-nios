import 'package:flutter/material.dart';
import 'view/scanner_screen.dart';
import 'view/cadastrar_screen.dart';
import 'view/dados_screen.dart';
import 'view/dashboard_screen.dart';
import 'view/mapa_screen.dart';
import 'view/baixa_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Patrimônio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/scanner': (context) => ScannerScreen(),
        '/cadastrar': (context) => CadastrarScreen(),
        '/dados': (context) => DadosScreen(patrimonios: [], setores: [],),
        '/dashboard': (context) => DashboardScreen(),
        '/mapa': (context) => MapaScreen(),
        '/baixa': (context) => BaixaScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de Patrimônio'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          MenuButton('Scanner', Icons.qr_code_scanner, '/scanner'),
          MenuButton('Cadastrar', Icons.add, '/cadastrar'),
          MenuButton('Dados', Icons.data_usage, '/dados'),
          MenuButton('Dashboard', Icons.dashboard, '/dashboard'),
          MenuButton('Mapa', Icons.map, '/mapa'),
          MenuButton('Baixa', Icons.remove_circle, '/baixa'),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  MenuButton(this.title, this.icon, this.route);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 50),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
