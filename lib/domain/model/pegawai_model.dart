
class Pegawai {
  late String nrp;
  late String nama;

  Pegawai({required this.nrp, required this.nama});

  factory Pegawai.fromJson(Map<String,dynamic> json){
    return Pegawai(
        nrp:json['nrp'] ??'',
        nama: json['nama'] ??'',
    );
  }
}