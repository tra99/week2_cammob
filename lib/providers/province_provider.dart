import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_week2/models/communce_model.dart';
import 'package:test_week2/models/response_model.dart';
import 'package:test_week2/models/village_model.dart';
import '../models/district_model.dart';
import '../models/province_model.dart';
import '../services/data_info_service.dart';

class ResponseProvider with ChangeNotifier {
  ResponseModel? _response;
  bool _isLoading = false;
  String _errorMessage = "";

  ResponseModel? get response => _response;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<Province> get provinces => _response?.dataModel.configurationModel.provinceList ?? [];

  List<District> get districts {
    List<District> allDistricts = [];
    for (var province in provinces) {
      allDistricts.addAll(province.district);
    }
    return allDistricts;
  }

  List<Commune> get communes {
    List<Commune> allCommunes = [];
    for (var district in districts) {
      allCommunes.addAll(district.commune);
    }
    return allCommunes;
  }

  List<Village> get villages {
    List<Village> allVillages = [];
    for (var commune in communes) {
      allVillages.addAll(commune.villages);
    }
    return allVillages;
  }

  Future<void> fetchResponse() async {
    _isLoading = true;
    notifyListeners();

    try {
      _response = await fetchResponseFromApi();
      _errorMessage = "";
      await _saveToLocalStorage();
    } catch (e) {
      _errorMessage = e.toString();
      await _loadFromLocalStorage();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final responseJson = json.encode(_response?.toJson());
    await prefs.setString('response', responseJson);
  }

  Future<void> _loadFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final responseJson = prefs.getString('response');
    if (responseJson != null) {
      _response = ResponseModel.fromJson(json.decode(responseJson));
    }
  }

  List<District> getDistrictsByProvince(String provinceNameKh) {
    var province = provinces.firstWhere((province) => province.nameKh == provinceNameKh, orElse: () => Province(id: 0, code: '', nameEn: '', nameKh: '', type: '', district: []));
    return province.district;
  }

  List<Commune> getCommunesByDistrict(String districtNameKh) {
    var district = districts.firstWhere((district) => district.nameKh == districtNameKh, orElse: () => District(id: 0, adrProvinceId: 0, code: '', nameEn: '', nameKh: '', type: '', commune: []));
    return district.commune;
  }

  List<Village> getVillagesByCommune(String communeNameKh) {
    var commune = communes.firstWhere((commune) => commune.nameKh == communeNameKh, orElse: () => Commune(id: 0, adrProvinceId: 0, adrDistrictId: 0, code: '', nameEn: '', nameKh: '', type: '', villages: []));
    return commune.villages;
  }
}
