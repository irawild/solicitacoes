class Solicitacao {
  final int id;
  final String cliente;
  final String atuacao;
  final double desconto;
  final String loja;
  final double valor;
  final double margemBruta;
  bool aprovado;
  bool reprovado;

  Solicitacao(this.id, this.cliente, this.desconto, this.atuacao, this.loja,
      this.valor, this.margemBruta, this.aprovado, this.reprovado);
}
