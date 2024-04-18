

class PrestServ {
  int? id;
  String? nome;
  String? email;
  int? telefone;
  String? servico;
  
  PrestServ({
     this.id,
     this.nome,
     this.email,
     this.telefone,
     this.servico
  });
  
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'servico': servico,
    };
  }

  @override
  String toString() {
    return 'Pessoa { nome: $nome, email: $email, telefone: $telefone, servico: $servico}';
  }
}