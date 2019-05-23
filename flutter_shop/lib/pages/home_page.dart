import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('百姓生活+'),),
        body:FutureBuilder(
          future:getHomePageContent(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var data=json.decode(snapshot.data.toString());
              List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 顶部轮播组件数
              List<Map> navigatorList = (data['data']['category'] as List).cast();
              String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];

              return SingleChildScrollView(
                child:  Column(
                  children: <Widget>[
                    SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
                    TopNavigator(navigatorList: navigatorList,),
                    AdBanner(adPicture: adPicture),
                    LeaderPhone(leaderImage: leaderImage,leaderPhone:leaderPhone)
                  ],
                ),
              );
            }else{
              return Center(
                child: Text('加载中...'),
              );
            }
          },
        )
    );

  }
}

// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance  = ScreenUtil(width: 750,height: 1334)..init(context);
    print('设备像素密度:${ScreenUtil.pixelRatio}');
    print('设备高:${ScreenUtil.screenHeight}');
    print('设备款:${ScreenUtil.screenWidth}');
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.network("${swiperDataList[index]['image']}",fit:BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key,this.navigatorList}) : super(key:key);

  Widget _gridViewItemUI(BuildContext context,item){
    return InkWell(
      onTap:(){print('点击了导航项');},
        child: Column(
          children: <Widget>[
            Image.network(item['image'],width: ScreenUtil().setWidth(95)),
            Text(item['mallCategoryName'])
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(navigatorList.length >10)
      navigatorList.removeRange(10, navigatorList.length);
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

//广告条
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key,this.adPicture}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderPhone;
  final String leaderImage;

  LeaderPhone({Key key,this.leaderImage,this.leaderPhone}) : super(key :key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){},
        child: Image.network(leaderImage),
      )
    );
  }
}

//商品推荐
class CommodityRecommend extends StatelessWidget {
  List recommendList;

  CommodityRecommend({Key key,this.recommendList}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(330),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommedList()
        ],
      ),
    );
  }

  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0,2.0,0.0,5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:Border(bottom: BorderSide(width: 0.5,color: Colors.black12))
      ),
      child: Text('商品推荐',style: TextStyle(color: Colors.pink),),
    );
  }

  Widget _item(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5,color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('${recommendList[index]['mallPrice']}'),
            Text(
              '${recommendList[index]['price']}',
              style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey)
            ),
          ],
        )
      ),
    )
  }

  Widget _recommedList(){
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder:(context,index){return _item(index);}
          ),
    );
  }
}





