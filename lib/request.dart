import 'dart:io';
import 'package:gdsc_client/model/household.dart';
import 'package:gdsc_client/model/room.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './model/roomShort.dart';

class Request {
  static final String _mainUrl = "10.24.90.30:8080";

  static dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw (Exception("Client Error."));
      case 401:
        throw (Exception("Not authorized."));
      case 403:
        throw (Exception("No access permission."));
      case 500:
        throw (Exception("Server error."));
      default:
        throw (Exception("Something wrong happens."));
    }
  }

  static Future<dynamic> _getRequest(endpoint, tokens) async {
    try {
      var response = await http.get(Uri.http(_mainUrl, endpoint, tokens));
      var jsonResponse = _response(response);
      return jsonResponse;
    } on SocketException catch (socketException) {
      print("Error: ${socketException.toString()}");
    } on Exception catch (exception) {
      print("Error: ${exception.toString()}");
    } catch (_) {
      print("Something goes wrong.");
    }
  }

  static Future<dynamic> _postRequest(endpoint, tokens) async {
    try {
      var response = await http.post(Uri.http(_mainUrl, endpoint, tokens));
      var jsonResponse = _response(response);
      return jsonResponse;
    } on SocketException catch (socketException) {
      print("Error: ${socketException.toString()}");
    } on Exception catch (exception) {
      print("Error: ${exception.toString()}");
    } catch (_) {
      print("Something goes wrong.");
    }
  }

  // User Info

  static Future<List<RoomShort>?> getUserInfo(String uid) async {
    // Todo: operations on status code 1 and return value;
    final String endpoint = "/user";
    final Map<String, String> requestTokens = {
      "token": uid,
    };
    var res = await _getRequest(endpoint, requestTokens);
    if (res["status_code"] == 0) {
      if (res["comment"]["rooms"] == null) {
        return [];
      }
      List<dynamic> roomShortList = res["comment"]["rooms"];
      return roomShortList
          .map((e) => RoomShort(
              id: e["id"].toString(), roomName: e["room_name"].toString()))
          .toList();
    } else {
      return null;
    }
  }

  // Records

  static Future<void> postCreateRecord() async {}

  static Future<void> postUpdateRecord() async {}

  static Future<void> postDeleteRecord() async {}

  static Future<void> getListRecord() async {}

  // Room

  static Future<void> postUpdateRoom(
      String uid,
      String currRoomId,
      String newRoomName,
      String newRoomCity,
      List<Household> householdList) async {
    final String endpoint = "/room/update";
    List<Map<String, Object>> householdTokens = householdList
        .map((household) => {
              "age": household.age,
              "height": household.height.toInt(),
              "wheelchair": household.needWheelChair,
            })
        .toList();
    Map<String, String> token = {
      "token": uid,
      "room_id": currRoomId,
      "room_name": newRoomName,
      "city": newRoomCity,
      "household": jsonEncode(householdTokens),
    };
    print(token);
  }

  static Future<void> postCreateRoom(
    String uid,
    String newRoomName,
    String newRoomCity,
    List<Household> householdList,
  ) async {
    final String endpoint = "/room/create";
    List<Map<String, Object>> householdTokens = householdList
        .map((household) => {
              "age": household.age,
              "height": household.height.toInt(),
              "wheelchair": household.needWheelChair,
            })
        .toList();
    Map<String, String> token = {
      "token": uid,
      "room_name": newRoomName,
      "city": newRoomCity,
      "household": jsonEncode(householdTokens),
    };
    print(token);
  }

  static Future<void> postDeleteRoom(String uid, String currRoomId) async {
    final String endpoint = "/room/delete";
    Map<String, String> token = {
      "token": uid,
      "room_id": currRoomId,
    };
    print(token);
  }

  static Future<Room?> getRoomInfo(String uid, String roomId) async {
    final String endpoint = "/room";
    Map<String, String> token = {
      "token": uid,
      "room_id": roomId,
    };
    var res = await _getRequest(endpoint, token);
    if (res["status_code"] == 0) {
      String roomName = res["comment"]["room_name"];
      String roomCity = res["comment"]["city"];
      List<Household> householdList = [];
      if (res["comment"]["household"] != null) {
        List<dynamic> hList = res["comment"]["household"];
        householdList = hList
            .map((e) => Household(
                age: e["age"],
                height: (e["height"] as int).toDouble(),
                needWheelChair: e["wheelchair"] as bool))
            .toList();
      }
      return Room(
        id: roomId,
        roomCity: roomCity,
        roomTitle: roomName,
        householdList: householdList,
      );
    } else {
      return null;
    }
  }

  // Household

  Future<void> postCreateHousehold() async {}

  Future<void> postUpdateHousehold() async {}

  Future<void> postDeleteHousehold() async {}
}
