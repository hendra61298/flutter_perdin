

import 'package:flutter/material.dart';
import 'package:new_project/domain/controller/lokasi_controller.dart';

import '../../../domain/model/lokasi_model.dart';
import '../home/home.dart';

class MasterLokasi extends StatefulWidget {
  const MasterLokasi({Key? key}) : super(key: key);

  @override
  State<MasterLokasi> createState() => _MasterLokasiState();
}



class _MasterLokasiState extends State<MasterLokasi> {
  List<LokasiModel> listLokasi=[];
  LokasiController lokasiController = LokasiController();
  final _lokasiController = LokasiController();


  getData() async{
    listLokasi = await lokasiController.getMasterLokasi();
    setState(() {
    });
  }

  @override
  void initState(){
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.deepOrange ,
        title:  Text("Daftar Lokasi"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: SingleChildScrollView(
          child:Padding(padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Nama Pegawain',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Tanggal berangkat',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Tanggal Pulang',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Kota Asal berangkat',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Kota Tujuan',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Maksud Tujuan Perdin',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Jarak Perjalanan',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Hari',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Uang Saku',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Action',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                  rows:  <DataRow>[
                    for (var list in listLokasi)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(list.namaPegawai)),
                          DataCell(Text(list.tanggalBerangkat)),
                          DataCell(Text(list.tanggalPulang)),
                          DataCell(Text(list.lokasiAsal)),
                          DataCell(Text(list.lokasiTujuan)),
                          DataCell(Text(list.maksudTujuan)),
                          DataCell(Text("${list.jarak} km")),
                          DataCell(Text("${list.hari} hari")),
                          DataCell(Text("Rp ${list.uangSaku}")),
                          DataCell(
                              ElevatedButton(
                                  onPressed: () async {
                                     showDialog<String>(
                                     context: context,
                                     builder: (BuildContext context) => AlertDialog(
                                       title: const Text('Apakah Anda yakin?'),
                                       content: const Text('Anda akan menghapus perdin'),
                                       actions: <Widget>[
                                         TextButton(
                                           onPressed: () async{
                                             Navigator.pop(context,"cancel");
                                              },
                                           child: const Text('Cancel'),
                                         ),
                                         TextButton(
                                           onPressed: () async{
                                                final deleteStatus = await _lokasiController.deletePerdin(list.id,context);
                                                if (deleteStatus){
                                                if(!mounted) return;
                                                Navigator.push(context,MaterialPageRoute(builder: (_) => const HomePage()));
                                            } },
                                           child: const Text('OK'),
                                         ),
                                       ],
                                     ),
                                   );
                                  } ,
                                  child: Text('Delete'),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),)
                          ),
                        ],
                      ),
                  ]),
            ),) ,
        ),
      ),
    );
  }
}


