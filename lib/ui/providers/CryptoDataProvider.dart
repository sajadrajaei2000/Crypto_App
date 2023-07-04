// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project3/models/CryptoModel/AllCryptoModel.dart';
import 'package:project3/network/ApiSupplier.dart';
import 'package:project3/network/ResponseModel.dart';

class CryptoDataProvider extends ChangeNotifier {
  late AllCryptoModel dataFuture;
  ApiSupplier apiSupplier = ApiSupplier();
  //! create an object from ResponseModel
  late ResponseModel state;
  late Response response;
  getTopMarketCapData() async {
    state = ResponseModel.loading('is loading...');
    try {
      response = await apiSupplier.getTopMarketCapData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('somethig wrong!!!');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('please check your connection!!!');
      notifyListeners();
    }
  }
}
