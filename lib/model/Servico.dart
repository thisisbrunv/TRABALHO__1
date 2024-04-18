class Servico {
  int? id;
  String? nome;

  Servico({
     this.id,
     this.nome
  });
  
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  @override
  String toString() {
    return 'Serviço { nome: $nome}';
  }
}