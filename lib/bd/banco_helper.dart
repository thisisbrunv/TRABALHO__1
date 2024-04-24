import 'dart:async';
import 'package:trab_1/model/PrestServ.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trab_1/model/Servico.dart';
import 'package:trab_1/model/cliente.dart';

class BancoHelper {
  static const arquivoDoBancoDeDados = 'nossoBD.db';
  static const arquivoDoBancoDeDadosVersao = 1;

  //pagina prestador de serviço

  static const tabela = 'prestadorServico';
  static const colunaIdPSer = 'id';
  static const colunaNomePSer = 'nome';
  static const colunaEmailPSer = 'email';
  static const colunaTelefonePSer = 'telefone';
  
  //pagina serviço

  static const tabelaServ = 'servico';
  static const colunaIdServ = 'id';
  static const colunaNomeServ = 'nome';


  //pagina cliente

  static const tabelaC = 'cliente';
  static const colunaIdCliente = 'id';
  static const colunaNomeCliente = 'nome';
  static const colunaEmailCliente = 'email';

  static Database? _database;

   // Aplicação do padrão Singleton na classe.
  BancoHelper._privateConstructor();
  static final BancoHelper instance = BancoHelper._privateConstructor();

  // Configurar a intância única da classe. 
  // Abre a base de dados (e cria quando ainda não existir).
  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await iniciarBD();
    return _database!;
  }

  iniciarBD() async {
    String caminhoBD = await getDatabasesPath();
    String path = join(caminhoBD, arquivoDoBancoDeDados);

    // Retorna o bd
    return await openDatabase(
        path,
        version: arquivoDoBancoDeDadosVersao, 
        onCreate: funcaoCriacaoBD, 
        onUpgrade: funcaoAtualizarBD, 
        onDowngrade: funcaoDowngradeBD);
  }

  Future funcaoCriacaoBD(Database db, int version) async {
    
    await db.execute('''
        CREATE TABLE $tabela (
          $colunaIdPSer INTEGER PRIMARY KEY,
          $colunaNomePSer TEXT, 
          $colunaEmailPSer TEXT,
          $colunaTelefonePSer INTEGER
        );
        ''');
       await db.execute(''' 
       CREATE TABLE $tabelaServ (
          $colunaIdServ INTEGER PRIMARY KEY,
          $colunaNomeServ TEXT
          );
           ''');
      await db.execute(''' 
        CREATE TABLE $tabelaC (
          $colunaIdCliente INTEGER PRIMARY KEY,
          $colunaNomeCliente TEXT,
          $colunaEmailCliente TEXT 
        );
  ''');
  }

  Future funcaoAtualizarBD(Database db, int oldVersion, int newVersion) async {
    //controle dos comandos sql para novas versões
    
    if (oldVersion < 2) {
      //Executa comandos  
    }
    
  }

  Future funcaoDowngradeBD(Database db, int oldVersion, int newVersion) async {
    //controle dos comandos sql para voltar versãoes. 
    //Estava-se na 2 e optou-se por regredir para a 1
  }

  Future<int> inserir(Map<String, dynamic> row) async {
    Database db = await iniciarBD();
    return await db.insert(tabela, row);
  }

Future<int> inserirServ(Map<String, dynamic> row) async {
    Database db = await iniciarBD();
    return await db.insert(tabelaServ, row);
  }

Future<int> inserirCliente(Map<String, dynamic> row) async {
    Database db = await iniciarBD();
    return await db.insert(tabelaC, row);
  }

  Future<int> deletarTodos() async {
    Database db = await iniciarBD();
    return db.delete(tabela);
  }

  Future<int> deletar(int idPSer) async {
    Database db = await iniciarBD();
    return db.delete(tabela, where: '$colunaIdPSer = ?', whereArgs: [idPSer]);
  }

 Future<int> deletarServ(int idServ) async {
    Database db = await iniciarBD();
    return db.delete(tabelaServ, where: '$colunaIdServ = ?', whereArgs: [idServ]);
  }

  Future<int> deletarC(int idCliente) async {
    Database db = await iniciarBD();
    return db.delete(tabelaC, where: '$colunaIdCliente= ?', whereArgs: [idCliente]);
  }

  Future<List<PrestServ>> buscarPrestServ() async {
    Database db = await iniciarBD();
    
    final List<Map<String, Object?>> prestServNoBanco =
        await db.query(tabela);

    return [
      for (final {
            colunaIdPSer: pIdPSer as int,
            colunaNomePSer: pNomePS as String,
            colunaEmailPSer: pEmailPS as String,
            colunaTelefonePSer: pTelefonePS as int
          } in prestServNoBanco)
        PrestServ(id: pIdPSer, nome: pNomePS, email: pEmailPS, telefone: pTelefonePS),
   ];
  }

  Future<List<Servico>> buscarServ() async {
    Database db = await iniciarBD();
    
    final List<Map<String, Object?>> ServNoBanco =
        await db.query(tabelaServ);

    return [
      for (final {
            colunaIdServ: pIdSer as int,
            colunaNomeServ: pNomeS as String
          } in ServNoBanco)
       Servico(id: pIdSer, nome: pNomeS),
   ];
  }

  Future<List<cliente>> buscarCliente() async {
    Database db = await iniciarBD();
    
    final List<Map<String, Object?>> ClienteNoBanco =
        await db.query(tabelaC);

    return [
      for (final {
            colunaIdCliente: pIdCliente as int,
            colunaNomeCliente: pNomeCli as String,  
            colunaEmailCliente: pEmailCli as String
          } in ClienteNoBanco)
       cliente(id: pIdCliente, nome: pNomeCli, email: pEmailCli),
   ];
  }

  Future<void> editar(PrestServ regPessoa) async {
    Database db = await iniciarBD();

    await db.update(
      tabela,
      regPessoa.toMap(),
      where: '$colunaIdPSer = ?',
      whereArgs: [regPessoa.id],
    );
  }
  Future<void> editarServ(Servico regServico) async {
    Database db = await iniciarBD();

    await db.update(
      tabelaServ,
      regServico.toMap(),
      where: '$colunaIdServ = ?',
      whereArgs: [regServico.id],
    );
  }
   Future<void> editarCli(cliente regCli) async {
    Database db = await iniciarBD();

    await db.update(
      tabelaC,
      regCli.toMap(),
      where: '$colunaIdCliente = ?',
      whereArgs: [regCli.id],
    );
  }
  
  Future<List<Servico>> queryByName(String nome) async {
    Database db = await iniciarBD();

    List<Map<String, dynamic>> help = await db.query(tabelaServ, where: '$colunaNomeServ = ?', whereArgs: [nome]);

    return List.generate(help.length, (index) {
      return Servico(
        id: help[index]['id'],
        nome: help[index]['nome'],
      );
    });
  }
}
