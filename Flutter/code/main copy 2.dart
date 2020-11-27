import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(UserOne());
}

class UserOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello"),
        ),
        body: HoemContent(),
      ),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

class HoemContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Container(
      width: 300.0,
      height: 300.0,

      // //实现圆角图片方式二
      // child: ClipOval(
      //   child: Image.network(
      //     "iamge_url",
      //     //结合图片组件的高宽度,可以实现固定大小的圆角图片
      //     //如果不结合高宽度，有点类似于直接给组件增加了50%的borderRadius（椭圆）
      //     height: 100.0,
      //     width: 100.0,
      //     fit: BoxFit.cover,
      //     ),
      // ),

      decoration: BoxDecoration(
        color: Colors.green,

        // //实现圆角图片方式一
        // borderRadius: BorderRadius.circular(150),
        // image: DecorationImage(
        //   image: NetworkImage(
        //     "image_url"
        //   ),
        //   fit: BoxFit.cover
        // )
      ),
      // child: Image.network('url'), // 加载远程图片
      child: Image.asset(
        "images/a.jpeg",
        alignment: Alignment.bottomCenter, //图片对齐方式

        // color: , //和colorBlendMode一起使用，构建图片颜色,不怎么使用
        // colorBlendMode: ,
        fit: BoxFit.cover, // 图片再container内部的展开方式,平铺...
      ),
    ));
  }
}
