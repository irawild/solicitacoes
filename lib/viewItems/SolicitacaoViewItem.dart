import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solicitacoes_desconto/entities/SolicitacaoPackageData.dart';

class SolicitacaoViewItem extends StatelessWidget {
  final SolicitacaoPackageData solicitacao;
  final ValueChanged<SolicitacaoPackageData> onTapHandle;
  final NumberFormat formatter = NumberFormat("###########.00");

  SolicitacaoViewItem({this.solicitacao, @required this.onTapHandle});

  void _handleTap() {
    onTapHandle(solicitacao);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
        onTap: _handleTap,
        child: Container(
            height: 80,
            color: Colors.white54,
            child: Container(
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.yellow,
                    child: Text('${solicitacao.solicitacao.loja}')),
                title: Text('${solicitacao.solicitacao.atuacao}'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Desconto: ${formatter.format(solicitacao.solicitacao.desconto)}%'),
                    Text(
                        'Valor: ${formatter.format(solicitacao.solicitacao.valor)}'),
                    //Text('>')
                  ],
                ),
              ),
            )));
  }
}
