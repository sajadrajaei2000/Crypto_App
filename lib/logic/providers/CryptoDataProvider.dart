// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project3/data/models/CryptoModel/AllCryptoModel.dart';
import 'package:project3/data/data_source/ResponseModel.dart';
import 'package:project3/data/repositories/CryptoDataRepository.dart';

class CryptoDataProvider extends ChangeNotifier {
  late AllCryptoModel dataFuture;

  //! create an object from ResponseModel
  late ResponseModel state;
  late Response response;
  CryptoDataRepository repository = CryptoDataRepository();

  getTopMarketCapData() async {
    state = ResponseModel.loading('is loading...');
    try {
      dataFuture = await repository.getTopMarketCapData();
      state = ResponseModel.completed(dataFuture);
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('please check your connection!!!');
      notifyListeners();
    }
  }

  getTopGainersData() async {
    state = ResponseModel.loading('is loading...');
    try {
      dataFuture = await repository.getTopGainersData();
      state = ResponseModel.completed(dataFuture);
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('please check your connection!!!');
      notifyListeners();
    }
  }

  getTopLosersData() async {
    state = ResponseModel.loading('is loading...');
    try {
      dataFuture = await repository.getTopLosersData();
      state = ResponseModel.completed(dataFuture);
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('please check your connection!!!');
      notifyListeners();
    }
  }
}
