import 'dart:convert';

import 'package:bank_app/models/card_model.dart';
import 'package:http/http.dart';

class HttpService {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "62340c936d5465eaa5131625.mockapi.io";
  static String SERVER_PRODUCTION  = "62340c936d5465eaa5131625.mockapi.io";

  static Map<String,String> getHeaders() {
    Map<String,String> headers = {
      "Content-Type" : "application/json",
    };
    return headers;
  }

  static getServer() {
    if(isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /* Http Request */

  static Future<String?> GET(String api, Map<String,dynamic> params) async {
    var uri = Uri.http(getServer(), api, params);
    var response = await get(uri,headers: getHeaders());
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String,dynamic> params) async {
    var uri = Uri.http(getServer(), api);
    var response = await post(uri,headers: getHeaders(),body: jsonEncode(params));
    if(response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PATCH(String api, Map<String,dynamic> params) async {
    var uri = Uri.http(getServer(), api);
    var response = await patch(uri,headers: getHeaders(),body: jsonEncode(params));
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL(String api, Map<String,dynamic> params) async {
    var uri = Uri.http(getServer(), api, params);
    var response = await delete(uri,headers: getHeaders());
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Api */

  static String API_LIST = "/cards";
  static String API_ONE_ELEMENTS = "/cards/"; // {ID}
  static String API_CREATE = "/cards";
  static String API_UPDATE = "/cards/"; // {ID}
  static String API_DELETE = "/cards/"; // {ID}

  /* Http params */

  static Map<String,dynamic> paramsEmpty() {
    Map<String,dynamic> params = {};
    return params;
  }

  /* Http bodies */

  static Map<String,dynamic> bodyCreate(CardModel card) {
    Map<String,dynamic> params = {};
    params.addAll({
      "cardName" : card.cardName,
      "cardNumber" : card.cardNumber,
      "cardDate" : card.cardDate,
      "cvv" : card.cvv
    });
    return params;
  }

  static Map<String,dynamic> bodyUpdate(CardModel card) {
    Map<String,dynamic> params = {};
    params.addAll({
      "id" : card.id,
      "cardName" : card.cardName,
      "cardNumber" : card.cardNumber,
      "cardDate" : card.cardDate,
      "cvv" : card.cvv
    });
    return params;
  }

  static Map<String, String> deleteParam(String id) {
    Map<String, String> params = {};
    params.addAll({
      "id":id
    });
    return params;
  }

  static List<CardModel> parseResponse(String response) {
    List json = jsonDecode(response);
    List<CardModel> cards = List<CardModel>.from(json.map((e) => CardModel.fromJson(e)));
    return cards;
  }
}