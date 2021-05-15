enum TipoPessoa { fisica, juridica }

extension TipoPessoaDescricao on TipoPessoa {
  String get descricao {
    switch (this) {
      case TipoPessoa.fisica:
        return "Fisica";
      case TipoPessoa.juridica:
        return "Jurídica";
    }
  }
}
