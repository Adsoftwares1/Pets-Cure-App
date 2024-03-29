import 'dart:io';

import 'package:http/http.dart';
import 'package:mvvm_practice_app/data/network/BaseApiService.dart';
import 'package:mvvm_practice_app/data/network/NetworkApiService.dart';
import 'package:mvvm_practice_app/res/app_url.dart';
import 'package:mvvm_practice_app/res/components/my_static_component%20.dart';

class AllPetsMarketPostRepository {
  BaseApiServeces _apiServeces = NetworkApiServece();

// insert new post in database using api
  Future InsertSinglePetDataUsingPostApi(dynamic data, File? file) async {
    try {
      dynamic Response = await _apiServeces.getPostApiResponseWithFile(
          AppUrl.AddPetUsingPostApiUrl, data, file);
      return Response;
    } catch (e) {
      throw e;
    }
  }

  // Update post using api
  Future UpdateSinglePetDataUsingPostApi(
      dynamic data, File? file, int postId) async {
    //try {
    dynamic Response = await _apiServeces.getPostApiResponseWithFileandData(
        AppUrl.updatePetsPostByUser + '${postId}', data, file);

    print("Error in Repo : $Response");
    return Response;
    // } catch (e) {
    //   print("Error in Repo : $e");
    //   throw e;
    // }
  }
}
