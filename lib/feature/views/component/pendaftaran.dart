import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_project/domain/controller/master_lokasi_controller.dart';
import 'package:new_project/domain/controller/pegawai_controller.dart';
import 'package:new_project/domain/controller/perdin_controller.dart';
import 'package:new_project/domain/model/MasterLokasiModel.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:new_project/domain/model/pegawai_model.dart';

class PendaftaranPerdin extends StatefulWidget {
  const PendaftaranPerdin({Key? key}) : super(key: key);

  @override
  State<PendaftaranPerdin> createState() => _PendaftaranPerdinState();
}
mixin InputValidationPerdin {
  bool isValidText(String text) => text.isNotEmpty;
}

class _PendaftaranPerdinState extends State<PendaftaranPerdin> with InputValidationPerdin {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _pendaftaranController = PerdinController();

  List<MasterLokasiModel> listLokasi=[];
  List<Pegawai> listPegawai=[];
  MasterLokasiController _masterLokasiController = MasterLokasiController();
  PegawaiController _pegawaiController = PegawaiController();

  BsSelectBoxController _selectAsal = BsSelectBoxController();

  BsSelectBoxController _selectTujuan= BsSelectBoxController();

  BsSelectBoxController _listPegawai= BsSelectBoxController();

  getData() async{
    listLokasi = await _masterLokasiController.getMasterLokasiData();
    listPegawai = await  _pegawaiController.getPegawaiList();
    _selectAsal = BsSelectBoxController(
        options: [
          for (var list in listLokasi)
            BsSelectBoxOption(value: list.id, text: Text(list.nama)),
        ]
    );

    _selectTujuan = BsSelectBoxController(
        options: [
          for (var list in listLokasi)
            BsSelectBoxOption(value: list.id, text: Text(list.nama)),
        ]
    );

    _listPegawai = BsSelectBoxController(
        options: [
          for (var list in listPegawai)
            BsSelectBoxOption(value: list.nrp, text: Text(list.nama)),
        ]
    );
    setState(() {
      _selectAsal;
      _selectTujuan;
      _listPegawai;
    });
  }

  @override
  void initState(){
    getData();
    super.initState();
  }


  TextEditingController nrpController = TextEditingController();
  TextEditingController tanggalBrangkatController = TextEditingController();
  TextEditingController tanggalPulangController = TextEditingController();
  TextEditingController maksudController = TextEditingController();


  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),backgroundColor: Colors.deepOrangeAccent);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.deepOrange ,
        title:  Text("Pendaftaran Perjalanan Dinas"),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(children: [
                Container(
                  margin: const EdgeInsets.only(left: 40, top: 20),
                  child:   BsSelectBox(
                    searchable: true,
                    hintText: 'Pilih Nama Pegawai',
                    controller: _listPegawai,
                    validators: [ BsSelectValidators.required],
                    dialogStyle: BsDialogBoxStyle(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    style: const BsSelectBoxStyle(
                      backgroundColor: Colors.orange,
                      hintTextColor: Colors.white,
                      selectedColor: Colors.deepOrangeAccent,
                      selectedTextColor: Colors.white,
                      textColor: Colors.white,
                      focusedTextColor: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40, top: 20),
                  child:   BsSelectBox(
                    searchable: true,
                    hintText: 'Pilih Kota Asal',
                    controller: _selectAsal,
                    validators: [ BsSelectValidators.required],
                    dialogStyle: BsDialogBoxStyle(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    style: const BsSelectBoxStyle(
                      backgroundColor: Colors.orange,
                      hintTextColor: Colors.white,
                      selectedColor: Colors.deepOrangeAccent,
                      selectedTextColor: Colors.white,
                      textColor: Colors.white,
                      focusedTextColor: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40, top: 20),
                  child:   BsSelectBox(
                    hintText: 'Pilih Kota Tujuan',
                    controller: _selectTujuan,
                    validators: [ BsSelectValidators.required],
                    dialogStyle: BsDialogBoxStyle(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              TextFormField(
                controller: tanggalBrangkatController,
                onTap: () async{
                  DateTime? tanggalKeberangkatan = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2102));
                  if(tanggalKeberangkatan != null ){
                    String formattedDateK = DateFormat('yyyy-MM-dd').format(tanggalKeberangkatan);
                    setState(() {
                      tanggalBrangkatController.text = formattedDateK; //set output date to TextField value.
                    });
                  }
                },
                validator: (tanggalBerangkat) {
                  if (!isValidText(tanggalBerangkat!)) {
                    return 'Please enter tanggal berankat';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_month),
                  hintText: 'Tanggal Keberangkatan',
                  labelText: 'Tanggal Keberangkatan*',
                ),
              ),
              TextFormField(
                controller: tanggalPulangController,
                onTap: () async{
                  DateTime? tanggalPulang = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2102));
                  if(tanggalPulang != null ){
                    String formattedDateK = DateFormat('yyyy-MM-dd').format(tanggalPulang);
                    setState(() {
                      tanggalPulangController.text = formattedDateK; //set output date to TextField value.
                    });
                  }
                },
                validator: (tanggalpulan) {
                  if (!isValidText(tanggalpulan!)) {
                    return 'Please enter tanggal pulang';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_month),
                  hintText: 'Tanggal Pulang',
                  labelText: 'Tanggal Pulang*',
                ),
              ),
              TextFormField(
                controller: maksudController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.build),
                  hintText: 'Maksud',
                  labelText: 'Maksud*',
                ),
                validator: (maksud) {
                  if (!isValidText(maksud!)) {
                    return 'Please enter maksud perdin';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child:SizedBox(
                  height:40, //height of button
                  width:200, //width of button
                  child:  ElevatedButton(
                    style: style,
                    onPressed:() async {
                      if (_formKey.currentState!.validate()){
                        final pendaftaranStatus = await _pendaftaranController.pendaftaranPerdin(_listPegawai.getSelectedAsString(),_selectAsal.getSelectedAsString(),_selectTujuan.getSelectedAsString(),tanggalBrangkatController.text,tanggalPulangController.text,maksudController.text);
                        if(pendaftaranStatus) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Berhasil daftar perdin'),
                              content: const Text('Anda berhasil melakukan pendaftaran perdin'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }else{
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('gagal mendaftar perdin'),
                              content: const Text('Anda Gagal mendaftarkan perdin'),
                              actions: <Widget>[

                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    } ,
                    child:  Text(_isLoading? 'Proccessing..' : 'Pendaftaran'),
                  ),
                ) ,
              ),
            ],
          ),
        )
      )
    );
  }
}
