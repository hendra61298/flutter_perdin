
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:new_project/domain/model/lokasi_model.dart';
import 'package:new_project/domain/repository/lokasi.dart';

import '../../data/endpoint/endpoint.dart';

class LokasiController implements Lokasi{
  @override
  Future<List<LokasiModel>> getMasterLokasi() async{
    try{
      Response response = await get(
          Uri.parse(Endpoint.masterLokasi),
      );
      if (response.statusCode == 200){
        var data =  await jsonDecode(response.body);
        Iterable lk = data['data'];

        List<LokasiModel> listLokasi = lk.map((e)=> LokasiModel.fromJson(e)).toList();
        return listLokasi;
      }
      return [];
    }catch(e){
      print('$e');
      return [];
    }
  }

   Future<bool> deletePerdin(String id, BuildContext context) async {
    try{
      Response response = await delete(
        Uri.parse("${Endpoint.perdin}$id"),
      );
      print(response.body);
     if(response.statusCode == 200){
         return true;
         }
         return false;
    }catch(e){
     return false;
    }
  }
  
}