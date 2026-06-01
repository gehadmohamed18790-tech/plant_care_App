import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_8/models/list_model.dart';
import 'package:flutter_application_8/models/details_model.dart';
import 'package:flutter_application_8/models/disease_model.dart';
import 'package:flutter_application_8/models/guidance_model.dart';

class PlantApiService {
  final String _apiKey = 'sk-Mm5c6a1c4122b1afc17824';
  final String _baseUrl = 'https://perenual.com/api';
  
  

  Future<List<Plant>> fetchPlantsList() async {
    try {
      final url = Uri.parse('$_baseUrl/species-list?key=$_apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        final List<dynamic> jsonList = decodedData['data'];
        return jsonList.map((json) => Plant.fromJson(json)).toList();
      } else {
        throw Exception('error');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  Future<PlantDetails> fetchPlantDetails(int plantId) async {
    try {
      final url = Uri.parse('$_baseUrl/species/details/$plantId?key=$_apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        return PlantDetails.fromJson(decodedData);
      } else {
        throw Exception('error');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  Future<List<PlantGuidance>> fetchPlantGuidance() async {
    try {
      final url = Uri.parse('$_baseUrl/species-care-guide-list?key=$_apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        final List<dynamic> jsonList = decodedData['data'];
        return jsonList.map((json) => PlantGuidance.fromJson(json)).toList();
      } else {
        throw Exception('فشل في تحميل إرشادات العناية');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  Future<List<PlantDisease>> fetchPlantDiseases() async {
    try {
      final url = Uri.parse('$_baseUrl/pest-disease-list?key=$_apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        final List<dynamic> jsonList = decodedData['data'];
        return jsonList.map((json) => PlantDisease.fromJson(json)).toList();
      } else {
        throw Exception('فشل في تحميل أمراض النباتات');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }
}