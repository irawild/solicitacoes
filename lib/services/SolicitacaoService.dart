import 'dart:async';
import 'package:solicitacoes_desconto/entities/Solicitacao.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SolicitacaoService {
  //Lembre-se que ao testar no serviço publicado no Azure, a lista é carregada
  //em memória via código de forma estática. O estado da lista não muda, por
  //isso, quando aprovado ou reprovado, não muda a quantidade de registros da
  //lista. Localmente funciona. Em breve quando eu mudar o backend
  //para um banco de dados também no azure, aí a experiência estará completa.
  final String baseAddress = 'http://10.99.10.37/Backend/api/solicitacao';
  //final String baseAddress =
  //    'http://solicitacoes.azurewebsites.net/api/solicitacao';

  Future<List<Solicitacao>> getSolicitacoes() async {
    var dataReturn = await http.get(baseAddress);
    List<Solicitacao> listaSolicitacoes = [];

    if (dataReturn.statusCode == 200) {
      var jsonList = json.decode(dataReturn.body);

      for (var s in jsonList) {
        Solicitacao solicitacao = Solicitacao(
            s["id"],
            s["cliente"],
            s["desconto"],
            s['atuacao'],
            s['loja'],
            s['valor'],
            s['margemBruta'],
            s['aprovado'],
            s['reprovado']);
        listaSolicitacoes.add(solicitacao);
      }
    } else {}
    return listaSolicitacoes;
  }

  Future<bool> putSolicitacao(Solicitacao solicitacao) async {
    var dataReturn = await http.put(
      baseAddress + '/${solicitacao.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': solicitacao.id,
        'cliente': solicitacao.cliente,
        'desconto': solicitacao.desconto,
        'atuacao': solicitacao.atuacao,
        'loja': solicitacao.loja,
        'valor': solicitacao.valor,
        'margemBruta': solicitacao.margemBruta,
        'aprovado': solicitacao.aprovado,
        'reprovado': solicitacao.reprovado
      }),
    );

    if (dataReturn.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
