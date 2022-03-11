import 'dart:convert';
import 'package:bank_app/models/card_model.dart';
import 'package:http/http.dart';

class HttpService {
  // Base url
  static String BASE_URL = "622ac5d514ccb950d224e77e.mockapi.io";

  // Header
  static Map<String, String> headers =  {
    // "User-Agent" : "PostmanRuntime/7.29.0",
    // 'Accept-Encoding': "gzip, deflate, br",
    // 'Connection': 'keep-alive'
  };

  // Apis
  static String API_USER_LIST = "/cards";
  static String API_USER_ONE = "/cards/"; // {ID}
  static String API_CREATE_USER = "/cards";
  static String API_UPDATE_USER = "/cards/"; //  {ID}
  static String API_EDIT_USER = "/cards/"; //  {ID}
  static String API_DELETE_USER = "/cards/"; //  {ID}

  // Methods
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api, params);
    Response response = await get(uri);
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE_URL, api);
    Response response = await post(uri, body: jsonEncode(params));
    if(response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api);
    Response response = await put(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api);
    Response response = await patch(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api, params);
    Response response = await delete(uri, headers: headers);
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  // Params
  static Map<String, String> paramEmpty() {
    Map<String, String> map = {};
    return map;
  }

  static Map<String, dynamic> paramsCreate(CardModel user) {
    Map<String, dynamic> map = user.toJson();
    return map;
  }

  // Parsing
  static UserList parseUserList(String body) {
    List json = jsonDecode(body);
    UserList list = UserList.fromJson(json);
    return list;
  }

  static CardModel parseUserOne(String body) {
    Map<String, dynamic> json = jsonDecode(body);
    CardModel user = CardModel.fromJson(json);
    return user;
  }

  static CardModel parseCreateUser(String body) {
    Map<String, dynamic> json = jsonDecode(body);
    CardModel user = CardModel.fromJson(json);
    return user;
  }

}