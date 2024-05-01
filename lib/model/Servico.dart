class Servico {
  int? id;
  String? nome;
  String? categoria;
  String? descricao;
  int? preco;

  Servico({
     this.id,
     this.nome,
     this.categoria,
     this.descricao,
     this.preco
  });
  
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'descricao': descricao,
      'preco': preco,
    };
  }

  @override
  String toString() {
    return 'Serviço { nome: $nome, categoria: $categoria, descricao: $descricao, preco: $preco}';
  }
}