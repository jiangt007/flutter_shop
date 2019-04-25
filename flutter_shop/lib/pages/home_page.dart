import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController;
  String showText = "欢迎来到HHHJJJJJJJJJJJJ";

  @override
  Widget build(BuildContext context) {
    getHttp();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('美好人间'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: '美女类型',
                  helperText: '请输入你喜欢的类型',
                ),
                autofocus: false,
              ),
              RaisedButton(
                onPressed: null,
                child: Text('选择完毕'),
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getHttp(String TypeText) async {
    try {
      Response respone;
      var data = {'name': TypeText};
      respone = await Dio().get(
          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸美女",
          queryParameters: data);
      return respone.data;
    } catch (e) {
      return print(e);
    }
  }

  void clickButton() {
    print("开始点击按钮...");
    if(textEditingController.text.toString() = ''){

    }
  }

  void getHttp() async {
    try {
      Response response;
      var data = {'name': '技术胖'};
      response = await Dio().get(
        "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸美女",
      );
      return print(response);
    } catch (e) {
      return print(e);
    }
  }
}
