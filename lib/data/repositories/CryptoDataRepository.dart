import 'package:project3/data/data_source/ApiSupplier.dart';
import 'package:project3/data/models/CryptoModel/AllCryptoModel.dart';
import 'package:dio/dio.dart';

class CryptoDataRepository {
  late Response<dynamic> response;
  ApiSupplier apiSupplier = ApiSupplier();
  AllCryptoModel datafuture = AllCryptoModel();

  Future<AllCryptoModel> getTopMarketCapData() async {
    response = await apiSupplier.getTopMarketCapData();
    datafuture = AllCryptoModel.fromJson(response.data);
    return datafuture;
  }

  Future<AllCryptoModel> getTopGainersData() async {
    response = await apiSupplier.getTopGainersData();
    datafuture = AllCryptoModel.fromJson(response.data);
    return datafuture;
  }

  Future<AllCryptoModel> getTopLosersData() async {
    response = await apiSupplier.getTopLosersData();
    datafuture = AllCryptoModel.fromJson(response.data);
    return datafuture;
  }
}
