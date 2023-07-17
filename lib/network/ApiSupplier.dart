// ignore_for_file: prefer_typing_uninitialized_variables, unused_import

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ApiSupplier {
  dynamic getTopMarketCapData() async {
    var response;
    response = await Dio().get(
        'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=market_cap&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap');
    return response;
  }

  dynamic getTopGainersData() async {
    var response;
    response = await Dio().get(
        'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=percent_change_24h&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap');
    return response;
  }

  dynamic getTopLosersData() async {
    var response;
    response = await Dio().get(
        'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=10&sortBy=percent_change_24h&sortType=asc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap');
    return response;
  }

  dynamic getAllMarketCapData() async {
    var response;
    response = await Dio().get(
        'https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=1000&sortBy=market_cap&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,max_supply,circulating_supply,total_supply,volume_7d,volume_30d,self_reported_circulating_supply,self_reported_market_cap');
    return response;
  }

  dynamic callRegisterApi(name, email, password) async {
    final response;
    var formData =
        FormData.fromMap({'name': name, 'email': email, 'password': password});
    response = await Dio().post(
        'https://mockbin.org/bin/17475078-1085-4438-91de-0c0fc301d2b5',
        data: formData);
    return response;
  }
}
