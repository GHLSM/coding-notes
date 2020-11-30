# 生命周期

在原生 Android 、原生 iOS 、前端 React 或者 Vue 都存在生命周期的概念，在 Flutter 中一样存在生命周期的概念，其基本概念和作用相似。 
Flutter 中说的生命周期，也是指有状态组件，`对于无状态组件生命周期只有 build 这个过程,也只会渲染一次`

## 生命周期的流转

Flutter 中的生命周期，包含以下几个阶段：

- **createState** ，为 StatefulWidget 中创建 State 的方法，当 StatefulWidget 被调用时会立即执行 createState 。
- **initState** ，该函数为 State 初始化调用，因此可以在此期间执行 State 各变量的初始赋值，同时也可以在此期间与服务端交互，获取服务端数据后调用 setState 来设置 State。
   **注意：**这个方法是重写父类的方法，`必须调用super`，因为父类中会进行一些其他操作；
   并且如果你阅读源码，你会发现这里有一个注解`（annotation）：@mustCallSuper`



```java
@protected
@mustCallSuper
void initState() {
    assert(_debugLifecycleState == _StateLifecycle.created);
}
```

- **didChangeDependencies** ，该函数是在该组件依赖的 State 发生变化时，这里说的 State 为全局 State ，例如语言或者主题等。这个方法在两种情况下会调用：
  ·  情况一：调用initState会调用；
  ·  情况二：从其他对象中依赖一些数据发生改变时

- **build** ，主要是返回需要渲染的 Widget ，由于 build 会被调用多次，因此在该函数中只能做返回 Widget 相关逻辑，避免因为执行多次导致状态异常。
- **reassemble** ，主要是提供开发阶段使用，在 debug 模式下，每次热重载都会调用该函数，因此在 debug 阶段可以在此期间增加一些 debug 代码，来检查代码问题。
- **didUpdateWidget** ，该函数主要是在组件重新构建，比如说热重载，父组件发生 build 的情况下，子组件该方法才会被调用，其次该方法调用之后一定会再调用本组件中的 build 方法。
- **deactivate** ，在组件被移除节点后会被调用，如果该组件被移除节点，然后未被插入到其他节点时，则会继续调用 dispose 永久移除。
- **dispose** ，永久移除组件，并释放组件资源。

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128103245847.png" alt="image-20201128103245847" style="zoom:67%;" />



<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128103118424.png" alt="image-20201128103118424" style="zoom:67%;" />

整个过程分为四个阶段：

- 1.初始化阶段，包括两个生命周期函数 createState 和 initState；
- 2.组件创建阶段，也可以称组件出生阶段，包括 didChangeDependencies 和 build；
- 3.触发组件多次 build ，这个阶段有可能是因为 didChangeDependencies、setState 或者 didUpdateWidget 而引发的组件重新 build ，在组件运行过程中会多次被触发，这也是优化过程中需要着重需要注意的点；
- 4.最后是组件销毁阶段，deactivate 和 dispose。















# 初步学习(后面只列出非重复代码)

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
      debugShowCheckedModeBanner: false, //控制调试器是否显示右上角debug
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

# Scaffold组件

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201126092320402.png" alt="image-20201126092320402" style="zoom:50%;" />

```dart
Scaffold(
    appBar: AppBar( 
        title: Text("这是我的"),
    ),
    body: LayOutDemo(),
    bottomNavigationBar: BottomTabs()
),
```

## appBar参数--AppBar组件

顶部信息栏

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128090100878.png" alt="image-20201128090100878" style="zoom:80%;" />

```dart
AppBar(
    centerTitle: true,  //文字是否居中
    backgroundColor: Colors.orange,
    leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
            print("menu");
        }),
    title: Text("Practice"),
    actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
                print("search");
            })
    ],
),
```



## BottomNavigationBar组件

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201126091816286.png" alt="image-20201126091816286" style="zoom:80%;" />

```dart
class BottomTabs extends StatefulWidget {
  BottomTabs({Key key}) : super(key: key);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: this._currentIndex,
      onTap: (int index) {
        setState(() {
          this._currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text("search"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          title: Text("person"),
        ),
      ],
    );
  }
}

```

## body参数

内部放置组件，主要显示内容的界面













## tabBar参数--TabBar组件

### TabBar&DefaultTabController

​	<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128092215859.png" alt="image-20201128092215859" style="zoom:67%;" />

