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
      // 类似于div标签
      child: Text(
        "我的",
        textAlign: TextAlign.center, //文本对齐格式，还有right,left,justify,start,end
        // 设置更多的style
        style: TextStyle(
            fontSize: 18.0,
            // fontStyle: , 设置文字样式italic为斜体，normal为正常体
            // color: ,设置字体颜色
            // fontWeight: ,设置是否加粗，bold加粗，normal正常，也有更多可调值w600...
            // letterSpacing: ,字间距（负值会让文字紧密）
            // wordSpacing: ,设置字符间距
            decoration: TextDecoration
                .lineThrough, //设置文本装饰线，还有underline,overline,none三个属性
            decorationColor: Colors.green, //设置文本装饰线颜色
            decorationStyle: TextDecorationStyle.dashed //设置装饰线样式

            ),
        // overflow: TextOverflow.ellipsis,// 溢出变成三个点
        overflow: TextOverflow.clip, // 直接裁剪
        // overflow: TextOverflow.fade, //配合maxLines使用，是渐变效果
        // maxLines: 1, //文本最大的显示行数
        // textScaleFactor: 2,  //字体放大倍数
      ),
      alignment: Alignment.bottomCenter, //设置内部对齐方式
      height: 300.0, //高度，由于是double类型，加.0否则报错
      width: 300.0,
      // color: Colors.black,  color参数和BoxDecoration不能同时给
      decoration: BoxDecoration(
        //对容器进行修饰
        color: Colors.yellow,
        border: Border.all(color: Colors.blue, width: 2.0), // 内部是一个工厂模式

        //borderRadius用法比较怪，注意
        borderRadius: BorderRadius.all(Radius.circular(20.0) //圆角
            ),
      ),
      // margin: ,
      // padding: EdgeInsets.all(10),
      // transform: , 组件移动，旋转等
    ));
  }
}
