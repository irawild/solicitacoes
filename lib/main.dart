//Framework
import 'package:flutter/material.dart';

//Views
import 'package:solicitacoes_desconto/listViews/SolicitacaoListView.dart';

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
  Future<Null> refreshList() async {
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Solicitações de Desconto"))),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Container(
          child: SolicitacaoListView(),
        ),
      ),
    );
  }
}
