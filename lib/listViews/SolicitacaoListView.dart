import 'package:flutter/material.dart';
import 'package:solicitacoes_desconto/entities/Solicitacao.dart';
import 'package:solicitacoes_desconto/services/SolicitacaoService.dart';
import 'package:solicitacoes_desconto/viewItems/SolicitacaoViewItem.dart';
import 'package:solicitacoes_desconto/views/SolicitacaoDetailView.dart';

class SolicitacaoListView extends StatefulWidget {
  final SolicitacaoService solicitacaoService = SolicitacaoService();

  @override
  _SolicitacaoListViewState createState() => _SolicitacaoListViewState();
}

class _SolicitacaoListViewState extends State<SolicitacaoListView> {
  //Disparado quando o usuário reprova ou aprova um desconto e a tela de detalhe
  //é fechada
  void _onCloseSolicitacaoDetailView(bool finished) {
    setState(() {});
  }

  //Evento do botão Atualizar que aparece quando a lista de solicitações
  //está vazia
  void onAtualizar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //Disparado quando o usuário toca em um item do ListView
    //Quem dispara é a classe SolicitacaoViewItem
    void _handleItemTap(Solicitacao solicitacao) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return SolicitacaoDetailView(
            solicitacao: solicitacao,
            onCloseView: _onCloseSolicitacaoDetailView,
          );
        }),
      );
    }

    return FutureBuilder(
      //Carrega de forma assíncrona a lista de solicitações do WebService
      //e preenche o builder do ListView
      future: widget.solicitacaoService.getSolicitacoes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //Se o serviço estiver fora ou retornar uma lista vazia, exite uma
        //mensagem e um botão para atualizar a tela
        if (snapshot.data == null || snapshot.data.length == 0) {
          return Container(
            child: Center(
              child: Column(
                children: [
                  Text("Nenhuma solicitação encontrada",
                      style: Theme.of(context).textTheme.headline6),

                  //Este botão aparece quando a lista de
                  //solicitações está vazia
                  FlatButton(
                    child: Text('Atualizar'),
                    onPressed: onAtualizar,
                    color: Colors.lightBlue,
                    textColor: Colors.white,
                  )
                ],
              ),
            ),
          );
        }

        //Caso a lista retornada pelo webservice contiver itens monta o
        //ListView de forma assíncrona
        return ListView.builder(
          //Informa a quantidade de ítens retornados pelo webservcie para
          //preenchimento do ListView
          itemCount: snapshot.data.length,

          //Função assíncrona que é chamada para cada índice do ListView
          //tantas vezes quantos itens houver na lista (de 0 a itemCount -1)
          itemBuilder: (BuildContext context, int index) {
            return SolicitacaoViewItem(
                solicitacao: snapshot.data[index], onTapHandle: _handleItemTap);
          },
        );
      },
    );
  }
}
