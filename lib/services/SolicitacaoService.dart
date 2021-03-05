import 'dart:async';
import 'package:solicitacoes_desconto/entities/Solicitacao.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SolicitacaoService {
  final String baseAddress = 'http://10.99.10.37/Backend/api/solicitacao';

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
