
import 'package:trab_1/bd/banco_helper.dart';
import 'package:trab_1/model/Servico.dart';
import 'package:flutter/material.dart';


class ServDetalhe extends StatefulWidget {
  const ServDetalhe({super.key, required this.informacaoServ});

  final Servico? informacaoServ;

  @override
  State<ServDetalhe> createState() => _ServDetalheState();
}

class _ServDetalheState extends State<ServDetalhe> {
  final TextEditingController _controllerIdServ = TextEditingController();
  final TextEditingController _controllerNomeServ = TextEditingController();
  final TextEditingController _controllerCategoriaServ = TextEditingController();
  final TextEditingController _controllerDescServ = TextEditingController();
  final TextEditingController _controllerPrecoServ = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var bdHelper = BancoHelper.instance;

  @override
  void initState() {
    super.initState();

    if (widget.informacaoServ != null) {
      _controllerIdServ.text = widget.informacaoServ?.id.toString() ?? '';
      _controllerNomeServ.text = widget.informacaoServ?.nome ?? '';
      _controllerCategoriaServ.text = widget.informacaoServ?.categoria ?? '';
      _controllerDescServ.text = widget.informacaoServ?.descricao ?? '';
      _controllerPrecoServ.text = widget.informacaoServ?.preco.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _controllerIdServ.dispose();
    _controllerNomeServ.dispose();
    _controllerCategoriaServ.dispose();
    _controllerDescServ.dispose();
    _controllerPrecoServ.dispose();
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
                  controller: _controllerIdServ,
                  decoration: const InputDecoration(
                      labelText: 'Identificador',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _controllerNomeServ,
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
                TextFormField(
                  controller: _controllerCategoriaServ,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: 'Categoria',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor preencha um valor para o campo categoria.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerDescServ,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: 'Descricao',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                ),
                TextFormField(
                  controller: _controllerPrecoServ,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Preco',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.informacaoServ != null) {
                        widget.informacaoServ?.nome = _controllerNomeServ.text;
                        widget.informacaoServ?.categoria = _controllerCategoriaServ.text;
                        widget.informacaoServ?.descricao = _controllerDescServ.text;
                        widget,informacaoServ?.preco = _controllerPrecoServ.Text;
                        await bdHelper.editarServ(widget.informacaoServ!);
                      } else {
                        Map<String, dynamic> row = {
                          BancoHelper.colunaNomeServ: _controllerNomeServ.text,
                          BancoHelper.colunaCategoriaServ: _controllerCategoriaServ.text,
                          BancoHelper.colunaDescricaoServ: _controllerDescServ.text,
                          BancoHelper.colunaPrecoServ: _controllerPrecoServ.text
                        };
        
                        final idEmOperacao = await bdHelper.inserirServ(row);
                        _controllerIdServ.text = idEmOperacao.toString();
                      }
                    }
                  },
                  child: const Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    bdHelper.deletarServ(int.parse(_controllerIdServ.text));
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