```dart
class _TabBarStudyPageState extends State<TabBarStudyPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, //顶部tab切换的数量
      child: Scaffold(
        appBar: AppBar(
          title: Text("tab_bar_study"),
          bottom: TabBar(
            //tabs的数量和length需要一样
            tabs: [
              Tab(
                text: "热门",
              ),
              Tab(
                text: "推荐",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                ListTile(
                  title: Text("01"),
                  subtitle: Text("0101"),
                )
              ],
            ),
            ListView(
              children: [
                ListTile(
                  title: Text("02"),
                  subtitle: Text("0202"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

```

## 在Tabs页面中使用，允许溢出滚动



<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128095951017.png" alt="image-20201128095951017" style="zoom:80%;" />

```dart
class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            //将TabBar写入title中，解决出现两个title的问题
            title: TabBar(
              isScrollable: true, //如果tabs长度大于机器长度，允许溢出滚动出现
              tabs: [
                Tab(text: "tab01",),
                Tab(text: "tab02",),
                Tab(text: "tab03",),
                Tab(text: "tab04",),
                Tab(text: "tab05",),
                Tab(text: "tab06",),
                Tab(text: "tab07",)
              ],
            ),
          ),
          body: TabBarView(children: [
            Text("01"),
            Text("02"),
            Text("03"),
            Text("04"),
            Text("05"),
            Text("06"),
            Text("07")
          ]),
        ));
  }
}
```







### TabBarController

```dart
import 'package:flutter/material.dart';

class TabControllerPage extends StatefulWidget {
  TabControllerPage({Key key}) : super(key: key);

  @override
  _TabControllerPageState createState() => _TabControllerPageState();
}

class _TabControllerPageState extends State<TabControllerPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);

    //实现一些控制操作
    _tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tabbarcontroller"),
        bottom: TabBar(
          //必须配置controller
          controller: this._tabController,
          tabs: [
            Tab(
              text: "01",
            ),
            Tab(
              text: "02",
            )
          ],
        ),
      ),
      body: TabBarView(
        //必须配置controller
        controller: this._tabController,
        children: [
          Center(
            child: Text("01"),
          ),
          Center(
            child: Text("02"),
          )
        ],
      ),
    );
  }
}
```

## drawer参数--Drawer组件

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128113806521.png" alt="image-20201128113806521" style="zoom:50%;" /><img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128114928598.png" alt="image-20201128114928598" style="zoom:50%;" /><img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128122026173.png" alt="image-20201128122026173" style="zoom:50%;" />

```dart
import 'package:flutter/material.dart';

class drawerPage extends StatefulWidget {
  var context;
  drawerPage(this.context, {Key key}) : super(key: key);

  @override
  _drawerPageState createState() => _drawerPageState(this.context);
}

class _drawerPageState extends State<drawerPage> {
  var context;
  _drawerPageState(this.context);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // //单独使用Drawerheader组件时，其内部大小不好改变，配合其他组件使用，使之扩展
          // DrawerHeader(
          //   child: Text("mine"),
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: NetworkImage(
        //"https://ns-strategy.cdn.bcebos.com/ns-strategy/upload/fc_big_pic/part-00458-565.jpg"))),

          // Row(
          //   children: [
          //     Expanded(
          //       child: DrawerHeader(
          //           child: Text("hi"),
          //           decoration: BoxDecoration(
          //               image: DecorationImage(
          //             image: NetworkImage(
          //"https://ns-strategy.cdn.bcebos.com/ns-strategy/upload/fc_big_pic/part-00458-565.jpg"),
          //             fit: BoxFit.cover,
          //           ))),
          //     )
          //   ],
          // ),

          //UserAccountsDrawerHeader格式比较固定
          Row(
            children: [
              Expanded(
                  child: UserAccountsDrawerHeader(
                      onDetailsPressed: () {
                        print("here");
                      },
                      accountName: Text("username"),
                      accountEmail: Text("useremail"),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
           "https://ns-strategy.cdn.bcebos.com/ns-strategy/upload/fc_big_pic/part-00458-565.jpg"),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
          "https://ns-strategy.cdn.bcebos.com/ns-strategy/upload/fc_big_pic/part-00684-1448.jpg")),
                      ))),
            ],
          ),

          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text("person"),
              //添加了一个点击跳转
            onTap: () {
              //将context内部的组件清出，返回时，会直接返回到Tabs页面
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/userinfo");
            },
          ),
          //横线组件,就显示一条横线
          Divider(),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.search),
            ),
            title: Text("search"),
          ),
        ],
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

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201125132641023.png" alt="image-20201125132641023" style="zoom: 33%;" />

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
  }}
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
  }}
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

设置按钮没有的属性时，考虑在外层套一个其他组件，比如Container组件，自适应加Extended布局即可

## 按钮禁用状态

```dart
onPressed: null,
//设置这个参数之后，按钮会变成灰色，表示禁用
```

## 带图标的按钮

```dart
RaisedButton.Icon(
	icon: Icon(Icons.search),
    label: Text("搜索按钮"),
    onPressed:(){}
)
```

## 圆形按钮，圆角按钮

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128132508057.png" alt="image-20201128132508057" style="zoom:80%;" /><img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128132543263.png" alt="image-20201128132543263" style="zoom:80%;" /><img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128132709719.png" alt="image-20201128132709719" style="zoom: 50%;" />

```dart
//圆角按钮
shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0)),

