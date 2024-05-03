import 'package:trab_1/ServDetalhe.dart';
import 'package:trab_1/bd/banco_helper.dart';
import 'package:trab_1/clientesDetalhe.dart';
import 'package:trab_1/model/PrestServ.dart';
import 'package:trab_1/model/Servico.dart';
import 'package:trab_1/model/cliente.dart';
import 'package:trab_1/pessoa_detalhe.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MainApp());
// runApp(const MainApp());
//}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  var bdHelper = BancoHelper.instance;
  
  final List<PrestServ> _dados = [];
  final List<Servico> _dadosServ = [];
  final List<cliente> _dadosCliente = [];

  void carregarPessoasSalvas() async {
    var r = await bdHelper.buscarPrestServ();

    setState(() {
      _dados.clear();
      _dados.addAll(r);
    });
  }

void carregarServicosSalvos() async {
    var s = await bdHelper.buscarServ();

setState(() {
  _dadosServ.clear();
  _dadosServ.addAll(s);
});
}

void carregarClientesSalvos() async {
    var t = await bdHelper.buscarCliente();
    setState(() {
      _dadosCliente.clear();
        _dadosCliente.addAll(t);

    });
}
  
  Future<void> inserirRegistro() async {
    var rnd = Random();

    final nomePS = 'PrestServ ${rnd.nextInt(999999)}';
    final emailPS = 'PrestServ ${rnd.nextInt(999999)}';
    final telefonePS = rnd.nextInt(99);
    final senhaPS = 'PrestServ ${rnd.nextInt(999999)}';
    final avaliacaoPS = rnd.nextInt(99);
    final fotoPS = 'PrestServ ${rnd.nextInt(999999)}';
    

    Map<String, dynamic> row = {
      BancoHelper.colunaNomePSer: nomePS,
      BancoHelper.colunaEmailPSer: emailPS,
      BancoHelper.colunaTelefonePSer: telefonePS,
      BancoHelper.colunaSenhaPSer: senhaPS,
      BancoHelper.colunaAvaliacaoPSer: avaliacaoPS,
      BancoHelper.colunaFotoPSer: fotoPS
    };

    final id = await bdHelper.inserir(row);

    print(
        'Pessoa inserida com ID $id para $nomePS');

    carregarPessoasSalvas();
  }

  Future<void> inserirRegistroServ() async {
    var rnd = Random();

    final nomeServ = 'Serv ${rnd.nextInt(999999)}';
    final categoriaServ = 'Serv ${rnd.nextInt(999999)}';
    final descricaoServ = 'Serv ${rnd.nextInt(999999)}';
    final precoServ = rnd.nextInt(99);
  
    Map<String, dynamic> row = {
      BancoHelper.colunaNomeServ: nomeServ,
      BancoHelper.colunaCategoriaServ: categoriaServ,
      BancoHelper.colunaDescricaoServ: descricaoServ,
      BancoHelper.colunaPrecoServ: precoServ
    };

    final id = await bdHelper.inserir(row);

    print(
        'Pessoa inserida com ID $id para $nomeServ');

    carregarServicosSalvos();
  }

  Future<void> inserirRegistroCliente() async {
    var rnd = Random();

    final nomeCliente = 'cliente ${rnd.nextInt(999999)}';
    final emailCliente = 'cliente ${rnd.nextInt(999999)}';
    final senhaCliente = 'cliente ${rnd.nextInt(999999)}';
    final fotoCliente = 'cliente ${rnd.nextInt(999999)}';
    

    Map<String, dynamic> row = {
      BancoHelper.colunaNomeCliente: nomeCliente,
      BancoHelper.colunaEmailCliente: emailCliente,
      BancoHelper.colunaSenhaCliente: senhaCliente,
      BancoHelper.colunaFotoCliente: fotoCliente
    };

    final id = await bdHelper.inserir(row);

    print(
        'Pessoa inserida com ID $id para $nomeCliente');

    carregarClientesSalvos();
  }

  void removerTudo() async {
    await bdHelper.deletarTodos();
    carregarPessoasSalvas();
    }

  @override
  void initState() {
    super.initState();
    carregarPessoasSalvas();
    carregarServicosSalvos();
    carregarClientesSalvos();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aplicativo de Prestação de Serviço'),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SearchForm(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _dados.length, 
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_dados[index].nome ?? 'Nome não informado'),
                        //Função do click/Toque
                        onTap: () async {
                          var param = _dados[index];
                         await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PessoaDetalhePS(
                                informacaoPessoaPS: param))
                              );
                              carregarPessoasSalvas();
                        },
                      );
                    },
                  ),
                ),
                Expanded(child: ListView.builder(
                  itemCount: _dadosServ.length,
                  itemBuilder: (context, index){
                      return ListTile(
                        title: Text(_dadosServ[index].nome ?? "Serviço não informado"),
                        //toque
                        onTap: () async {
                          var param = _dadosServ[index];
                         await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServDetalhe(
                                informacaoServ: param))
                              );
                              carregarServicosSalvos();
                        },
                      );
                })
                ), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          removerTudo();
                        },
                        child: const Text('Deletar Tudo')),
                ],
                ),
                Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
