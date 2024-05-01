

class PrestServ {
  int? id;
  String? nome;
  String? email;
  int? telefone;
  //String? servico;
  String? senha;
  int? avaliacao;
  String? foto;
  
  PrestServ({
     this.id,
     this.nome,
     this.email,
     this.telefone,
     this.senha, 
     this.avaliacao,
     this.foto
  });
  
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      //'servico': servico,
      'senha': senha,
      'avaliacao': avaliacao,
      'foto': foto,
    };
  }

  @override
  String toString() {
    return 'Pessoa { nome: $nome, email: $email, telefone: $telefone, senha: $senha, avaliacao: $avaliacao, foto: $foto}';
  }
}