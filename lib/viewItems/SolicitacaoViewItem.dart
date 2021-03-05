import 'package:flutter/material.dart';
import 'package:solicitacoes_desconto/entities/Solicitacao.dart';
import 'package:intl/intl.dart';

class SolicitacaoViewItem extends StatelessWidget {
  final Solicitacao solicitacao;
  final ValueChanged<Solicitacao> onTapHandle;
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
                    child: Text('${solicitacao.loja}')),
                title: Text('${solicitacao.atuacao}'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Desconto: ${formatter.format(solicitacao.desconto)}%'),
                    Text('Valor: ${formatter.format(solicitacao.valor)}'),
                    //Text('>')
                  ],
                ),
              ),
            )));
  }
}
