

class cliente {
  int? id;
  String? nome;
  String? email;
  String? senha;
  String? foto;
  
  cliente({
     this.id,
     this.nome,
     this.email,
     this.senha,
     this.foto
  });
  
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'foto': foto,
    };
  }

  @override
  String toString() {
    return 'Cliente { nome: $nome, email: $email, senha: $senha, foto: $foto}';
  }
}