import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/models/CryptoModel/AllCryptoModel.dart';
import '../../data/data_source/ApiSupplier.dart';
import '../../data/data_source/ResponseModel.dart';

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
