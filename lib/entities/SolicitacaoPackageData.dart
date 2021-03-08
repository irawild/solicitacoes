import 'package:solicitacoes_desconto/entities/Solicitacao.dart';

class SolicitacaoPackageData {
  final int id;
  final int idConfirmacaoDeposito;
  bool aprovado;
  bool reprovado;
  String jsonData;
  Solicitacao solicitacao;

  SolicitacaoPackageData(this.id, this.idConfirmacaoDeposito, this.aprovado,
      this.reprovado, this.jsonData);
}
