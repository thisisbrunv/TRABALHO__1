

import 'package:trab_1/bd/banco_helper.dart';
import 'package:trab_1/model/PrestServ.dart';
import 'package:flutter/material.dart';

class PessoaDetalhePS extends StatefulWidget {
  const PessoaDetalhePS({super.key, required this.informacaoPessoaPS});

  final PrestServ? informacaoPessoaPS;

  @override
  State<PessoaDetalhePS> createState() => _PessoaDetalheState();
}

class _PessoaDetalheState extends State<PessoaDetalhePS> {
  final TextEditingController _controllerIdPS = TextEditingController();
  final TextEditingController _controllerNomePS = TextEditingController();
  final TextEditingController _controllerEmailPS = TextEditingController();
  final TextEditingController _controllerTelefonePS = TextEditingController();
  final TextEditingController _controllerSenhaPS = TextEditingController();
  final TextEditingController _controllerAvaliacaoPS = TextEditingController();
  final TextEditingController _controllerFotoPS = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var bdHelper = BancoHelper.instance;

  @override
  void initState() {
    super.initState();

    if (widget.informacaoPessoaPS != null) {
      _controllerIdPS.text = widget.informacaoPessoaPS?.id.toString() ?? '';
      _controllerNomePS.text = widget.informacaoPessoaPS?.nome ?? '';
      _controllerEmailPS.text = widget.informacaoPessoaPS?.email ?? '';
      _controllerTelefonePS.text = widget.informacaoPessoaPS?.telefone.toString() ?? '';
      _controllerSenhaPS.text = widget.informacaoPessoaPS?.senha ?? '';
      _controllerAvaliacaoPS.text = widget.informacaoPessoaPS?.avaliacao.toString() ?? '';
      _controllerFotoPS.text = widget.informacaoPessoaPS?.foto ?? '';
    }
  }

  @override
  void dispose() {
    _controllerIdPS.dispose();
    _controllerNomePS.dispose();
    _controllerEmailPS.dispose();
    _controllerTelefonePS.dispose();
    _controllerSenhaPS.dispose();
    _controllerAvaliacaoPS.dispose();
    _controllerFotoPS.dispose();
    super.dispose();
  }

  //Função para criar os textos e não repetir todo o conteudo todas as vezes.
  Widget criarComponenteTexto(String conteudo) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.purple,
      ),
      child: Text(conteudo,
          style: const TextStyle(
              decoration: TextDecoration.none,
              fontSize: 20,
              color: Colors.amber)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  readOnly: true,
                  controller: _controllerIdPS,
                  decoration: const InputDecoration(
                      labelText: 'Identificador',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _controllerNomePS,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor preencha um valor para o campo nome.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _controllerEmailPS,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'É obrigatório informar o e-mail.';
                    }
                    return null;
                  },
                 ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _controllerTelefonePS,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Telefone',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'É obrigatório informar o telefone.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerSenhaPS,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'É obrigatório informar a Senha.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerAvaliacaoPS,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Avaliacao',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                ),
                 TextFormField(
                  controller: _controllerAvaliacaoPS,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: 'Foto',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.informacaoPessoaPS != null) {
                        widget.informacaoPessoaPS?.nome = _controllerNomePS.text;
                        widget.informacaoPessoaPS?.email = _controllerEmailPS.text;
                        widget.informacaoPessoaPS?.telefone =
                            int.parse(_controllerTelefonePS.text);
                        widget.informacaoPessoaPS?.senha = _controllerSenhaPS.text;
                        widget.informacaoPessoaPS?.avaliacao = 
                            int.parse(_controllerAvaliacaoPS.text);
                        widget.informacaoPessoaPS?.foto = _controllerFotoPS.text;   
                        await bdHelper.editar(widget.informacaoPessoaPS!);
                      } else {
                        Map<String, dynamic> row = {
                          BancoHelper.colunaNomePSer: _controllerNomePS.text,
                          BancoHelper.colunaEmailPSer: _controllerEmailPS.text,
                          BancoHelper.colunaTelefonePSer: _controllerTelefonePS.text,
                          BancoHelper.colunaSenhaPSer: _controllerSenhaPS.text,
                          BancoHelper.colunaAvaliacaoPSer: _controllerAvaliacaoPS.text,
                          BancoHelper.colunaFotoPSer: _controllerFotoPS
                        };
        
                        final idEmOperacao = await bdHelper.inserir(row);
                        _controllerIdPS.text = idEmOperacao.toString();
                      }
                    }
                  },
                  child: const Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    bdHelper.deletar(int.parse(_controllerIdPS.text));
                    Navigator.pop(context);
                  },
                  child: const Text('Deletar')
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Fechar'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}