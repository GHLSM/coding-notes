



# 初步学习(后面只列出HomeContent内部代码)

```dart
import 'package:flutter/material.dart';

// 所有的组件都是一个类，使用时实例化
void main() {
  runApp(Hello());
}

class Hello extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return HomeContent();
    return MaterialApp(  //MaterialApp作为根组件
      home:Scaffold(
        appBar: AppBar(  //顶部导航
          title: Text("Flutter demo"),
        ),
        body: HomeContent(),
      ),
      theme: ThemeData(
        primarySwatch: Colors.yellow //改变主题颜色
      ),
    );

  }
}

class HomeContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(
        '你好',
        textDirection: TextDirection.ltr,
        style: TextStyle(
            fontSize: 40.0,
            // color: Colors.red,
            // color: Color.fromARGB(244, 233, 121, 1)
            color: Color.fromRGBO(244, 233, 121, 0.5)
        ),
      ),
    );
  }
}
```

# container&Text组件

```dart
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
```

# 图片组件(Image,ClipOval)

```dart
class HoemContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Container(
      width: 300.0,
      height: 300.0,

      // //实现圆型图片方式二
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
```

# 列表组件（ListView、ListTile）

**ListView组件无法嵌套ListView组件**

## 结合ListTile组件（图标组件Icon）

```dart
class HoemContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ListView(
          // padding: ,  //修改padding参数
          children: <Widget>[
            //内部可以使用图片组件
            //配合ListTile组件使用
            ListTile(
              //加一个前置图标
              leading: Icon(
                Icons.settings,
                color: Colors.green,
                size: 30,
              ),
              // // 可以也只可以加一个前置图片
              // leading: Image.network(
              //   "iamge_url",
              //   //写内部样式
              //   ),
                
              title: Text(
                "001",
                style: TextStyle(fontSize: 24),
              ),
              subtitle: Text("002"),

              //加一个后置图标
              // trailing: ,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                "001",
                style: TextStyle(fontSize: 24),
              ),
              subtitle: Text("002"),
            ),
          ],
        ),
      ),
    );
  }
}

```

## 结合其他组件

```dart
class HoemContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Image.network('image_url'),
        Image.network('image_url'),
        Image.network('image_url'),
        Container(height: 10,),
        Text("data",),
      ],
    );
  }
}
```

## 动态列表组件(ListView Builder)

```dart
class HoemContent extends StatelessWidget {
  List<Widget> _getData() {
    List<Widget> li = new List();
    for (var i = 0; i < 20; i++) {
      li.add(ListTile(
        title: Text("我是 $i 列表"),
      ));
    }
    return li;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: this._getData(),
    );
  }
}
```

```dart
class HoemContent extends StatelessWidget {
  List list = new List();
  HoemContent(){
    for(var i=0; i<20; i++){
      this.list.add("我是第 $i 条");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: this.list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              this.list[index]
          ));
        });
  }
}
```

# 网格布局组件（GridView）

```dart
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // GridView.count方法实现网格布局
    return GridView.count(
      //网格列数
      crossAxisCount: 3,
      //内部元素
      children: [
        Text("data"),
        Text("data"),
        Text("data"),
        Text("data"),
        Text("data"),
        Text("data")
      ],
    );
  }
}
```

```dart
class LayOutDemo extends StatelessWidget {
  List<Widget> _getData() {
    List<Widget> list = new List();
    for (var i = 0; i < 20; i++) {
      list.add(Container(
        alignment: Alignment.center,
        color: Colors.blue,
        child: Text(
          "第 $i 个",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // GridView.count方法实现网格布局
    return GridView.count(
        //横向网格间隙
        crossAxisSpacing: 20.0,
        //竖向网格间隙
        mainAxisSpacing: 20.0,
        //增加和屏幕的间隙
        padding: EdgeInsets.all(10.0),
        //网格列数
        crossAxisCount: 3,
        //内部元素
        children: this._getData());
  }
}
```

## 渲染数据的获取

```dart
/**
 * 数据格式如下：*/
List listData = [
  {"title": "candySupr", "author": "sdasd", "imageUrl": "..."}
];

class LayOutDemo extends StatelessWidget {
  List<Widget> _getData() {
    var tempList = listData.map((value) {
      return Container(
        // Colum 有点像竖着的ListView
        child: Column(
          children: [Image.network(value["imageUrl"]), Text(value["title"])],
        ),
      );
    });
    //map返回的数据不是数组，转换成数组
    return tempList.toList();
  }
```

