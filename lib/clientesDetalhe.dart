
import 'package:trab_1/bd/banco_helper.dart';
import 'package:flutter/material.dart';
import 'package:trab_1/model/cliente.dart';


class ClienteDetalhe extends StatefulWidget {
  const ClienteDetalhe({super.key, required this.informacaoCliente});

  final cliente? informacaoCliente;

  @override
  State<ClienteDetalhe> createState() => _ClienteDetalheState();
}

class _ClienteDetalheState extends State<ClienteDetalhe> {
  final TextEditingController _controllerIdCliente = TextEditingController();
  final TextEditingController _controllerNomeCliente = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var bdHelper = BancoHelper();

  @override
  void initState() {
    super.initState();

    if (widget.informacaoCliente != null) {
      _controllerIdCliente.text = widget.informacaoCliente?.id.toString() ?? '';
      _controllerNomeCliente.text = widget.informacaoCliente?.nome ?? '';
    }
  }

  @override
  void dispose() {
    _controllerIdCliente.dispose();
    _controllerNomeCliente.dispose();
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
                  controller: _controllerIdCliente,
                  decoration: const InputDecoration(
                      labelText: 'Identificador',
                      border: OutlineInputBorder() //Gera a borda toda no campo.
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _controllerNomeCliente,
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
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.informacaoCliente != null) {
                        widget.informacaoCliente?.nome = _controllerNomeCliente.text;
                        await bdHelper.editarCli(widget.informacaoCliente!);
                      } else {
                        Map<String, dynamic> row = {
                          BancoHelper.colunaNomeCliente: _controllerNomeCliente.text
                        };
        
                        final idEmOperacao = await bdHelper.inserir(row);
                        _controllerIdCliente.text = idEmOperacao.toString();
                      }
                    }
                  },
                  child: const Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    bdHelper.deletarC(int.parse(_controllerIdCliente.text));
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