
import 'package:new_project/domain/model/lokasi_model.dart';

abstract class Lokasi {
  Future<List<LokasiModel>> getMasterLokasi ();
}