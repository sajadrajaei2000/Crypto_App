// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project3/data/models/UserModel.dart';
import 'package:project3/data/data_source/ApiSupplier.dart';
import 'package:project3/data/data_source/ResponseModel.dart';

class UserDataProvider extends ChangeNotifier {
  ApiSupplier apiProvider = ApiSupplier();

  late dynamic dataFuture;
  //late UserModel dataFutur2e;
  ResponseModel? registerStatus;
  var error;
  late Response<dynamic> response;

  callRegisterApi(name, email, password) async {
    // start loading api
    registerStatus = ResponseModel.loading("is loading...");
    notifyListeners();

    try {
      // fetch data from api and goto mainWrapper
      response = await apiProvider.callRegisterApi(name, email, password);
      print('response is: ${response.statusCode}');
      if (response.statusCode == 200) {
        dataFuture = UserModel.fromJson(response.data);
        registerStatus = ResponseModel.completed(dataFuture);
        // have validate error
      } else if (response.statusCode == 201) {
        dataFuture = ApiStatus.fromJson(response.data);
        registerStatus = ResponseModel.error('You have Error 201 ');
      }
      notifyListeners();
    } catch (e) {
      // catch any error and show error
      registerStatus =
          ResponseModel.error("please check your connection... !!");
      notifyListeners();
      print(e.toString());
    }
  }
}
