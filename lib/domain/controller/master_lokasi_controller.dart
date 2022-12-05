
import 'dart:convert';

import 'package:http/http.dart';
import 'package:new_project/domain/model/MasterLokasiModel.dart';

import '../../data/endpoint/endpoint.dart';
import '../repository/master_lokasi.dart';

class MasterLokasiController implements MasterLokasiRepo{
  @override
 Future getMasterLokasiData() async {
    try{
      Response response = await get(
        Uri.parse(Endpoint.masterLokasiData),
      );
      if (response.statusCode == 200){
        var data =  await jsonDecode(response.body);
        Iterable lk = data['data'];
        List<MasterLokasiModel> listLokasi = lk.map((e)=> MasterLokasiModel.fromJson(e)).toList();
        return listLokasi;
      }
    }catch(e){
      print('$e');
    }
  }

  @override
  Future getLokasiById() {
    // TODO: implement getLokasiById
    throw UnimplementedError();
  }

}