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
  static const tipoServ = 'tipoServ';


  //pagina serviço

  static const tabelaServ = 'servico';
  static const colunaIdServ = 'id';
  static const colunaNomeServ = 'nome';


  //pagina cliente

  static const tabelaC = 'cliente';
  static const colunaIdCliente = 'id';
  static const colunaNomeCliente = 'nome';
  static const colunaEmailCliente = 'email';

  static late Database _bancoDeDados;

  iniciarBD() async {
    String caminhoBD = await getDatabasesPath();
    String path = join(caminhoBD, arquivoDoBancoDeDados);

    _bancoDeDados = await openDatabase(path,
        version: arquivoDoBancoDeDadosVersao, 
        onCreate: funcaoCriacaoBD, 
        onUpgrade: funcaoAtualizarBD, 
        onDowngrade: funcaoDowngradeBD);
  }

  Future funcaoCriacaoBD(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tabela (
          $colunaIdPSer INTEGER PRIMARY KEY,
          $colunaNomePSer TEXT NOT NULL,
          $colunaEmailPSer TEXT NOT NULL,
          $colunaTelefonePSer INTEGER
        );
        ''');
       await db.execute(''' 
       CREATE TABLE $tabelaServ (
          $colunaIdServ INTEGER PRIMARY KEY,
          $colunaNomeServ TEXT NOT NULL
          );
           ''');
  await db.execute(''' 
        CREATE TABLE $tabelaC (
          $colunaIdCliente INTEGER PRIMARY KEY,
          $colunaNomeCliente TEXT NOT NULL,
          $colunaEmailCliente TEXT NOT NULL
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
    await iniciarBD();
    return await _bancoDeDados.insert(tabela, row);
  }

  Future<int> deletarTodos() async {
    await iniciarBD();
    return _bancoDeDados.delete(tabela);
  }

  Future<int> deletar(int idPSer) async {
    await iniciarBD();
    return _bancoDeDados.delete(tabela, where: '$colunaIdPSer = ?', whereArgs: [idPSer]);
  }

 Future<int> deletarServ(int idServ) async {
    await iniciarBD();
    return _bancoDeDados.delete(tabelaServ, where: '$colunaIdServ = ?', whereArgs: [idServ]);
  }

  Future<int> deletarC(int idCliente) async {
    await iniciarBD();
    return _bancoDeDados.delete(tabelaC, where: '$colunaIdCliente= ?', whereArgs: [idCliente]);
  }

  Future<List<PrestServ>> buscarPrestServ() async {
    await iniciarBD();
    
    final List<Map<String, Object?>> prestServNoBanco =
        await _bancoDeDados.query(tabela);

    return [
      for (final {
            colunaIdPSer: pIdPS as int,
            colunaNomePSer: pNomePS as String,
            colunaEmailPSer: pEmailPS as String,
            colunaTelefonePSer: pTelefonePS as int
          } in prestServNoBanco)
        PrestServ(id: pIdPS, nome: pNomePS, email: pEmailPS, telefone: pTelefonePS),
   ];
  }

  Future<List<Servico>> buscarServ() async {
    await iniciarBD();
    
    final List<Map<String, Object?>> ServNoBanco =
        await _bancoDeDados.query(tabelaServ);

    return [
      for (final {
            colunaIdServ: pIdS as int,
            colunaNomeServ: pNomeS as String
          } in ServNoBanco)
       Servico(id: pIdS, nome: pNomeS),
   ];
  }

  Future<List<cliente>> buscarCliente() async {
    await iniciarBD();
    
    final List<Map<String, Object?>> ClienteNoBanco =
        await _bancoDeDados.query(tabelaC);

    return [
      for (final {
            colunaIdCliente: pIdCli as int,
            colunaNomeServ: pNomeCli as String
          } in ClienteNoBanco)
       cliente(id: pIdCli, nome: pNomeCli),
   ];
  }

  Future<void> editar(PrestServ regPessoa) async {
    await iniciarBD();

    await _bancoDeDados.update(
      tabela,
      regPessoa.toMap(),
      where: '$colunaIdPSer = ?',
      whereArgs: [regPessoa.id],
    );
  }
  Future<void> editarServ(Servico regServico) async {
    await iniciarBD();

    await _bancoDeDados.update(
      tabelaServ,
      regServico.toMap(),
      where: '$colunaIdServ = ?',
      whereArgs: [regServico.id],
    );
  }
   Future<void> editarCli(cliente regCli) async {
    await iniciarBD();

    await _bancoDeDados.update(
      tabelaC,
      regCli.toMap(),
      where: '$colunaIdCliente = ?',
      whereArgs: [regCli.id],
    );
  }
}