## 动态网格布局（GridView.Builder） 

```dart
/**
 * 数据格式如下：*/
List listData = [
  {"title": "candySupr", "author": "sdasd", "imageUrl": "..."}
];

class LayOutDemo extends StatelessWidget {
  Widget _getData(count, index) {
    return Container(
      // Colum 有点像竖着的ListView
      child: Column(
        children: [
          Image.network(listData[index]["imageUrl"]),
          Text(listData[index]["title"])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // GridView.count方法实现网格布局
    return GridView.builder(
        //配置网格的样式
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //在这内部的网格样式和GridView.count内部一样
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0
        ),
        //数据的个数，为了Builder的内部循环的index计数
        itemCount: listData.length,
        //不用加括号运行
        itemBuilder: this._getData);
  }
}
//想要使用padding，在外部加一个大的Container，使之和外部间距符合想法
```

# Padding组件（无padding属性时使用）

```dart
Padding(
    //padding值，fromLTRB，左上右下的padding值
    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
    //内部组件
    child: Image.network("image_url"),
),
```

# 水平布局组件（Row）

```dart
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // GridView.count方法实现网格布局
    return Container(
        height: 800,
        width: 500,
        child: Row(
          //组件内次轴布局,默认为center
          crossAxisAlignment: CrossAxisAlignment.center,
          //组件内主轴布局,此组件主轴为横向
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconContainer(Icons.search, color: Colors.yellow),
            IconContainer(Icons.home, color: Colors.green[50]),
            IconContainer(
              Icons.search_off,
              color: Colors.deepOrange,
            )
          ],
        ));
  }
}

class IconContainer extends StatelessWidget {
  double size = 32.0;
  Color color = Colors.green;
  IconData icon;
  // 函数无内容，无需写{}
  IconContainer(this.icon, {this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        width: 100.0,
        color: this.color,
        child: Center(
          child: Icon(
            this.icon,
            size: this.size,
            color: Colors.black,
          ),
        ));
  }
}
```

# 竖向布局（Colum）

```dart
//和Row几乎一模一样，不过方向完全相反
```

# 自由布局（Expanded）

有点类似于flex布局

![](C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201125111604625.png)

```dart
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // GridView.count方法实现网格布局
    return Row(
      children: [
        //1:2
        Expanded(
            flex: 1, child: IconContainer(Icons.search, color: Colors.yellow)),
        Expanded(
            flex: 2, child: IconContainer(Icons.home, color: Colors.green[50])),
      ],
    );
  }
}
```

## 自适应

![image-20201125112014573](C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201125112014573.png)

```dart
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // GridView.count方法实现网格布局
    return Row(
      children: [
        Expanded(
            flex: 1, child: IconContainer(Icons.search, color: Colors.yellow)),
        IconContainer(Icons.home, color: Colors.orange)
      ],
    );
  }
}
```

# 层叠组件（Stack）

```dart
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // GridView.count方法实现网格布局
    return Center(
      child: Stack(
        //有点类似于将每一个组件增加了一个Z轴信息

        //内部所有元素居中
        // alignment: Alignment.center,

        //设置所有元素的特定位置,第一个参数为X轴，第二个参数为Y轴，中心为(0,0)
        alignment: Alignment(0, 0.5),
        
        children: [
          Container(
            height: 400,
            width: 300,
            color: Colors.green[50],
          ),
          Text("data"),
          Text("data2")
        ],
      ),
    );
  }
}

```

## Stack-Align

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201125132641023.png" alt="image-20201125132641023" style="zoom:50%;" />

```dart
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        width: 300,
        color: Colors.yellow,
        child: Stack(
          children: [
            //使用Align控制每一个组件的位置
            Align(
              alignment: Alignment(1, 0.2),
              child: Icon(
                Icons.search,
                size: 50,
                color: Colors.green,
              ),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Icon(
                Icons.home,
                size: 50,
                color: Colors.green,
              ),
            ),
            Align(
              alignment: Alignment(-0.5, -0.5),
              child: Icon(
                Icons.send,
                size: 50,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}
```

## stack-Position

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201125133125767.png" alt="image-20201125133125767" style="zoom:50%;" />

