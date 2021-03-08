import 'dart:async';
import 'package:solicitacoes_desconto/entities/SolicitacaoPackageData.dart';
import 'package:solicitacoes_desconto/entities/Solicitacao.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SolicitacaoService {
  final String baseAddress =
      'http://10.99.10.37/BackendSolicitacoes/api/solicitacao';
  //final String baseAddress =
  //    'http://solicitacoes.azurewebsites.net/api/solicitacao';

  Future<List<SolicitacaoPackageData>> getSolicitacoes() async {
    String path = '?aprovado=false&reprovado=false';
    var dataReturn = await http.get(baseAddress + path);
    List<SolicitacaoPackageData> listaSolicitacoes = [];

    if (dataReturn.statusCode == 200) {
      var jsonList = json.decode(dataReturn.body);

      for (var s in jsonList) {
        SolicitacaoPackageData solicitacao = SolicitacaoPackageData(
            s['id'],
            s['idConfirmacaoDeposito'],
            s['aprovado'],
            s['reprovado'],
            s['jsonData']);

        String jsonString = solicitacao.jsonData;
        var jsonDataDecode = json.decode(jsonString);

        for (var j in jsonDataDecode) {
          solicitacao.solicitacao = Solicitacao(j['cliente'], j['atuacao'],
              j['desconto'], j['loja'], j['valor'], j['margemBruta']);
        }
        listaSolicitacoes.add(solicitacao);
      }
    } else {}
    return listaSolicitacoes;
  }

  Future<bool> putSolicitacao(SolicitacaoPackageData solicitacao) async {
    var dataReturn = await http.put(
      baseAddress + '/${solicitacao.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': solicitacao.id,
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
