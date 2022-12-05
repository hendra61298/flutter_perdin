
class MasterLokasiModel {
   late String id;
   late String nama;

   MasterLokasiModel({required this.id, required this.nama});

   factory MasterLokasiModel.fromJson(Map<String,dynamic> json){
     return MasterLokasiModel(
         id: json['id'] ??'',
         nama: json['nama'] ??'',
     );
   }
}