//圆形按钮,内部内容可能会溢出，使用Container组件包起来，设置大小
shape: CircleBorder(side: BorderSide(color: Colors.orange)),

//包起来之后的效果
Container(
    height: 120,
    child: RaisedButton(
        child: Text("Button in Search"),
        onPressed: () {},
        //圆形按钮
        shape: CircleBorder(side: BorderSide(color: Colors.orange)),
    ),
)
```



## RaisedButton组件

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
    );}}
class LayOutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UseButton("01");
  }}
```

## IconButton组件

```dart
IconButton(
    icon: Icon(Icons.menu),
    onPressed: () {
        print("menu");}),
```

## ButtonBar组件

```dart
ButtonBar(
    //对齐方式
    alignment: MainAxisAlignment.center,
    children: [
        RaisedButton(
            onPressed: () {},
            //圆角按钮
            child: Text("按钮1"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),),
        RaisedButton(
            onPressed: () {},
            //圆角按钮
            child: Text("按钮2"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
        ) ],)
```

## FloatingActionButton组件

```dart
//页面的scaffold内部设置 浮动按钮的位置
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

//FloatingActionButton组件
FloatingActionButton(
    child: Icon(
        Icons.add,
        size: 44,
        color: Colors.black,
    ),
    onPressed: () {},
    backgroundColor: Colors.yellow,
)
```

# 有状态组件(StatefulWidget)

想要实现类似于vue中的数据绑定，就需要使用这个组件，自定义组件继承这个组件，内部提供一个setState方法，在监听事件发生时，可以使用此方法改变有状态组件的内部值

```dart
//初步使用
class LayOutDemo extends StatefulWidget {
  LayOutDemo({Key key}) : super(key: key);

  @override
  _LayOutDemoState createState() => _LayOutDemoState();
}

class _LayOutDemoState extends State<LayOutDemo> {
  var str = "data";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("hi"),
          RaisedButton(
              child: Text("${this.str}"),
              onPressed: () {
                setState(() {
                  // 只有有状态组件内部才有这个方法
                  this.str = "over";
                });
              }),
          Chip(label: Text("hello"))
        ],
      ),
    );
  }
}

```

# 底部导航栏的形成

## 不拆分代码(BottomNavigationBar)

```dart
class BottomTabs extends StatefulWidget {
  BottomTabs({Key key}) : super(key: key);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: this._currentIndex,
      onTap: (int index) {
        setState(() {
          this._currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text("search"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          title: Text("person"),
        ),
      ],
    );
  }
}

```

## 代码分离，页面搭建

```dart
import 'package:flutter/material.dart';
import 'package:flutter_study_two/pages/user.dart';
import 'home.dart';
import 'Search.dart';

class BottomTabs extends StatefulWidget {
  BottomTabs({Key key}) : super(key: key);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  var _pageList = [SearchPage(), HomePage(), PersonPage()];
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("这是我的"),
          ),
          body: this._pageList[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 24.0, //Icon大小
            fixedColor: Colors.orange, //选中之后的颜色
            type: BottomNavigationBarType.fixed,  //可以显示多个导航框
            currentIndex: this._currentIndex,
              //实现动态效果
            onTap: (int index) {
              setState(() {
                this._currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text("search"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit),
                title: Text("person"),
              ),
            ],
          )),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

```

# 路由跳转

## 匿名路由

```dart
//路由跳转
Navigator.push(context,
               MaterialPageRoute(builder: (context) => SearchPage()));
```

## 命名路由

```dart
//入口文件进行路由配置
import 'package:flutter/material.dart';
import 'package:flutter_study_two/pages/Tabs/Search.dart';

class UserTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomTabs(),
      theme: ThemeData(primarySwatch: Colors.green),
      //配置路由
      routes: {"/search": (context) => SearchPage()},
    );
  }
}


//在其他地方进行命名路由跳转
//命名路由跳转
Navigator.pushNamed(context, "/search");


```

## 代码分离



![image-20201127160038944](C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201127160038944.png)

