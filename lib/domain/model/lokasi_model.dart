

class LokasiModel {
   final String id;
   final String namaPegawai;
   final String tanggalBerangkat;
   final String tanggalPulang;
   final String lokasiAsal;
   final String lokasiTujuan;
   final String maksudTujuan;
   final String jarak;
   final String hari;
   final String uangSaku;

   LokasiModel({required  this.id,required this.namaPegawai, required this.tanggalBerangkat, required this.tanggalPulang, required this.lokasiAsal, required this.lokasiTujuan, required this.maksudTujuan, required this.jarak, required this.hari, required this.uangSaku});

    factory LokasiModel.fromJson(Map<String,dynamic> json){
      return LokasiModel(
          id:json['id'] ??'',
          namaPegawai: json['nama_pegawai'] ??'',
          tanggalBerangkat:json['tanggal_berangkat'] ??'',
          tanggalPulang:json['tanggal_pulang'] ??'',
          lokasiAsal:json['lokasi_asal'] ??'',
          uangSaku: json['uang_saku'] ??'',
          lokasiTujuan:json['lokasi_tujuan'] ??'',
          maksudTujuan: json['maksud']??'',
          jarak:json['jarak'] ??'',
          hari: json['lama_hari']??''
      );
  }
}