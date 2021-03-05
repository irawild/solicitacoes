//Framework
import 'package:flutter/material.dart';

//Views
import 'package:solicitacoes_desconto/views/SolicitacaoDetailView.dart';

//View items
import 'package:solicitacoes_desconto/viewItems/SolicitacaoViewItem.dart';

//Services
import 'package:solicitacoes_desconto/services/SolicitacaoService.dart';

//Entities
import 'package:solicitacoes_desconto/entities/Solicitacao.dart';

void main() {
  runApp(Nav2App());
}

class Nav2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext _context;
  final SolicitacaoService solicitacaoService = SolicitacaoService();

  void _onCloseSolicitacaoDetailView(bool finished) {
    setState(() {});
  }

  void onAtualizar() {
    setState(() {});
  }

  Future<Null> refreshList() async {
    setState(() {});
    return null;
  }

  void _handleItemTap(Solicitacao solicitacao) {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) {
        return SolicitacaoDetailView(
          solicitacao: solicitacao,
          onCloseView: _onCloseSolicitacaoDetailView,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(title: Text("Solicitações de Desconto")),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Container(
          child: FutureBuilder(
            // future: solicitacaoService.getSolicitacoes(),
            future: solicitacaoService.getSolicitacoes(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null || snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Column(
                      children: [
                        Text("Nenhuma solicitação encontrada",
                            style: Theme.of(context).textTheme.headline6),
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

              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return SolicitacaoViewItem(
                      solicitacao: snapshot.data[index],
                      onTapHandle: _handleItemTap);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