```dart
//Routes.dart
import 'package:flutter_study_two/pages/Tabs/Home.dart';
import 'package:flutter_study_two/pages/Tabs/Search.dart';

final routes = {
  "/search": (context, {arguments}) => SearchPage(),
  "/error": (context) => HomePage()
};


//RoutesHandler.dart
import 'package:flutter/material.dart';
import 'Routers.dart';

var onGenerateRoute = (RouteSettings settings) {
  //settings.name就是点击跳转时，目标组件的跳转命名
  final String name = settings.name;
  // print(settings);
  final Function pageContentBuilder = routes[name];

  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  // } else {
  //   final Route route =
  //       MaterialPageRoute(builder: (context) => SearchPage());
  //   return route;
  // }
};

```

## 命名路由传参

```dart
//路由配置
"/login": (context, {arguments}) => Login(
    arguments: arguments,
),

//传递参数模块
      //传入需要传输的数据内容
Navigator.pushNamed(context, "/login",
            		arguments: {"id": 123, "name": "gh"});
}),

//Login模块配置
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  //使用一个参数，接收内容
  // var arguments;
  Map arguments;
  Login({Key key, this.arguments}) : super(key: key);
  //在下面的类中使用，需要将数据传入
  @override
  _LoginState createState() => _LoginState(arguments: this.arguments);
}

class _LoginState extends State<Login> {
  //在这个类中申明接收这个参数
  Map arguments;
  _LoginState({this.arguments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "登陆界面",
          textAlign: TextAlign.center,
        ),
      ),
      body: Text("this is LoginPage ${this.arguments["name"]}"),
    );
  }
}

```

## 替换路由

杀死前一个发起跳转的路由页面（生命周期?）,直接取而代之

```dart
//跳转时，使用这个跳转方法
Navigator.of(context).pushReplacementNamed('routeName')
```

## 不使用替换路由直接返回某一组件

```dart
  Navigator.of(context).pushAndRemoveUntil(
                    //表示直接跳转到一个新的Tab页面，为了保持用户体验，从哪来回哪去，设置传参即可
                    MaterialPageRoute(builder: (context) => Tabs()),
                    //这参数的意思是将之前所有的route置空
                    (route) => route == null);
```

# Divider组件

```dart
//横线组件,就显示一条横线
Divider(),
```

# SizedBox组件

```dart
SizedBox()
//  const SizedBox({ Key key, this.width, this.height, Widget child })
```

# Form组件

## TextField组件、内部输入的内容获取

```dart

class Forms extends StatefulWidget {
  Forms({Key key}) : super(key: key);

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  var _username = new TextEditingController(); //给文本框赋初始值
  var _pwd;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._username.text = "123";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //输入框
        TextField(
          controller: _username,
          decoration: InputDecoration(hintText: "请输入内容"),
          onChanged: (value) {
            setState(() {
              this._username.text = value;
            });
          },
        ),
        //密码框
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextField(
            // maxLines: ,  //设置最大行数
            obscureText: true,
            decoration: InputDecoration(
                hintText: "请输入密码",
                labelText: "密码",
                icon: Icon(Icons.access_alarm)),
            onChanged: (value) {
              setState(() {
                this._pwd = value;
              });
            },
          ),
        ),
        RaisedButton(onPressed: () {
          print(this._username.text);
          print(this._pwd);
        })
      ],
    );
  }
}

//这部分有时间可以看看
//this._userTextControl = TextEditingController.fromValue(TextEditingValue(
//    text: _userTextControl.text,
//    selection: TextSelection.fromPosition(TextPosition(
//        affinity: TextAffinity.downstream,
//        offset: _userTextControl.text.length))));
```

## CheckBox & CheckboxListTile组件

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128155324173.png" alt="image-20201128155324173" style="zoom:67%;" /><img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128155350396.png" alt="image-20201128155350396" style="zoom:67%;" />       <img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128162141713.png" alt="image-20201128162141713" style="zoom:80%;" />

```dart
Row(
    children: [
        Checkbox(
            //选中之后的颜色
            activeColor: Colors.orange,
            value: this._checked,
            onChanged: (value) {
                setState(() {
                    this._checked = value;
                });
            }),
        Text(this._checked ? "选中" : "未选中")
    ],
),

//checkbox + ListTile
CheckboxListTile(
    title: Text("data"),
    subtitle: Text("01"),
    selected: this._checked, //增加这个选项，第三张截图的效果
    secondary: Icon(Icons.person),
    value: this._checked,
    onChanged: (value) {
        setState(() {
            this._checked = value;
        });
    })
```