ElevatedButton(
  onPressed: (){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Builder( 
            builder: (BuildContext context) {
              return const ServDetalhe(
                informacaoServ: null,
              );
            },
          );
        },
      ),
    ).then((value) {
      carregarServicosSalvos();
    });
  },
  child: const Text('Adicionar Serviço'),
)
                  ]
                ),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
ElevatedButton(
  onPressed: (){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Builder( 
            builder: (BuildContext context) {
              return const ClienteDetalhe(
                informacaoCliente: null,
              );
            },
          );
        },
      ),
    ).then((value) {
      carregarClientesSalvos();
    });
  },
  child: const Text('Adicionar Cliente'),
)
                  ]
                ), 
                    /* Row( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
ElevatedButton(
  onPressed: (){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Builder( 
            builder: (BuildContext context) {
              return const CameraScreen(
                informacaoServ: null,
              );
            },
          );
        },
      ),
    );
  },
  child: const Text('Adicionar Foto'),
)
                  ]
                ),*/
              ],
            ),    
        ), 
        ),
       floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              child: const Icon(Icons.person_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PessoaDetalhePS(
                      informacaoPessoaPS: null,
                    ),
                  ),
                ).then((value) {
                  carregarPessoasSalvas();
                });
              },
            );
          },
        ),
        ),
    );
    }
}
class SearchResultScreen extends StatelessWidget {
  final String searchTerm;

  const SearchResultScreen({super.key, required this.searchTerm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados da busca'),
      ),
      body: FutureBuilder<List<Servico>>(
        future: BancoHelper.instance.queryByName(searchTerm),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Servico> data= snapshot.data!;
            print(data);
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final serv = data[index];
                return ListTile(
                  title: Text(serv.nome!),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Fechar'))
    );
  }
}
/*class SearchResultScreen extends StatelessWidget {
  final String searchTerm;

  const SearchResultScreen({Key? key, required this.searchTerm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados da busca'),
      ),
      body: FutureBuilder<List<Servico>>(
        future: BancoHelper.instance.queryByName(searchTerm),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Servico> data = snapshot.data!;
            print(data);
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final serv = data[index];
                return ListTile(
                  title: Text(serv.nome!),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Navegar para a tela do perfil com as informações do serviço
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceProfileScreen(servico: serv),
                        ),
                      );
                    },
                    child: const Text('Ver perfil'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}*/

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchFormState createState() => _SearchFormState();
}


class _SearchFormState extends State<SearchForm> {
  final TextEditingController controller = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Procurar por serviço',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  // Usar o texto do campo
                  builder: (context) => SearchResultScreen(searchTerm: controller.text.trim()),
                ),
              );
            },
            child: const Text('Busca'),
          ),
        ],
      ),
    );
  }
}

/*class ServiceProfileScreen extends StatelessWidget {
  final Servico servico;

  const ServiceProfileScreen({Key? key, required this.servico}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(servico.nome!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categoria: ${servico.categoria}'),
            Text('Descrição: ${servico.descricao}'),
            Text('Preço: ${servico.preco}'),
          ],
        ),
      ),
    );
  }
}*/