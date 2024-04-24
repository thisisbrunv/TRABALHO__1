import 'package:flutter/material.dart';
import 'package:teste/model/PrestServ.dart';
class MyApp extends StatelessWidget {
  final List<PrestServ> prestadores = [
    PrestServ(id: 1, nome: 'João', email: 'joao@example.com', telefone: 123456789, servico: 'Encanador'),
    PrestServ(id: 2, nome: 'Maria', email: 'maria@example.com', telefone: 987654321, servico: 'Eletricista'),
    PrestServ(id: 3, nome: 'Pedro', email: 'pedro@example.com', telefone: 111111111, servico: 'Pintor'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prestadores de Serviço',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrestadoresScreen(prestadores: prestadores),
    );
  }
}

class PrestadoresScreen extends StatelessWidget {
  final List<PrestServ> prestadores;

  PrestadoresScreen({required this.prestadores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prestadores de Serviço'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BarraPesquisa(prestadores: prestadores)),
                  );
                },
                child: Text('Ir para Pesquisa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BarraPesquisa extends StatelessWidget {
  final List<PrestServ> prestadores;

  BarraPesquisa({required this.prestadores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barra de Pesquisa'),
      ),
      body: Center(
        child: Text(
          'Esta é a tela da barra de pesquisa!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}