import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/CryptoModel/AllCryptoModel.dart';
import '../../network/ApiSupplier.dart';
import '../../network/ResponseModel.dart';

class MarketViewProvider extends ChangeNotifier {
  late AllCryptoModel dataFuture;
  ApiSupplier apiSupplier = ApiSupplier();
  //! create an object from ResponseModel
  late ResponseModel state;
  late Response response;
  getCryptoData() async {
    state = ResponseModel.loading('is loading...');
    try {
      response = await apiSupplier.getAllMarketCapData();
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