```dart
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        width: 300,
        color: Colors.yellow,
        child: Stack(
          children: [
            //使用Align控制每一个组件的位置
            Positioned(
              //控制离容器边的距离
              left: 20,
              top: 100,
              //right bottom
              child: Icon(
                Icons.search,
                size: 50,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

# AspectRatio组件

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201125134027692.png" alt="image-20201125134027692" style="zoom:50%;" />



```dart
//效果图中的浅绿色宽高比是：aspectRatio: 3.0 / 1.0
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //AxpectRatio常用于图片等组件的平铺
    return AspectRatio(
      //横向/纵向,AspectRatio是针对于父组件而言的（最大的父组件是屏幕）
      aspectRatio: 3.0 / 1.0,
      //用子组件占满，添加颜色，更好看效果
      child: Container(
        color: Colors.green[50],
      ),
    );
  }
}

```

# Card组件

## 初步使用(Card+ListTile)

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201125135802415.png" alt="image-20201125135802415" style="zoom:80%;" />

```dart
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          margin: EdgeInsets.all(15),
          color: Colors.green[50],
          //阴影颜色
          shadowColor: Colors.orange,
          //阴影偏移
          elevation: 5,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "耿號",
                  style: TextStyle(fontSize: 30),
                ),
                subtitle: Text("高级工程师"),
              ),
              ListTile(
                title: Text("phone:"),
              ),
              ListTile(title: Text("addr:"))
            ],
          ),
        )
      ],
    );
  }
}
```

## 实现效果（Card+AspectRatio+ClipOval+ListTile）

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201125141431021.png" alt="image-20201125141431021" style="zoom:80%;" />

```dart
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          margin: EdgeInsets.all(15),
          color: Colors.green[50],
          //阴影颜色
          shadowColor: Colors.orange,
          //阴影偏移
          elevation: 5,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606294429104&di=97a8e004f1757a277d9333fdcb820018&imgtype=0&src=http%3A%2F%2Fdik.img.kttpdq.com%2Fpic%2F73%2F50657%2Fb768771c63e69a84.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                  leading: ClipOval(
                    child: Image.network(
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606294429104&di=97a8e004f1757a277d9333fdcb820018&imgtype=0&src=http%3A%2F%2Fdik.img.kttpdq.com%2Fpic%2F73%2F50657%2Fb768771c63e69a84.jpg",
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  title: Text("耿號"))
            ],
          ),
        )
      ],
    );
  }
}
```

## 使用map循环产生多个Card

```dart
List listData = [
  {"iamge_url": "", "avatar_url": "", "title": "", "descripton": ""},
  {"iamge_url": "", "avatar_url": "", "title": "", "descripton": ""}
];

class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: listData.map((value) {
        return Card(
          margin: EdgeInsets.all(15),
          color: Colors.green[50],
          shadowColor: Colors.orange,
          elevation: 5,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  value["iamge_url"],
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(value["avatar_url"]),
                ),
                title: Text(value["title"]),
                subtitle: Text(value["descripton"]),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
```





# 圆形头像组件(CircleAvatar)

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201125142200029.png" alt="image-20201125142200029" style="zoom:67%;" />

```dart
ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606294429104&di=97a8e004f1757a277d9333fdcb820018&imgtype=0&src=http%3A%2F%2Fdik.img.kttpdq.com%2Fpic%2F73%2F50657%2Fb768771c63e69a84.jpg"),
                  ),
                  title: Text("耿號"))
```

# 数据流布局(Wrap)

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201125150159339.png" alt="image-20201125150159339" style="zoom:80%;" />

```dart
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      //设置主轴方向，默认为水平
      direction: Axis.horizontal,
      //主轴对齐方式,指的是不同长度的内容对其的方式
      // alignment: WrapAlignment.end,
      //主轴方向间距
      spacing: 10,
      //次轴间距
      runSpacing: 20,
      //次轴对齐方式
      // runAlignment: ,
      crossAxisAlignment: WrapCrossAlignment.center,

      children: [
        UseButton("04531"),
        UseButton("054641"),
        UseButton("051"),
        UseButton("01"),
        UseButton("01457878"),
        UseButton("01"),
        UseButton("015434532248"),
      ],
    );
  }
}
```

# Button组件

## 初步学习

```dart
class UseButton extends StatelessWidget {
  String name;
  UseButton(this.name);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(this.name),
      textColor: Theme.of(context).accentColor,
      onPressed: () {},
    );
  }
}

class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UseButton("01");
  }
}
```

