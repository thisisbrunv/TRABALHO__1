

class cliente {
  int? id;
  String? nome;
  String? email;
  
  cliente({
     this.id,
     this.nome,
     this.email
  });
  
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'Cliente { nome: $nome, email: $email}';
  }
}