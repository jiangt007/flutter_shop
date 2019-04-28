import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future getHomePageContent() async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContext']);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端获取数据异常，请检测后端代码和服务器情况.......');
    }
  } catch (e) {
    return print('Error ===================>${e}');
  }
}
