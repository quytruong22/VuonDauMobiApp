import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vuondauapp/object/areaDTO.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmPicture.dart';
import 'package:vuondauapp/object/farmType.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/object/feedback_dto.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestPicture.dart';
import 'package:vuondauapp/object/harvestSellingDTO.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/object/order_detail_dto.dart';
import 'package:vuondauapp/object/order_dto.dart';
import 'package:vuondauapp/object/productDTO.dart';

class HttpService {
  final String endPoint = "http://52.221.245.187:90/";

  Future<FarmerDTO> getFarmer(farmerID) async {
    final getFarmerResponse = await get(Uri.parse(endPoint + 'api/v1/farmers/$farmerID'));
    if(getFarmerResponse.statusCode==200){
      FarmerDTO farmer = FarmerDTO.fromJson(jsonDecode(getFarmerResponse.body));
      return farmer;
    } else  {
      throw "Cannot get Farmer";
    }
  }

  Future<List<OrderDTO>> getOrder() async {
    Response res =
        await get(Uri.parse(endPoint + 'api/v1/orders'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<OrderDTO> listOrder =
          body.map((dynamic item) => OrderDTO.fromJson(item)).toList();
      return listOrder;
    } else {
      throw "Cannot get Order";
    }
  }

  Future<List<OrderDetailDTO>> getOrderDetailForFarmer() async {
    Response res =
    await get(Uri.parse(endPoint + 'api/v1/order-details'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<OrderDetailDTO> listOrderDetailDTO =
      body.map((dynamic item) => OrderDetailDTO.fromJson(item)).toList();
      return listOrderDetailDTO;
    } else {
      throw "Cannot get Order";
    }
  }

  Future<List<FeedbackDTO>> getFeedback(orderID) async {
    Response res =
    await get(Uri.parse(endPoint + 'api/v1/feedbacks/$orderID'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<FeedbackDTO> listFeedback =
      body.map((dynamic item) => FeedbackDTO.fromJson(item)).toList();
      return listFeedback;
    } else {
      throw "Cannot get Order";
    }
  }

  Future<List<ProductDTO>> getListProducts()async{
    Response res = await get(Uri.parse(endPoint + 'api/v1/products'));
    if(res.statusCode == 200){
      List<ProductDTO> listProducts = ListProducts.fromJson(jsonDecode(res.body)).products;
      return listProducts;
    } else {
      throw "Cannot get Products";
    }
  }

  Future<List<AreaDTO>> getListAreas()async{
    Response res = await get(Uri.parse(endPoint + 'api/v1/areas'));
    if(res.statusCode == 200){
      List<AreaDTO> listAreas = ListAreas.fromJson(jsonDecode(res.body)).areas;
      return listAreas;
    } else {
      throw "Cannot get List Farm";
    }
  }

  Future<List<FarmType>> getListFarmTypes()async{
    Response res = await get(Uri.parse(endPoint + 'api/v1/farm-types'));
    if(res.statusCode == 200){
      List<FarmType> listFarmTypes = ListFarmTypes.fromJson(jsonDecode(res.body)).farmTypes;
      return listFarmTypes;
    } else {
      throw "Cannot get List Farm";
    }
  }

  Future<List<FarmDTO>> getListFarms(farmerID)async{
    Response res = await get(Uri.parse(endPoint + 'api/v1/farms/$farmerID'));
    if(res.statusCode == 200){
      List<FarmDTO> listFarms = ListFarms.fromJson(jsonDecode(res.body)).farms;
      return listFarms;
    } else {
      throw "Cannot get List Farm";
    }
  }

  Future<FarmDTO> getFarm(farmID)async{
    Response res = await get(Uri.parse(endPoint + 'api/v1/farms/$farmID'));
    if(res.statusCode == 200){
      FarmDTO farm = FarmDTO.fromJson(jsonDecode(res.body));
      return farm;
    } else {
      throw "Cannot get Farm";
    }
  }

  Future<List<HarvestDTO>> getListAllHarvests(farmerID)async{
    List<FarmDTO> listFarms = await getListFarms(farmerID);
    List<HarvestDTO>  listAllHarvests = [];
    for (var farm in listFarms) {
      List<HarvestDTO> listHarvests = await getListHarvestsByFarmID(farm.ID);
      if(listHarvests!=[]) listAllHarvests.addAll(listHarvests);
    }
    return listAllHarvests;
  }

  Future<List<HarvestDTO>> getListHarvestsByFarmID(farmID)async{
    Response res = await get(Uri.parse(endPoint + 'api/v1/harvests/$farmID'));
    if(res.statusCode == 200){
      List<HarvestDTO> listHarvests = [];
          try{
            listHarvests=ListHarvests.fromJson(jsonDecode(res.body)).harvests;
          }catch(e){
            print(e.toString());
          }
      return listHarvests;
    } else {
      return [];
    }
  }

  Future<HarvestDTO> getHarvest(harvestID)async{
    Response res = await get(Uri.parse(endPoint + 'api/v1/harvests/$harvestID'));
    if(res.statusCode == 200){
      HarvestDTO harvest = HarvestDTO.fromJson(jsonDecode(res.body));
      return harvest;
    } else {
      throw "Cannot get Harvest";
    }
  }

  Future<List<HarvestSellingPriceDTO>> getAllSellings(farmerID)async{
    List<HarvestSellingPriceDTO> listAllSellings = [];
    List<FarmDTO> listFarm = await getListFarms(farmerID);
    for (var farm in listFarm) {
      List<HarvestDTO> listAllHarvests = await getListHarvestsByFarmID(farm.ID);
      for (var harvest in listAllHarvests) {
        List<HarvestSellingPriceDTO> harvestSellingPrice =  await getSellingsByHarvestID(harvest.ID);
        listAllSellings.addAll(harvestSellingPrice);
      }
    }
    return listAllSellings;
  }

  Future<List<HarvestSellingPriceDTO>> getSellingsByHarvestID(harvestID)async{
    List<HarvestSellingPriceDTO> listSellings = [];
    Response res = await get(Uri.parse(endPoint + 'api/v1/harvest-sellings/$harvestID'));
    if(res.statusCode == 200){
      try {
        List<HarvestSellingDTO> listHarvestSelling = ListHarvestSelling.fromJson(jsonDecode(res.body)).harvestsellings;
        for (var harvestSelling in listHarvestSelling) {
          Response resSelling = await get(Uri.parse(endPoint + 'api/v1/harvest-selling-prices/${harvestSelling.id}'));
          if(resSelling.statusCode==200){
            List<HarvestSellingPriceDTO> harvestSellingPrice = ListHarvestSellingPrice.fromJson(jsonDecode(resSelling.body)).harvestsellingprice;
            listSellings.addAll(harvestSellingPrice);
          }
        }
      } on Exception catch (e) {
        print(e.toString());
      }
    }
    return listSellings;
  }

  Future<HarvestSellingPriceDTO> getSelling(sellingID)async{
    Response res = await get(Uri.parse(endPoint + 'api/v1/harvest-selling-prices/$sellingID'));
    if(res.statusCode == 200){
      HarvestSellingPriceDTO selling = HarvestSellingPriceDTO.fromJson(jsonDecode(res.body));
      return selling;
    } else {
      throw "Cannot get Selling";
    }
  }

  Future<String> postImage(File image) async{
    final String point = 'https://api.imgbb.com/1/upload';
    final String key = 'c2fc97f825e6677349722d312015d002';
    final String uri = point+'?key='+key;
    List<int> imageINT = image.readAsBytesSync();
    final String base64 = base64Encode(imageINT);
    print(base64);
    Map data = {
      'key':key,
      'image':base64
    };
    Response res = await post(Uri.parse(uri),
        body: data
    );
    if(res.statusCode==200){
      final String url = jsonDecode(res.body)['data']['display_url'];
      return url;
    }
    throw 'Erroruploadimage';
  }

  Future<bool> postFarmImage(File image, String farmID) async {
    String imageURL = await postImage(image);
    Map data = {
      'farm_id': farmID,
      'src': imageURL,
      'alt': ''
    };
    var body = json.encode(data);
    Response res = await post(Uri.parse(endPoint+'api/v1/farm-pictures'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if(res.statusCode==201){
      return true;
    }
    return false;
  }

  Future<bool> postHarvestImage(File image, String harvestID) async {
    String imageURL = await postImage(image);
    Map data = {
      'harvest_id': harvestID,
      'src': imageURL,
      'alt': ''
    };
    var body = json.encode(data);
    Response res = await post(Uri.parse(endPoint+'api/v1/harvest-pictures'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if(res.statusCode==201){
      return true;
    }
    return false;
  }

  Future<FarmPicture> getFarmImage(String farmID) async {
    Response res = await get(Uri.parse(endPoint+'api/v1/farm-pictures/$farmID'));
    if(res.statusCode==200){
      List<FarmPicture> farmPicture = ListFarmPicture.fromJson(jsonDecode(res.body)).farms;
      return farmPicture.first;
    }
    throw 'no image or fail load';
  }

  Future<HarvestPicture> getHarvestImage(String harvestID) async {
    Response res = await get(Uri.parse(endPoint+'api/v1/harvest-pictures/$harvestID'));
    if(res.statusCode==200){
      List<HarvestPicture> harvestPicture = ListHarvestPicture.fromJson(jsonDecode(res.body)).harvests;
      return harvestPicture.first;
    }
    throw 'no image or fail load';
  }

  Future<bool> updateFarmImage(File image, String farmID, String pictureID) async {
    String imageURL = await postImage(image);
    Map data = {
      'farm_id': farmID,
      'src': imageURL,
      'alt': ''
    };
    var body = json.encode(data);
    Response res = await put(Uri.parse(endPoint+'api/v1/farm-pictures/$pictureID'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if(res.statusCode==200){
      return true;
    }
    return false;
  }

  Future<bool> updateHarvestImage(File image, String harvestID, String pictureID) async {
    String imageURL = await postImage(image);
    Map data = {
      'harvest_id': harvestID,
      'src': imageURL,
      'alt': ''
    };
    var body = json.encode(data);
    Response res = await put(Uri.parse(endPoint+'api/v1/harvest-pictures/$pictureID'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if(res.statusCode==200){
      return true;
    }
    return false;
  }
}
