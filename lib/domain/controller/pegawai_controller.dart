
import 'dart:convert';

import 'package:http/http.dart';
import 'package:new_project/domain/model/pegawai_model.dart';

import '../../data/endpoint/endpoint.dart';

class PegawaiController {

  Future getPegawaiList() async{
    try{
      Response response = await get(
        Uri.parse(Endpoint.masterPegawai),
      );
      if (response.statusCode == 200){
        var data =  await jsonDecode(response.body);
        Iterable lk = data['data'];
        List<Pegawai> listPegawai = lk.map((e)=> Pegawai.fromJson(e)).toList();
        return listPegawai;
      }
    }catch(e){
      print('$e');
    }
  }
}