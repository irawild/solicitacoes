import 'package:flutter/material.dart';
import 'package:solicitacoes_desconto/entities/Solicitacao.dart';
import 'package:solicitacoes_desconto/services/SolicitacaoService.dart';
import 'package:intl/intl.dart';

class SolicitacaoDetailView extends StatelessWidget {
  final Solicitacao solicitacao;
  final SolicitacaoService service = SolicitacaoService();
  final NumberFormat formatter = NumberFormat("###########.00");
  final ValueChanged<bool> onCloseView;

  SolicitacaoDetailView({this.solicitacao, @required this.onCloseView});

  void _onCloseView() {
    onCloseView(true);
  }

  @override
  Widget build(BuildContext context) {
    double valorDesconto = solicitacao.valor * solicitacao.desconto / 100;
    double total = solicitacao.valor - valorDesconto;

    Future<void> _showMyDialog(String titulo, String mensagem) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(mensagem)],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Fechar'),
                onPressed: () {
                  _onCloseView();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _onAprovar() async {
      solicitacao.aprovado = true;
      await service.putSolicitacao(solicitacao);
      await _showMyDialog(
          'Desconto aprovado', 'O desconto foi aprovado com sucesso');
      Navigator.pop(context);
    }

    void _onReprovar() async {
      solicitacao.reprovado = true;
      await service.putSolicitacao(solicitacao);
      await _showMyDialog('Desconto reprovado', 'Você reprovou o desconto');
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Loja ${solicitacao.loja}'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Center(
              heightFactor: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '  ${solicitacao.atuacao}',
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            ),
            Center(
                heightFactor: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  Valor:',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '${formatter.format(solicitacao.valor)}  ',
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                )),
            Center(
                heightFactor: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  Desconto(%):',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '${formatter.format(solicitacao.desconto)}  ',
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                )),
            Center(
                heightFactor: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  Margem bruta(%):',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '${formatter.format(solicitacao.margemBruta)}  ',
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                )),
            const Divider(
              height: 20,
              thickness: 2,
              indent: 0,
              endIndent: 0,
            ),
            Center(
                heightFactor: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  Total:',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '${formatter.format(total)}  ',
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                )),
            const Divider(
              height: 20,
              thickness: 2,
              indent: 0,
              endIndent: 0,
            ),
            Center(
                heightFactor: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _onReprovar();
                      },
                      child: Container(
                        height: 40.0,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.red[500],
                        ),
                        child: Center(
                          child: Text(
                            'Reprovar',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _onAprovar();
                      },
                      child: Container(
                        height: 40.0,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.lightGreen[500],
                        ),
                        child: Center(
                          child: Text(
                            'Aprovar',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
