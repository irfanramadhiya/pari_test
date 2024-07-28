import 'package:flutter/material.dart';
import 'package:pari_test/models/gadget.dart';
import 'package:dio/dio.dart';
import 'package:pari_test/viewmodels/add_viewmodel.dart';
import 'package:pari_test/viewmodels/detail_viewmodel.dart';
import 'package:pari_test/viewmodels/edit_viewmodel.dart';
import 'package:pari_test/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class Service {
  String baseUrl = "https://api.restful-api.dev";

  Future<List<Gadget>?> getGadgetList(
      String errorText, BuildContext context) async {
    try {
      var response = await Dio().get('$baseUrl/objects');
      try {
        return Gadget.listFromJson(response.data);
      } catch (e) {
        context.read<HomeViewModel>().setErrorText(e.toString());
        return null;
      }
    } on DioException catch (e) {
      context.read<HomeViewModel>().setErrorText(e.toString());
      return null;
    }
  }

  Future<Gadget?> getGadget(
      String id, String errorText, BuildContext context) async {
    try {
      var response = await Dio().get('$baseUrl/objects/$id');
      try {
        return Gadget.fromJson(response.data);
      } catch (e) {
        context.read<DetailViewModel>().setGetGadgetErrorText(e.toString());
        return null;
      }
    } on DioException catch (e) {
      context.read<DetailViewModel>().setGetGadgetErrorText(e.toString());
      return null;
    }
  }

  Future<String> deleteGadget(
      String id, String errorText, BuildContext context) async {
    try {
      var response = await Dio().delete('$baseUrl/objects/$id');

      return response.toString();
    } on DioException catch (e) {
      context
          .read<DetailViewModel>()
          .setDeleteGadgetErrorText(e.response.toString());
      return "";
    }
  }

  Future<String> addGadget(
      Gadget gadget, String errorText, BuildContext context) async {
    try {
      var response = await Dio().post('$baseUrl/objects', data: {
        "name": gadget.name,
        "data": {"color": gadget.data?.color, "Capacity": gadget.data?.capacity}
      });
      return response.toString();
    } on DioException catch (e) {
      context.read<AddViewModel>().setErrorText(e.toString());
      return "";
    }
  }

  Future<String> updateGadget(
      Gadget gadget, String errorText, BuildContext context) async {
    try {
      var response = await Dio().put('$baseUrl/objects/${gadget.id}', data: {
        "name": gadget.name,
        "data": {"color": gadget.data?.color, "Capacity": gadget.data?.capacity}
      });
      return response.toString();
    } on DioException catch (e) {
      context.read<EditViewModel>().setErrorText(e.response.toString());
      return "";
    }
  }
}
