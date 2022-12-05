
import 'dart:convert';

import 'package:http/http.dart';
import 'package:new_project/domain/model/user_model.dart';
import 'package:new_project/domain/repository/perdin.dart';

import '../../data/endpoint/endpoint.dart';
import 'dart:math' show cos, sqrt, asin;

class PerdinController implements Perdin{
  @override
  Future<bool> pendaftaranPerdin(String nrp, String asal, String tujuan, String berangkat, String pulang, String maksud) async {
          final tanggalBerangkat = DateTime.parse(berangkat);
          final tanggalPulang = DateTime.parse(pulang);
          late final longLatAsal,latAsal,longLatTujuan,latTujuan;

          var uang = 0;
      try{
        Response responseGetAsal = await get(
          Uri.parse(Endpoint.masterLokasiUrl+asal),
        );
        if (responseGetAsal.statusCode == 200){
          var data =  await jsonDecode(responseGetAsal.body);
          longLatAsal = double.parse(data['lon']);
          latAsal = double.parse(data['lat']) ;
        }
        Response responseGetTujuan = await get(
          Uri.parse(Endpoint.masterLokasiUrl+tujuan),
        );
        if (responseGetTujuan.statusCode == 200){
          var data =  await jsonDecode(responseGetTujuan.body);
          longLatTujuan = double.parse(data['lon']);
          latTujuan =double.parse(data['lat']) ;
        }
        var p = 0.017453292519943295;
        var c = cos;
        var a = 0.5 - c((latTujuan - latAsal) * p)/2 +
            c(latAsal * p) * c(latTujuan * p) *
                (1 - c((longLatTujuan - longLatAsal) * p))/2;
       var jarak = (12742 * asin(sqrt(a))).floor();
       if(jarak >= 60) uang = 100000;
        Response response = await post(
            Uri.parse(Endpoint.perdin),
            body: {
              'nrp' : "$nrp",
              'lokasi_id_asal' : "$asal",
              'lokasi_id_tujuan' : "$tujuan",
              'jarak' : "$jarak",
              'tanggal_berangkat' : berangkat,
              'tanggal_pulang' : pulang,
              'lama_hari' :"${tanggalPulang.difference(tanggalBerangkat).inDays}",
              'maksud' :maksud,
              'uang_saku' :"${uang * tanggalPulang.difference(tanggalBerangkat).inDays}",
              'created_by_user_id' :"${UserLogin.id}",
            }
        );

        if(response.statusCode ==200) return true;
        print(response.body.toString());
       return false;
      }catch(e){
        print(e.toString());
        return false;
      }
  }

}