## Radio & RadioListTile组件

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128161435881.png" alt="image-20201128161435881" style="zoom: 67%;" /><img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128161459278.png" alt="image-20201128161459278" style="zoom: 67%;" /><img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128161908790.png" alt="image-20201128161908790" style="zoom: 67%;" />

```dart
Row(
    children: [
        Text("男:"),
        Radio(
            value: "男",
            groupValue: this._sex,
            onChanged: (value) {
                setState(() {
                    this._sex = value;
                });
            }),
        SizedBox(
            width: 20,
        ),
        Text("女:"),
        Radio(
            value: "女",
            groupValue: this._sex,
            onChanged: (value) {
                setState(() {
                    this._sex = value;
                });
            }),
        SizedBox(
            width: 50,
        ),
        Text(this._sex == "男" ? "男" : "女"),
    ],
),

RadioListTile(
    value: "男",
    groupValue: this._sex,
    onChanged: (value) {
        setState(() {
            this._sex = value;
        });
    },
    title: Text("data"),
    subtitle: Text("01"),
    secondary: Icon(Icons.person),
    selected: this._sex == "男", //添加这个属性选中的时候ListTile的内容也跟着变化
),
RadioListTile(
    value: "女",
    groupValue: this._sex,
    onChanged: (value) {
        setState(() {
            this._sex = value;
        });
    },
    title: Text("data"),
    subtitle: Text("02"),
    secondary: Image.network(
        "https://ns-strategy.cdn.bcebos.com/ns-strategy/upload/fc_big_pic/part-00684-1448.jpg"),
    selected: this._sex == "女",
),
],
);
}
}

```

## Switch组件

![image-20201128162652865](C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128162652865.png)![image-20201128162716011](C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128162716011.png)

```dart
Switch(
    value: this._switch,
    onChanged: (value) {
        setState(() {
            this._switch = value;
        });
    })
```

# Date组件

## 使用内置datepick选择时间

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128173534342.png" alt="image-20201128173534342" style="zoom:80%;" /><img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128173555107.png" alt="image-20201128173555107" style="zoom:50%;" /><img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20201128173620049.png" alt="image-20201128173620049" style="zoom:50%;" />

```dart
//使用了第三方的格式化方法，但是日期获得的方式是内部的，可以用第三方插件获得日期选择器
class DateContent extends StatefulWidget {
  DateContent({Key key}) : super(key: key);

  @override
  _DateContentState createState() => _DateContentState();
}

class _DateContentState extends State<DateContent> {
  DateTime _nowDate = new DateTime.now();
  TimeOfDay _nowTime = new TimeOfDay.now();
  var _pickedDate;
  var _pickedTime;
  _datepiker() async {
    // showDatePicker(
    //         //Future类型，类似于Promise的异步类型，用回调函数获取值
    //         context: context,
    //         initialDate: this._nowDate,
    //         //时间选择器可以选择的最早时间
    //         firstDate: DateTime(1980),
    //         //时间选择器可以选择的最晚时间
    //         lastDate: DateTime(2500))
    //     .then((value) => {print(value)});

    var backDate;
    backDate = await showDatePicker(
        context: context,
        initialDate: this._nowDate,
        firstDate: DateTime(1980),
        lastDate: DateTime(2500));
    // print(backDate);
    setState(() {
      this._pickedDate = backDate;
    });
  }

  _timepiker() async {
    var backTime =
        await showTimePicker(context: context, initialTime: this._nowTime);
    setState(() {
      this._nowTime = backTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    var date = formatDate(
        this._pickedDate != null ? this._pickedDate : this._nowDate,
        [yyyy, "-", mm, "-", dd]);
    var time = this._pickedTime == null ? this._nowTime : this._pickedTime;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //用来给没有监听函数的组件添加事件监听
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(date), Icon(Icons.arrow_drop_down)],
          ),
          onTap: this._datepiker,
        ),
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${time.format(context)}"),
              Icon(Icons.arrow_drop_down)
            ],
          ),
          onTap: this._timepiker,
        )
      ],
    );
  }
}

```

## 使用第三方库的datepick







# 网络数据请求

## http库

```dart
import 'package:http/http.dart' as http;  

//请求数据
  _getData() async {
    var apiUrl = "http://127.0.0.1:8000/books2";

    var result = await http.get(apiUrl);
    if (result.statusCode == 200) {
      print(result);
      setState(() {
        this._books = jsonDecode(result.body);
      });
    } else {
      print(result.statusCode);
    }
  }

  //POST提交数据
  _postData() async {
    var apiUrl = "http://127.0.0.1:8000/books2";
    var result = await http.post(apiUrl, body: {"Json格式的数据"});
    if (result.statusCode == 200) {
      
    } else {

    }
  }
```

## Dio库



