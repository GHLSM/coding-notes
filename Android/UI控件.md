# TextView(文本框)详解

## 基础属性详解

布局代码：

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity"
    android:gravity="center"
    android:background="#8fffad">

    <TextView
        android:id="@+id/txtOne"
        android:layout_width="200dp"
        android:layout_height="200dp"
        android:gravity="center"
        android:text="TextView(显示框)"
        android:textColor="#EA5246"
        android:textStyle="bold|italic"
        android:background="#000000"
        andorid:textAlignment="center"
        android:textSize="18sp" />

</RelativeLayout>
```

上面的TextView中有下述几个属性:

- **id：**为TextView设置一个组件id，根据id，我们可以在Java代码中通过findViewById()的方法获取到该对象，然后进行相关属性的设置，又或者使用RelativeLayout时，参考组件用的也是id！
- **layout_width：**组件的宽度，一般写：**wrap_content**或者**match_parent(fill_parent)**，前者是控件显示的内容多大，控件就多大，而后者会填满该控件所在的父容器；当然也可以设置成特定的大小，比如我这里为了显示效果，设置成了200dp。
- **layout_height：**组件的高度，内容同上。
- **gravity：**设置控件中内容的对齐方向，TextView中是文字，ImageView中是图片等等。
- **text：**设置显示的文本内容，一般我们是把字符串写到string.xml文件中，然后通过@String/xxx取得对应的字符串内容的，这里为了方便我直接就写到""里，不建议这样写！！！
- **textColor：**设置字体颜色，同上，通过colors.xml资源来引用，别直接这样写！
- **textStyle：**设置字体风格，三个可选值：**normal**(无效果)，**bold**(加粗)，**italic**(斜体)
- **textSize：**字体大小，单位一般是用sp！
- **background：**控件的背景颜色，可以理解为填充整个控件的颜色，可以是图片哦！
- **andorid:textAlignment="center"**:文字对齐方式

## 带阴影的TextView

涉及到的几个属性：

- **android:shadowColor:**设置阴影颜色,需要与shadowRadius一起使用
- **android:shadowRadius:**设置阴影的模糊程度,设为0.1就变成字体颜色了,建议使用3.0
- **android:shadowDx:**设置阴影在水平方向的偏移,就是水平方向阴影开始的横坐标位置
- **android:shadowDy:**设置阴影在竖直方向的偏移,就是竖直方向阴影开始的纵坐标位置

## 带边框的TextView

> 如果你想为TextView设置一个边框背景，普通矩形边框或者圆角边框！
> 另外TextView是很多其他控件的父类，比如Button，也可以设置这样的边框！ 
> 实现原理：自行编写一个ShapeDrawable的资源文件！然后TextView将blackgroung 设置为这个drawable资源即可！

简单说下shapeDrawable资源文件的几个节点以及属性：

> - <**solid** android:color = "xxx"> 这个是设置背景颜色的
> - <**stroke** android:width = "xdp" android:color="xxx"> 这个是设置边框的粗细,以及边框颜色的
> - <**padding** androidLbottom = "xdp"...> 这个是设置边距的
> - <**corners** android:topLeftRadius="10px"...> 这个是设置圆角的
> - <**gradient**> 这个是设置渐变色的,可选属性有: **startColor**:起始颜色 **endColor**:结束颜色 **centerColor**:中间颜色 **angle**:方向角度,等于0时,从左到右,然后逆时针方向转,当angle = 90度时从下往上 **type**:设置渐变的类型

实现效果图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/36413391.jpg)

代码实现：

Step 1:编写矩形边框的Drawable：

```xml
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" >

    <!-- 设置一个黑色边框 -->
    <stroke android:width="2px" android:color="#000000"/>
    <!-- 渐变 -->
    <gradient
        android:angle="270"
        android:endColor="#C0C0C0"
        android:startColor="#FCD209" />
    <!-- 设置一下边距,让空间大一点 -->
    <padding
        android:left="5dp"
        android:top="5dp"
        android:right="5dp"
        android:bottom="5dp"/>

</shape> 
```

Step 2:编写圆角矩形边框的Drawable：

```xml
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- 设置透明背景色 -->
    <solid android:color="#87CEEB" />

    <!-- 设置一个黑色边框 -->
    <stroke
        android:width="2px"
        android:color="#000000" />
    <!-- 设置四个圆角的半径 -->
    <corners
        android:bottomLeftRadius="10px"
        android:bottomRightRadius="10px"
        android:topLeftRadius="10px"
        android:topRightRadius="10px" />
    <!-- 设置一下边距,让空间大一点 -->
    <padding
        android:bottom="5dp"
        android:left="5dp"
        android:right="5dp"
        android:top="5dp" />
        
</shape>
```

Step 3:将TextView的blackground属性设置成上面这两个Drawable：

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="#FFFFFF"
    android:gravity="center"
    android:orientation="vertical"
    tools:context=".MainActivity">

    <TextView
        android:id="@+id/txtOne"
        android:layout_width="200dp"
        android:layout_height="64dp"
        android:textSize="18sp"
        android:gravity="center"
        android:background="@drawable/txt_rectborder"
        android:text="矩形边框的TextView" />

    <TextView
        android:id="@+id/txtTwo"
        android:layout_width="200dp"
        android:layout_height="64dp"
        android:layout_marginTop="10dp"
        android:textSize="18sp"
        android:gravity="center"
        android:background="@drawable/txt_radiuborder"
        android:text="圆角边框的TextView" />


</LinearLayout>
```

## 带图片(drawableXxx)的TextView

在实际开发中，我们可能会遇到这种需求：

![img](https://www.runoob.com/wp-content/uploads/2015/07/68693829.jpg)

如图，要实现这种效果，可能你的想法是：
一个ImageView用于显示图片 + 一个TextView用于显示文字，然后把他们丢到一个LinearLayout中，接着依次创建四个这样的小布局，再另外放到一个大的LinearLayout中
使用drawableXxx就可以省掉上面的过程，直接设置四个TextView就可以完成我们的需求！

**基本用法：**

设置图片的核心其实就是:**drawableXxx**;可以设置四个方向的图片: **drawableTop**(上),**drawableButtom**(下),**drawableLeft**(左),**drawableRight**(右) 
也可以使用**drawablePadding**来设置图片与文字间的间距！

**效果图**：(设置四个方向上的图片)

![img](https://www.runoob.com/wp-content/uploads/2015/07/46436386.jpg)

**实现代码：**

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"  
    xmlns:tools="http://schemas.android.com/tools"  
    android:layout_width="match_parent"  
    android:layout_height="match_parent"  
    tools:context="com.jay.example.test.MainActivity" >  
  
    <TextView  
        android:layout_width="wrap_content"  
        android:layout_height="wrap_content"  
        android:layout_centerInParent="true"  
        android:drawableTop="@drawable/show1"  
        android:drawableLeft="@drawable/show1"  
        android:drawableRight="@drawable/show1"  
        android:drawableBottom="@drawable/show1"  
        android:drawablePadding="10dp"  
        android:text="张全蛋" />  
  
</RelativeLayout> 
```

**一些问题：**这样设置的drawable并不能自行设置大小，在XML是无法直接设置的；需要在Java代码中来进行一个修改！

示例代码如下：

```java
package com.jay.example.test;  
  
import android.app.Activity;  
import android.graphics.drawable.Drawable;  
import android.os.Bundle;  
import android.widget.TextView;  
  
public class MainActivity extends Activity {  
    private TextView txtZQD;  
  
    @Override  
    protected void onCreate(Bundle savedInstanceState) {  
        super.onCreate(savedInstanceState);  
        setContentView(R.layout.activity_main);  
        txtZQD = (TextView) findViewById(R.id.txtZQD);  
        Drawable[] drawable = txtZQD.getCompoundDrawables();  
        // 数组下表0~3,依次是:左上右下  
        drawable[1].setBounds(100, 0, 200, 200);  
        txtZQD.setCompoundDrawables(drawable[0], drawable[1], drawable[2],  
                drawable[3]);  
    }  
} 
```

运行效果图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/88806164.jpg)

**代码分析：**

> - ①Drawable[] drawable = txtZQD.getCompoundDrawables( ); 
>   获得四个不同方向上的图片资源,数组元素依次是:左上右下的图片
> - ②drawable[1].setBounds(100, 0, 200, 200);
>   调用setBounds设置左上右下坐标点
>    长是:从离文字最左边开始100dp处到200dp处 宽是:从文字上方0dp处往上延伸200dp!
> - ③txtZQD.setCompoundDrawables(drawable[0], drawable[1], drawable[2], drawable[3]);
>   为TextView重新设置drawable数组
>   没有图片可以用null代替哦!
>   另外，也可以直接在Java代码中调用setCompoundDrawables为 TextView设置图片

## 使用autoLink属性识别链接类型

当文字中出现了URL，E-Mail，电话号码，地图的时候，我们可以通过设置autoLink属性；当我们点击 文字中对应部分的文字，即可跳转至某默认APP，比如一串号码，点击后跳转至拨号界面！

![img](https://www.runoob.com/wp-content/uploads/2015/07/59234627.jpg)

all就是全部都包含,自动识别协议头~ 
在Java代码中可以调用setAutoLinkMask(Linkify.ALL); 这个时候可以不写协议头,autolink会自动识别
但是还要为这个TextView设置： setMovementMethod(LinkMovementMethod.getInstance()); 

## TextView玩转HTML

> 如题，除了显示普通文本外，TextView还预定义了一些类似于HTML的标签，通过这些标签，我们可以使 TextView显示不同的字体颜色，大小，字体，甚至是显示图片，或者链接等！我们只要使用HTML中的一些 标签，加上android.text.HTML类的支持，即可完成上述功能！

PS:当然，并不是支持所有的标签，常用的有下述这些：

> - <**font**>：设置颜色和字体。
> - <**big**>：设置字体大号
> - <**small**>：设置字体小号
> - <**i**><**b**>：斜体粗体
> - <**a**>：连接网址
> - <**img**>：图片

如果直接setText的话是没作用的
调用Html.fromHtml()方法将字符串转换为CharSequence接口
再进行设置，如果我们需要相应设置，需要为TextView进行设置
调用下述方法： Java setMovementMethod(LinkMovementMethod.getInstance())

**1）测试文本与超链接标签**

```java
package jay.com.example.textviewdemo;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.Html;
import android.text.method.LinkMovementMethod;
import android.text.util.Linkify;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        TextView t1 = (TextView)findViewById(R.id.txtOne);
        String s1 = "<font color='blue'><b>百度一下，你就知道~：</b></font><br>";
        s1 += "<a href = 'http://www.baidu.com'>百度</a>";
        t1.setText(Html.fromHtml(s1));
        t1.setMovementMethod(LinkMovementMethod.getInstance());
    }
}
```

**测试src标签，插入图片：**

看下运行效果图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/62308635.jpg)

接下来看下实现代码，实现代码看上去有点复杂，用到了反射(对了，别忘了在drawable目录下放一个icon的图片哦！)：

```java
public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        TextView t1 = (TextView) findViewById(R.id.txtOne);
        String s1 = "图片：<img src = 'icon'/><br>";
        t1.setText(Html.fromHtml(s1, new Html.ImageGetter() {
            @Override
            public Drawable getDrawable(String source) {
                Drawable draw = null;
                try {
                    Field field = R.drawable.class.getField(source);
                    int resourceId = Integer.parseInt(field.get(null).toString());
                    draw = getResources().getDrawable(resourceId);
                    draw.setBounds(0, 0, draw.getIntrinsicWidth(), draw.getIntrinsicHeight());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return draw;
            }
        }, null));
    }
}
```

##  SpannableString&SpannableStringBuilder定制文本

> 除了上面的HTML可以定制我们TextView的样式外，还可以使用SpannableString和SpannableStringBuilder来完成，两者区别：前者针对的是不可变文本，而后者则是针对可变文本，这里只讲解前者，对后者有兴趣可自行查阅文本！

SpannableString可供我们使用的API有下面这些：

> - **BackgroundColorSpan** 背景色
> - **ClickableSpan** 文本可点击，有点击事件
> - **ForegroundColorSpan** 文本颜色（前景色）
> - **MaskFilterSpan** 修饰效果，如模糊(BlurMaskFilter)、浮雕(EmbossMaskFilter)
> - **MetricAffectingSpan** 父类，一般不用
> - **RasterizerSpan** 光栅效果
> - **StrikethroughSpan** 删除线（中划线）
> - **SuggestionSpan** 相当于占位符
> - **UnderlineSpan** 下划线
> - **AbsoluteSizeSpan** 绝对大小（文本字体）
> - **DynamicDrawableSpan** 设置图片，基于文本基线或底部对齐。
> - **ImageSpan** 图片
> - **RelativeSizeSpan** 相对大小（文本字体）
> - **ReplacementSpan** 父类，一般不用
> - **ScaleXSpan** 基于x轴缩放
> - **StyleSpan** 字体样式：粗体、斜体等
> - **SubscriptSpan** 下标（数学公式会用到）
> - **SuperscriptSpan** 上标（数学公式会用到）
> - **TextAppearanceSpan** 文本外貌（包括字体、大小、样式和颜色）
> - **TypefaceSpan** 文本字体
> - **URLSpan** 文本超链接

 **1）最简单例子：** 运行效果图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/22818005.jpg)

实现代码：

```java
public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        TextView t1 = (TextView) findViewById(R.id.txtOne);
        TextView t2 = (TextView) findViewById(R.id.txtTwo);

        SpannableString span = new SpannableString("红色打电话斜体删除线绿色下划线图片:.");
        //1.设置背景色,setSpan时需要指定的flag,Spanned.SPAN_EXCLUSIVE_EXCLUSIVE(前后都不包括)
        span.setSpan(new ForegroundColorSpan(Color.RED), 0, 2, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        //2.用超链接标记文本
        span.setSpan(new URLSpan("tel:4155551212"), 2, 5, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        //3.用样式标记文本（斜体）
        span.setSpan(new StyleSpan(Typeface.BOLD_ITALIC), 5, 7, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        //4.用删除线标记文本
        span.setSpan(new StrikethroughSpan(), 7, 10, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        //5.用下划线标记文本
        span.setSpan(new UnderlineSpan(), 10, 16, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        //6.用颜色标记
        span.setSpan(new ForegroundColorSpan(Color.GREEN), 10, 13,Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        //7.//获取Drawable资源
        Drawable d = getResources().getDrawable(R.drawable.icon);
        d.setBounds(0, 0, d.getIntrinsicWidth(), d.getIntrinsicHeight());
        //8.创建ImageSpan,然后用ImageSpan来替换文本
        ImageSpan imgspan = new ImageSpan(d, ImageSpan.ALIGN_BASELINE);
        span.setSpan(imgspan, 18, 19, Spannable.SPAN_INCLUSIVE_EXCLUSIVE);
        t1.setText(span);
    }
}
```

**2）实现部分可点击的TextView** 

```java
public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        TextView t1 = (TextView) findViewById(R.id.txtOne);

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 20; i++) {
            sb.append("好友" + i + "，");
        }

        String likeUsers = sb.substring(0, sb.lastIndexOf("，")).toString();
        t1.setMovementMethod(LinkMovementMethod.getInstance());
        t1.setText(addClickPart(likeUsers), TextView.BufferType.SPANNABLE);
    }

    //定义一个点击每个部分文字的处理方法
    private SpannableStringBuilder addClickPart(String str) {
        //赞的图标，这里没有素材，就找个笑脸代替下~
        ImageSpan imgspan = new ImageSpan(MainActivity.this, R.drawable.ic_widget_face);
        SpannableString spanStr = new SpannableString("p.");
        spanStr.setSpan(imgspan, 0, 1, Spannable.SPAN_INCLUSIVE_EXCLUSIVE);

        //创建一个SpannableStringBuilder对象，连接多个字符串
        SpannableStringBuilder ssb = new SpannableStringBuilder(spanStr);
        ssb.append(str);
        String[] likeUsers = str.split("，");
        if (likeUsers.length > 0) {
            for (int i = 0; i < likeUsers.length; i++) {
                final String name = likeUsers[i];
                final int start = str.indexOf(name) + spanStr.length();
                ssb.setSpan(new ClickableSpan() {
                    @Override
                    public void onClick(View widget) {
                        Toast.makeText(MainActivity.this, name,
                                Toast.LENGTH_SHORT).show();
                    }

                    @Override
                    public void updateDrawState(TextPaint ds) {
                        super.updateDrawState(ds);
                        //删除下划线，设置字体颜色为蓝色
                        ds.setColor(Color.BLUE);
                        ds.setUnderlineText(false);
                    }
                },start,start + name.length(),0);
            }
        }
    return ssb.append("等" + likeUsers.length + "个人觉得很赞");
    }
}
```

运行效果图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/20289188.jpg)

## 实现跑马灯效果的TextView

实现效果图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/67859995.jpg)

代码实现：

```xml
<TextView
        android:id="@+id/txtOne"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:textSize="18sp"
        android:singleLine="true"
        android:ellipsize="marquee"
        android:marqueeRepeatLimit="marquee_forever"
        android:focusable="true"
        android:focusableInTouchMode="true"
        android:text="你整天说着日了狗日了狗，但是你却没有来，呵呵呵呵呵呵呵呵呵呵~"/>
```

## 设置TextView字间距和行间距

**字间距：**

```
android:textScaleX：控制字体水平方向的缩放，默认值1.0f，值是float
Java中setScaleX(2.0f); 
```

**行间距：** Android系统中TextView默认显示中文时会比较紧凑，为了让每行保持的行间距

> **android:lineSpacingExtra：**设置行间距，如"3dp" 
> **android:lineSpacingMultiplier：**设置行间距的倍数，如"1.2"

Java代码中可以通过: **setLineSpacing**方法来设置

## 自动换行

自动换行通过 **android:singleLine** 设置，默认为 false。

如需要自动换行，可以用：

```
android:singleLine = "false"
```

如果要在一行显示完，不换行，可以用：

```
android:singleLine = "true"
```

除此之外，可以也设置多行显示不完，添加个maxLines的属性即可！

# EditText(输入框)详解

## 设置默认提示文本

默认提示文本的两个属性如下：

```xml
android:hint="默认提示文本"
android:textColorHint="#95A1AA"
```

前者设置提示的文本内容，后者设置提示文本的颜色

## 获得焦点后全选组件内所有文本内容

当我们想在点击输入框获得焦点后，不是将光标移动到文本的开始或者结尾；
而是 获取到输入框中所有的文本内容的话！这个时候我们可以使用**selectAllOnFocus**属性

```
android:selectAllOnFocus="true"
```

## 限制EditText输入类型

有时我们可能需要对输入的数据进行限制，比如输入电话号码的时候，你输入了一串字母，这 显然是不符合我们预期的，而限制输入类型可以通过inputType属性来实现！

比如限制只能为电话号码,密码(**textPassword**)：

```xml
<EditText   
        android:layout_width="fill_parent"   
        android:layout_height="wrap_content"   
        android:inputType="phone" />  
```

**可选参数如下：**

**文本类型，多为大写、小写和数字符号**

```xml
android:inputType="none"  
android:inputType="text"  
android:inputType="textCapCharacters"  
android:inputType="textCapWords"  
android:inputType="textCapSentences"  
android:inputType="textAutoCorrect"  
android:inputType="textAutoComplete"  
android:inputType="textMultiLine"  
android:inputType="textImeMultiLine"  
android:inputType="textNoSuggestions"  
android:inputType="textUri"  
android:inputType="textEmailAddress"  
android:inputType="textEmailSubject"  
android:inputType="textShortMessage"  
android:inputType="textLongMessage"  
android:inputType="textPersonName"  
android:inputType="textPostalAddress"  
android:inputType="textPassword"  
android:inputType="textVisiblePassword"  
android:inputType="textWebEditText"  
android:inputType="textFilter"  
android:inputType="textPhonetic" 
```

**数值类型**

```xml
android:inputType="number"  
android:inputType="numberSigned"  
android:inputType="numberDecimal"  
android:inputType="phone"//拨号键盘  
android:inputType="datetime"  
android:inputType="date"//日期键盘  
android:inputType="time"//时间键盘
```

## 设置最小行，最多行，单行，多行，自动换行

EditText默认是多行显示的，并且能够自动换行，即当一行显示不完的时候，他会自动换到第二行

> 设置最小行的行数：**android:minLines="3"**
> 或者设置EditText最大的行数：**android:maxLines="3"**
> PS:当输入内容超过maxline,文字会自动向上滚动！！

另外很多时候我们可能要限制EditText只允许单行输入，而且不会滚动，比如上面的登陆界面的 例子，我们只需要设置

```
android:singleLine="true"   单行输入不换行
```

## 设置文字间隔，设置英文字母大写类型

我们可以通过下述两个属性来设置字的间距：

```
android:textScaleX="1.5"    //设置字与字的水平间隔
android:textScaleY="1.5"    //设置字与字的垂直间隔
```

另外EditText还为我们提供了设置英文字母大写类型的属性：**android:capitalize** 默认none，提供了三个可选值：

> - **sentences：**仅第一个字母大写
> - **words：**每一个单词首字母大小，用空格区分单词
> - **characters:**每一个英文字母都大写

------

## 控制EditText四周的间隔距离与内部文字与边框间的距离

> 我们使用**margin**相关属性增加组件相对其他控件的距离
> android:marginTop = "5dp" 
> 使用**padding**增加组件内文字和组件边框的距离
> android:paddingTop = "5dp"

------

## 设置EditText获得焦点，同时弹出小键盘

> 关于这个EditText获得焦点，弹出小键盘的问题，前不久的项目中纠结了笔者一段时间 需求是：进入Activity后，让EditText获得焦点，同时弹出小键盘供用户输入！ 试了很多网上的方法都不可以，不知道是不是因为笔者用的5.1的系统的问题！ 下面小结下：

首先是让EditText获得焦点与清除焦点的

> edit.**requestFocus**(); //请求获取焦点
> edit.**clearFocus**(); //清除焦点

获得焦点后，弹出小键盘，笔者大部分时间就花在这个上：

> - 低版本的系统直接requestFocus就会自动弹出小键盘了
> - 稍微高一点的版本则需要我们手动地去弹键盘

第一种：

```java
InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
imm.toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS);
```

第二种：

```
InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);     imm.showSoftInput(view,InputMethodManager.SHOW_FORCED);  
imm.hideSoftInputFromWindow(view.getWindowToken(), 0); //强制隐藏键盘  
```

不知道是什么原因，上面这两种方法并没有弹出小键盘
最后使用了:**windowSoftInputMode**属性解决了弹出小键盘的问题

> **android:windowSoftInputMode** Activity主窗口与软键盘的交互模式，可以用来避免输入法面板遮挡问题，Android1.5后的一个新特性。
> 这个属性能影响两件事情：
> 【一】当有焦点产生时，软键盘是隐藏还是显示
> 【二】是否减少活动主窗口大小以便腾出空间放软键盘
>
> 简单点就是有焦点时的键盘控制以及是否减少Act的窗口大小，用来放小键盘
> 有下述值可供选择，可设置多个值，用"|"分开
> **stateUnspecified**：软键盘的状态并没有指定，系统将选择一个合适的状态或依赖于主题的设置
> **stateUnchanged**：当这个activity出现时，软键盘将一直保持在上一个activity里的状态，无论是隐藏还是显示
> **stateHidden**：用户选择activity时，软键盘总是被隐藏
> **stateAlwaysHidden**：当该Activity主窗口获取焦点时，软键盘也总是被隐藏的
> **stateVisible**：软键盘通常是可见的
> **stateAlwaysVisible**：用户选择activity时，软键盘总是显示的状态
> **adjustUnspecified**：默认设置，通常由系统自行决定是隐藏还是显示
> **adjustResize**：该Activity总是调整屏幕的大小以便留出软键盘的空间
> **adjustPan**：当前窗口的内容将自动移动以便当前焦点从不被键盘覆盖和用户能总是看到输入内容的部分

我们可以在AndroidManifest.xml为需要弹出小键盘的Activity设置这个属性，比如：

然后在EditText对象requestFocus()就可以了~

------

## EditText光标位置的控制

> 有时可能需要我们控制EditText中的光标移动到指定位置或者选中某些文本
> EditText为我们提供了**setSelection**()的方法，方法有两种形式:
> 一个参数的是设置光标位置的，两个参数的是设置起始位置与结束位置的中间括的部分，即部分选中！
> 当然我们也可以调用**setSelectAllOnFocus(true)**;让EditText获得焦点时选中全部文本！
> 另外我们还可以调用**setCursorVisible(false)**;设置光标不显示
> 还可以调用g**etSelectionStart()**和**getSelectionEnd**获得当前光标的前后位置

------

## 带表情的EditText的简单实现

相信大家对于QQ或者微信很熟悉吧，我们发送文本的时候可以连同表情一起发送，有两种简单的实现方式：

> 1.使用SpannableString来实现
> 2.使用Html类来实现

代码也很简单：

```java
public class MainActivity extends Activity {
    private Button btn_add;
    private EditText edit_one;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        btn_add = (Button) findViewById(R.id.btn_add);
        edit_one = (EditText) findViewById(R.id.edit_one);
        btn_add.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                SpannableString spanStr = new SpannableString("imge");
                Drawable drawable = MainActivity.this.getResources().getDrawable(R.drawable.f045);
                drawable.setBounds(0,0,drawable.getIntrinsicWidth(),drawable.getIntrinsicHeight());
                ImageSpan span = new ImageSpan(drawable,ImageSpan.ALIGN_BASELINE);
                spanStr.setSpan(span,0,4,Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
                int cursor = edit_one.getSelectionStart();
                edit_one.getText().insert(cursor, spanStr);
            }
        });
    }
}
```

PS：对了，别忘了放一个图片

------

## 带删除按钮的EditText

我们常常在App的输入界面上看到：
当我们输入内容后，右面会出现这样一个小叉叉的图标
实现起来其实也很简单：
为EditText设置addTextChangedListener，然后重写TextWatcher（）里的抽象方法，这个用于监听输入框变化的；
然后setCompoundDrawablesWithIntrinsicBounds设置小叉叉的图片；
最后，重写onTouchEvent方法，如果点击区域是小叉叉图片的位置，清空文本！

实现代码如下：

```java
public class EditTextWithDel extends EditText {

    private final static String TAG = "EditTextWithDel";
    private Drawable imgInable;
    private Drawable imgAble;
    private Context mContext;

    public EditTextWithDel(Context context) {
        super(context);
        mContext = context;
        init();
    }

    public EditTextWithDel(Context context, AttributeSet attrs) {
        super(context, attrs);
        mContext = context;
        init();
    }

    public EditTextWithDel(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        mContext = context;
        init();
    }

    private void init() {
        imgInable = mContext.getResources().getDrawable(R.drawable.delete_gray);
        addTextChangedListener(new TextWatcher() {
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void afterTextChanged(Editable s) {
                setDrawable();
            }
        });
        setDrawable();
    }

    // 设置删除图片
    private void setDrawable() {
        if (length() < 1)
            setCompoundDrawablesWithIntrinsicBounds(null, null, null, null);
        else
            setCompoundDrawablesWithIntrinsicBounds(null, null, imgInable, null);
    }

    // 处理删除事件
    @Override
    public boolean onTouchEvent(MotionEvent event) {
        if (imgInable != null && event.getAction() == MotionEvent.ACTION_UP) {
            int eventX = (int) event.getRawX();
            int eventY = (int) event.getRawY();
            Log.e(TAG, "eventX = " + eventX + "; eventY = " + eventY);
            Rect rect = new Rect();
            getGlobalVisibleRect(rect);
            rect.left = rect.right - 100;
            if (rect.contains(eventX, eventY))
                setText("");
        }
        return super.onTouchEvent(event);
    }
    @Override
    protected void finalize() throws Throwable {
        super.finalize();
    }
}
```

# Button(按钮)与ImageButton(图像按钮)

*Button普通按钮和ImageButton图像按钮； *
*其实ImageButton和Button的用法基本类似，至于与图片相关的则和后面ImageView相同*
*另外Button是TextView的子类，所以TextView上很多属性也可以应用到Button 上！*

## StateListDrawable简介：

> StateListDrawable是Drawable资源的一种，可以根据不同的状态，设置不同的图片效果，关键节点 **< selector >**，我们只需要将Button的background属性设置为该drawable资源即可轻松实现，按下 按钮时不同的按钮颜色或背景！

我们可以设置的属性：

> - **drawable**:引用的Drawable位图,我们可以把他放到最前面,就表示组件的正常状态~
> - **state_focused**:是否获得焦点
> - **state_window_focused**:是否获得窗口焦点
> - **state_enabled**:控件是否可用
> - **state_checkable**:控件可否被勾选,eg:checkbox
> - **state_checked**:控件是否被勾选
> - **state_selected**:控件是否被选择,针对有滚轮的情况
> - **state_pressed**:控件是否被按下
> - **state_active**:控件是否处于活动状态,eg:slidingTab
> - **state_single**:控件包含多个子控件时,确定是否只显示一个子控件
> - **state_first**:控件包含多个子控件时,确定第一个子控件是否处于显示状态
> - **state_middle**:控件包含多个子控件时,确定中间一个子控件是否处于显示状态
> - **state_last**:控件包含多个子控件时,确定最后一个子控件是否处于显示状态

------

## 实现按钮的按下效果

好的，先准备三个图片背景，一般我们为了避免按钮拉伸变形都会使用.9.png作为按钮的drawable！ 先来看下 **运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/07/89827371.jpg)

**代码实现：**

```xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:state_pressed="true" android:drawable="@drawable/ic_course_bg_fen"/>
    <item android:state_enabled="false" android:drawable="@drawable/ic_course_bg_pressed"/>
    <item android:drawable="@drawable/ic_course_bg_cheng"/>
</selector>
```

布局文件:**activity_main.xml**

```xml
<Button
        android:id="@+id/btnOne"
        android:layout_width="match_parent"
        android:layout_height="64dp"
        android:background="@drawable/btn_bg1"
        android:text="按钮"/>
    
    
    <Button
        android:id="@+id/btnTwo"
        android:layout_width="match_parent"
        android:layout_height="64dp"
        android:text="按钮不可用"/>
```

**MainActivity.java**：

```java
public class MainActivity extends Activity {

    private Button btnOne,btnTwo;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        btnOne = (Button) findViewById(R.id.btnOne);
        btnTwo = (Button) findViewById(R.id.btnTwo);
        btnTwo.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                if(btnTwo.getText().toString().equals("按钮不可用")){
                    btnOne.setEnabled(false);
                    btnTwo.setText("按钮可用");
                }else{
                    btnOne.setEnabled(true);
                    btnTwo.setText("按钮不可用");
                }
            }
        });
    }

}
```

## 使用颜色值绘制圆角按钮

> 很多时候我们不一定会有美工是吧，或者我们不会PS或毁图秀秀，又或者我们懒，不想自己去做图， 这个时候我们可以自己写代码来作为按钮背景，想要什么颜色就什么颜色，下面我们来定制个圆角的 的按钮背景~，这里涉及到另一个drawable资源:ShapeDrawable，这里不详细讲，后面会详细介绍每一个 drawable~这里会用就好，只是EditText修改下Background属性而已，这里只贴drawable资源！

先看下效果图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/48089981.jpg)

**bbuton_danger_rounded.xml：**

```xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">

    <item android:state_pressed="true"><shape>
            <solid android:color="@color/bbutton_danger_pressed" />
            <stroke android:width="1dp" android:color="@color/bbutton_danger_edge" />
            <corners android:radius="@dimen/bbuton_rounded_corner_radius"/>
        </shape></item>
        
    
    <item android:state_enabled="false"><shape>
        <solid android:color="@color/bbutton_danger_disabled" />
            <stroke android:width="1dp" android:color="@color/bbutton_danger_disabled_edge" />
            <corners android:radius="@dimen/bbuton_rounded_corner_radius"/>
        </shape></item>
        

    <item><shape>
            <solid android:color="@color/bbutton_danger" />
            <stroke android:width="1dp" android:color="@color/bbutton_danger_edge" />
            <corners android:radius="@dimen/bbuton_rounded_corner_radius"/>
        </shape></item>
    
        
</selector>
```

**color.xml:**

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="bbutton_danger_pressed">#ffd2322d</color>
    <color name="bbutton_danger_edge">#ffd43f3a</color>
    <color name="bbutton_danger_disabled">#a5d9534f</color>
    <color name="bbutton_danger_disabled_edge">#a5d43f3a</color>
    <color name="bbutton_danger">#ffd9534f</color>
    <color name="text_font_white">#FFFFFF</color>
</resources>
```

------

**dimens.xml:**

```
<dimen name="bbuton_rounded_corner_radius">5dp</dimen>
```

------

## 实现Material Design水波效果的Button

如果你的Android手机是5.0以上的系统，相信对下面这种按钮点击效果并不会陌生：

**实现效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/07/44832111.jpg)

快的那个是按下后的效果，慢的是长按后的效果！

**实现逻辑：**

1.我们继承ImageButton，当然你可以换成Button或者View,这里笔者想把龟放到中间才继承ImageButton

2.首先，创建两个Paint(画笔)对象，一个绘制底部背景颜色，一个绘制波纹扩散的

3.接着计算最大半径，开始半径每隔一段时间递增一次，直到等于最大半径，然后重置状态！

PS:大概的核心，刚学可能对自定义View感到陌生，没事，这里了解下即可，以后我们会讲，当然 你可以自己扣扣，注释还是蛮详细的~

**实现代码：**

自定义ImageButton：**MyButton.java**

```java
package demo.com.jay.buttondemo;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.os.SystemClock;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.ViewConfiguration;
import android.widget.ImageButton;

/**
 * Created by coder-pig on 2015/7/16 0016.
 */
public class MyButton extends ImageButton {


    private static final int INVALIDATE_DURATION = 15;     //每次刷新的时间间隔
    private static int DIFFUSE_GAP = 10;                  //扩散半径增量
    private static int TAP_TIMEOUT;                         //判断点击和长按的时间

    private int viewWidth, viewHeight;                   //控件宽高
    private int pointX, pointY;                          //控件原点坐标（左上角）
    private int maxRadio;                             //扩散的最大半径
    private int shaderRadio;                        //扩散的半径

    private Paint bottomPaint, colorPaint;          //画笔:背景和水波纹
    private boolean isPushButton;                 //记录是否按钮被按下

    private int eventX, eventY;                  //触摸位置的X,Y坐标
    private long downTime = 0;                 //按下的时间


    public MyButton(Context context, AttributeSet attrs) {
        super(context, attrs);
        initPaint();
        TAP_TIMEOUT = ViewConfiguration.getLongPressTimeout();
    }


    /*
    * 初始化画笔
    * */
    private void initPaint() {
        colorPaint = new Paint();
        bottomPaint = new Paint();
        colorPaint.setColor(getResources().getColor(R.color.reveal_color));
        bottomPaint.setColor(getResources().getColor(R.color.bottom_color));
    }


    @Override
    public boolean onTouchEvent(MotionEvent event) {
        switch (event.getAction()) {
            case MotionEvent.ACTION_DOWN:
                if (downTime == 0) downTime = SystemClock.elapsedRealtime();
                eventX = (int) event.getX();
                eventY = (int) event.getY();
                //计算最大半径：
                countMaxRadio();
                isPushButton = true;
                postInvalidateDelayed(INVALIDATE_DURATION);
                break;
            case MotionEvent.ACTION_UP:
            case MotionEvent.ACTION_CANCEL:
                if(SystemClock.elapsedRealtime() - downTime < TAP_TIMEOUT){
                    DIFFUSE_GAP = 30;
                    postInvalidate();
                }else{
                    clearData();
                }
                break;
        }
        return super.onTouchEvent(event);
    }


    @Override
    protected void dispatchDraw(Canvas canvas) {
        super.dispatchDraw(canvas);
        if(!isPushButton) return; //如果按钮没有被按下则返回
        //绘制按下后的整个背景
        canvas.drawRect(pointX, pointY, pointX + viewWidth, pointY + viewHeight, bottomPaint);
        canvas.save();
        //绘制扩散圆形背景
        canvas.clipRect(pointX, pointY, pointX + viewWidth, pointY + viewHeight);
        canvas.drawCircle(eventX, eventY, shaderRadio, colorPaint);
        canvas.restore();
        //直到半径等于最大半径
        if(shaderRadio < maxRadio){
            postInvalidateDelayed(INVALIDATE_DURATION,
                    pointX, pointY, pointX + viewWidth, pointY + viewHeight);
            shaderRadio += DIFFUSE_GAP;
        }else{
            clearData();
        }
    }

    /*
        * 计算最大半径的方法
        * */
    private void countMaxRadio() {
        if (viewWidth > viewHeight) {
            if (eventX < viewWidth / 2) {
                maxRadio = viewWidth - eventX;
            } else {
                maxRadio = viewWidth / 2 + eventX;
            }
        } else {
            if (eventY < viewHeight / 2) {
                maxRadio = viewHeight - eventY;
            } else {
                maxRadio = viewHeight / 2 + eventY;
            }
        }
    }


    /*
    * 重置数据的方法
    * */
    private void clearData(){
        downTime = 0;
        DIFFUSE_GAP = 10;
        isPushButton = false;
        shaderRadio = 0;
        postInvalidate();
    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        super.onSizeChanged(w, h, oldw, oldh);
        this.viewWidth = w;
        this.viewHeight = h;
    }
}
<code>
<p><b>color.xml：</b></p>
<pre>
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="reveal_color">#FFFFFF</color>
    <color name="bottom_color">#3086E4</color>
    <color name="bottom_bg">#40BAF8</color>
</resources>
```

**activity_main.xml：**

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <demo.com.jay.buttondemo.MyButton
        android:id="@+id/myBtn"
        android:layout_width="match_parent"
        android:layout_height="64dp"
        android:src="@mipmap/ic_tur_icon"
        android:background="@color/bottom_bg"
        android:scaleType="center"/>

</RelativeLayout>
```

# ImageView(图像视图)

## src属性和background属性的区别：

> 在API文档中我们发现ImageView有两个可以设置图片的属性，分别是：src和background
>
> **常识：**
>
> ①background通常指的都是**背景**,而src指的是**内容**!!
>
> ②当使用**src**填入图片时,是按照图片大小**直接填充**,并**不会进行拉伸**
>
> 而使用background填入图片,则是会根据ImageView给定的宽度来进行**拉伸**

**写代码验证区别：**

写个简单的布局测试下：

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"  
    xmlns:tools="http://schemas.android.com/tools"  
    android:id="@+id/LinearLayout1"  
    android:layout_width="match_parent"  
    android:layout_height="match_parent"  
    android:orientation="vertical"  
    tools:context="com.jay.example.imageviewdemo.MainActivity" >  
  
    <ImageView  
        android:layout_width="wrap_content"  
        android:layout_height="wrap_content"  
        android:background="@drawable/pen" />  
  
    <ImageView  
        android:layout_width="200dp"  
        android:layout_height="wrap_content"  
        android:background="@drawable/pen" />  
  
    <ImageView  
        android:layout_width="wrap_content"  
        android:layout_height="wrap_content"  
        android:src="@drawable/pen" />  
  
    <ImageView  
        android:layout_width="200dp"  
        android:layout_height="wrap_content"  
        android:src="@drawable/pen" />  
  
</LinearLayout> 
```

**效果图如下：**

![img](https://www.runoob.com/wp-content/uploads/2015/07/33108370.jpg)

**结果分析：**

当我们固定了宽或者高的话src依旧是那么大, 而且他居中了,这就涉及到了ImageView的另一个属性scaleType
假如同时设置了 width和height,blackground依旧填充,但是,src的大小可能发生改变

```xml
<ImageView  
        android:layout_width="100dp"  
        android:layout_height="50dp"  
        android:src="@drawable/pen" />
```

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/07/77805332.jpg)

## 解决blackground拉伸导致图片变形的方法

在前面的效果图中的第二个Imageview中我们可以看到图片已经被拉伸变形了, 正方形变成了长方形,对于和我一样有轻微强迫症的人来说,显然是不可接受的, 有没有办法去设置呢?

- 这个适用于动态加载ImageView的,代码也简单,只要在添加View的时候,把大小写写死就可以了

  ```
  LinearLayout.LayoutParams layoutParam = new LinearLayout.LayoutParams(48, 48);    
          layout.addView(ibtnPen, layoutParam); 
  ```

- 除了动态加载view,更多的时候,我们还是会通过xml布局的方式引入ImageView的 解决方法也不难,就是通过drawable的Bitmap资源文件来完成,然后blackground属性设置为该文件即可! 这个xml文件在drawable文件夹下创建,这个文件夹是要自己创建的哦!！

**pen_bg.xml:**

```xml
<bitmap  
    xmlns:android="http://schemas.android.com/apk/res/android"  
    android:id="@id/pen_bg"  
    android:gravity="top"  
    android:src="@drawable/pen"  
    android:tileMode="disabled" >  
</bitmap>
```

> 上述代码并不难理解,估计大家最迷惑的是titleMode属性吧,这个属性是平铺,就是我们windows设置 背景时候的平铺,多个小图标铺满整个屏幕捏！记得了吧！不记得自己可以试试!disabled就是把他给禁止了!
>
> 就是上面这串简单的代码,至于调用方法如下:
>
> 动态: ibtnPen.setBacklgroundResource(R.drawable.penbg);
>
> 静态: android:background = "@drawable/penbg"

------

## 设置透明度的问题

> 说完前面两个区别,接着再说下setAlpha属性咯!这个很简单,这个属性,**只有src时才是有效果的!!**

------

## 两者结合妙用:

网上的一张图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/92316532.jpg)

一看去是一个简单的GridView,每个item都是一个ImageView,但是细心的你可能发现了, 上面的ICON都不是规则的,而是圆形,圆角矩形等等,于是乎这里用到了src + background了！ 要实现上述的效果
你只需要两个操作: **找一张透明的png图片 + 设置一个黑色的背景** (当然你也可以设置png的透明度来实现,不过结果可能和预想的有出入哦!) 我们写个简单例子：

![img](https://www.runoob.com/wp-content/uploads/2015/07/75246602.jpg)

如图，呆萌呆萌的小猪就这样显示到ImageView上了,哈哈,blackground设置了蓝色背景!

**实现代码：**

```xml
<ImageView  
    android:layout_width="150dp"  
    android:layout_height="wrap_content"  
    android:src="@drawable/pig"  
    android:background="#6699FF" /> 
```

PS: 也可以用selctor实现点击效果,设置不同的情况设置不同的图片,以实现点击或者触摸效果!

------

## Java代码中设置blackground和src属性:

> 前景(对应src属性):**setImageDrawable**( );
> 背景(对应background属性):**setBackgroundDrawable**( );

------

## adjustViewBounds设置缩放是否保存原图长宽比

> ImageView为我们提供了**adjustViewBounds**属性，用于设置缩放时是否保持原图长宽比！ 单独设置不起作用，需要配合**maxWidth**和**maxHeight**属性一起使用！而后面这两个属性 也是需要adjustViewBounds为true才会生效的~
>
> - android:maxHeight:设置ImageView的最大高度
> - android:maxWidth:设置ImageView的最大宽度

代码示例：

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    tools:context=".MainActivity">

    <!-- 正常的图片 -->
    <ImageView
        android:id="@+id/imageView1"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_margin="5px"
        android:src="@mipmap/meinv" />
    <!-- 限制了最大宽度与高度,并且设置了调整边界来保持所显示图像的长宽比-->
    <ImageView
        android:id="@+id/imageView2"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_margin="5px"
        android:adjustViewBounds="true"
        android:maxHeight="200px"
        android:maxWidth="200px"
        android:src="@mipmap/meinv" />

</LinearLayout>
```

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/07/74206920.jpg)

**结果分析：** 大的那个图片是没有任何处理的图片,尺寸是:541*374;而下面的那个的话我们通过maxWidth和maxHeight 限制ImageView最大宽度与高度为200px，就是最多只能显示200*200的图片,我们又设置了一个 **adjustViewBounds = "true"**调整我们的边界来保持图片的长宽比,此时的ImageView宽高为是128*200~

------

## scaleType设置缩放类型

> android:scaleType用于设置显示的图片如何缩放或者移动以适应ImageView的大小 Java代码中可以通过imageView.setScaleType(ImageView.ScaleType.CENTER);来设置~ 可选值如下：
>
> - **fitXY**:对图像的横向与纵向进行独立缩放,使得该图片完全适应ImageView,但是图片的横纵比可能会发生改变
> - **fitStart**:保持纵横比缩放图片,知道较长的边与Image的编程相等,缩放完成后将图片放在ImageView的左上角
> - **fitCenter**:同上,缩放后放于中间;
> - **fitEnd**:同上,缩放后放于右下角;
> - **center**:保持原图的大小，显示在ImageView的中心。当原图的size大于ImageView的size，超过部分裁剪处理。
> - **centerCrop**:保持横纵比缩放图片,知道完全覆盖ImageView,可能会出现图片的显示不完全
> - **centerInside**:保持横纵比缩放图片,直到ImageView能够完全地显示图片
> - **matrix**:默认值，不改变原图的大小，从ImageView的左上角开始绘制原图， 原图超过ImageView的部分作裁剪处理

接下来我们一组组的来对比：

------

### 1)1.fitEnd,fitStart,fitCenter

这里以fitEnd为例，其他两个类似：

**示例代码：**

```xml
<!-- 保持图片的横纵比缩放,知道该图片能够显示在ImageView组件上,并将缩放好的图片显示在imageView的右下角 -->
    <ImageView
        android:id="@+id/imageView3"
        android:layout_width="300px"
        android:layout_height="300px"
        android:layout_margin="5px"
        android:scaleType="fitEnd"
        android:src="@mipmap/meinv" />
```

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/07/44457922.jpg)

------

### 2)centerCrop与centerInside

- centerCrop:按横纵比缩放,直接完全覆盖整个ImageView
- centerInside:按横纵比缩放,使得ImageView能够完全显示这个图片

示例代码：

```xml
<ImageView
        android:layout_width="300px"
        android:layout_height="300px"
        android:layout_margin="5px"
        android:scaleType="centerCrop"
        android:src="@mipmap/meinv" />

    <ImageView
        android:layout_width="300px"
        android:layout_height="300px"
        android:layout_margin="5px"
        android:scaleType="centerInside"
        android:src="@mipmap/meinv" />
```

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/07/63316044.jpg)

------

### 3)fitXY

不按比例缩放图片，目标是把图片塞满整个View

**示例代码：**

```xml
<ImageView
        android:layout_width="300px"
        android:layout_height="300px"
        android:layout_margin="5px"
        android:scaleType="fixXY"
        android:src="@mipmap/meinv" />
```

运行效果图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/18506365.jpg)

好吧，明显扁了=-=~

------

### 4)matrix

从ImageView的左上角开始绘制原图，原图超过ImageView的部分作裁剪处理

示例代码：

```xml
<ImageView
        android:layout_width="300px"
        android:layout_height="300px"
        android:layout_margin="5px"
        android:scaleType="matrix"
        android:src="@mipmap/meinv" />
```

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/07/87772241.jpg)

------

### 5)center

保持原图的大小，显示在ImageView的中心。当原图的size大于ImageView的size，超过部分裁剪处理。

**示例代码：**

```xml
<ImageView
        android:layout_width="300px"
        android:layout_height="300px"
        android:layout_margin="5px"
        android:scaleType="center"
        android:src="@mipmap/meinv" />
```

运行效果图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/79385476.jpg)

## 最简单的绘制圆形的ImageView

相信大家对圆形或者圆角的ImageView不陌生吧，现在很多的APP都很喜欢圆形的头像是吧~

[RoundedImageView](https://github.com/vinc3m1/RoundedImageView)

[CircleImageView](https://github.com/hdodenhof/CircleImageView)



![img](https://www.runoob.com/wp-content/uploads/2015/07/62291148.jpg)

实现代码：

自定义ImageView：**RoundImageView.java

```java
package com.jay.demo.imageviewdemo;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PaintFlagsDrawFilter;
import android.graphics.Path;
import android.graphics.Rect;
import android.graphics.Region;
import android.util.AttributeSet;
import android.widget.ImageView;

/**
 * Created by coder-pig on 2015/7/18 0018.
 */
public class RoundImageView extends ImageView {

    private Bitmap mBitmap;
    private Rect mRect = new Rect();
    private PaintFlagsDrawFilter pdf = new PaintFlagsDrawFilter(0, Paint.ANTI_ALIAS_FLAG);
    private Paint mPaint = new Paint();
    private Path mPath=new Path();
    public RoundImageView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
    }


    //传入一个Bitmap对象
    public void setBitmap(Bitmap bitmap) {
        this.mBitmap = bitmap;
    }


    private void init() {
        mPaint.setStyle(Paint.Style.STROKE);
        mPaint.setFlags(Paint.ANTI_ALIAS_FLAG);
        mPaint.setAntiAlias(true);// 抗锯尺
    }


    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        if(mBitmap == null)
        {
            return;
        }
        mRect.set(0,0,getWidth(),getHeight());
        canvas.save();
        canvas.setDrawFilter(pdf);
        mPath.addCircle(getWidth() / 2, getWidth() / 2, getHeight() / 2, Path.Direction.CCW);
        canvas.clipPath(mPath, Region.Op.REPLACE);
        canvas.drawBitmap(mBitmap, null, mRect, mPaint);
        canvas.restore();
    }
}
```

布局代码：**activity_main.xml:**

```xml
<com.jay.demo.imageviewdemo.RoundImageView
        android:id="@+id/img_round"
        android:layout_width="200dp"
        android:layout_height="200dp"
        android:layout_margin="5px"/>
```

**MainActivity.java:**

```
package com.jay.demo.imageviewdemo;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private RoundImageView img_round;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        img_round = (RoundImageView) findViewById(R.id.img_round);
        Bitmap bitmap = BitmapFactory.decodeResource(getResources(),R.mipmap.meinv);
        img_round.setBitmap(bitmap);
    }
}
```

# RadioButton(单选按钮)&Checkbox(复选框)

## RadioButton(单选按钮)

> 如题单选按钮，就是只能够选中一个，所以我们需要把RadioButton放到RadioGroup按钮组中，从而实现 单选功能！先熟悉下如何使用RadioButton，一个简单的性别选择的例子： 另外我们可以为外层RadioGroup设置orientation属性然后设置RadioButton的排列方式，是竖直还是水平~

**效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/07/33533989.jpg)

PS:笔者的手机是Android 5.0.1的，这里的RadioButton相比起旧版本的RadioButton，稍微好看一点~

**布局代码如下：**

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/LinearLayout1"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    tools:context=".MainActivity" >

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="请选择性别"
        android:textSize="23dp"
        />

    <RadioGroup
        android:id="@+id/radioGroup"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:orientation="horizontal">

        <RadioButton
            android:id="@+id/btnMan"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="男"
            android:checked="true"/>

        <RadioButton
            android:id="@+id/btnWoman"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="女"/>
    </RadioGroup>

    <Button
        android:id="@+id/btnpost"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="提交"/>

</LinearLayout>
```

**获得选中的值：**

这里有两种方法，

**第一种**是为RadioButton设置一个事件监听器setOnCheckChangeListener

**例子代码如下：**

```java
RadioGroup radgroup = (RadioGroup) findViewById(R.id.radioGroup);
        //第一种获得单选按钮值的方法  
        //为radioGroup设置一个监听器:setOnCheckedChanged()  
        radgroup.setOnCheckedChangeListener(new OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                RadioButton radbtn = (RadioButton) findViewById(checkedId);
                Toast.makeText(getApplicationContext(), "按钮组值发生改变,你选了" + radbtn.getText(), Toast.LENGTH_LONG).show();
            }
        });
```

**运行效果图：** ![img](https://www.runoob.com/wp-content/uploads/2015/07/27462378.jpg)![img](https://www.runoob.com/wp-content/uploads/2015/07/55316099.jpg)

PS：另外有一点要切记，要为每个RadioButton添加一个id，不然单选功能会生效！！！

**第二种**方法是通过单击其他按钮获取选中单选按钮的值，当然我们也可以直接获取，这个看需求~

**例子代码如下：**

```java
Button btnchange = (Button) findViewById(R.id.btnpost);
        RadioGroup radgroup = (RadioGroup) findViewById(R.id.radioGroup);
        //为radioGroup设置一个监听器:setOnCheckedChanged()  
        btnchange.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                for (int i = 0; i < radgroup.getChildCount(); i++) {
                    RadioButton rd = (RadioButton) radgroup.getChildAt(i);
                    if (rd.isChecked()) {
                        Toast.makeText(getApplicationContext(), "点击提交按钮,获取你选择的是:" + rd.getText(), Toast.LENGTH_LONG).show();
                        break;
                    }
                }
            }
        });
```

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/07/85345690.jpg)

**代码解析：** 这里我们为提交按钮设置了一个setOnClickListener事件监听器,每次点击的话遍历一次RadioGroup判断哪个按钮被选中我们可以通过下述方法获得RadioButton的相关信息！

- **getChildCount**( )获得按钮组中的单选按钮的数目；
- **getChinldAt**(i):根据索引值获取我们的单选按钮
- **isChecked**( ):判断按钮是否选中

## CheckBox(复选框)

> 如题复选框，即可以同时选中多个选项，至于获得选中的值，同样有两种方式： 1.为每个CheckBox添加事件：setOnCheckedChangeListener 2.弄一个按钮，在点击后，对每个checkbox进行判断:isChecked()；

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/07/8897873.jpg)

**实现代码：**

```java
public class MainActivity extends AppCompatActivity implements View.OnClickListener,CompoundButton.OnCheckedChangeListener{

    private CheckBox cb_one;
    private CheckBox cb_two;
    private CheckBox cb_three;
    private Button btn_send;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        cb_one = (CheckBox) findViewById(R.id.cb_one);
        cb_two = (CheckBox) findViewById(R.id.cb_two);
        cb_three = (CheckBox) findViewById(R.id.cb_three);
        btn_send = (Button) findViewById(R.id.btn_send);

        cb_one.setOnCheckedChangeListener(this);
        cb_two.setOnCheckedChangeListener(this);
        cb_three.setOnCheckedChangeListener(this);
        btn_send.setOnClickListener(this);

    }

    @Override
    public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
       if(compoundButton.isChecked()) Toast.makeText(this,compoundButton.getText().toString(),Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onClick(View view) {
        String choose = "";
        if(cb_one.isChecked())choose += cb_one.getText().toString() + "";
        if(cb_two.isChecked())choose += cb_two.getText().toString() + "";
        if(cb_three.isChecked())choose += cb_three.getText().toString() + "";
        Toast.makeText(this,choose,Toast.LENGTH_SHORT).show();
    }
}
```

## 自定义点击效果

> 虽然5.0后的RadioButton和Checkbox都比旧版本稍微好看了点，但是对于我们来说 可能还是不喜欢或者需求，需要自己点击效果！实现起来很简单，先编写一个自定义 的selctor资源，设置选中与没选中时的切换图片~！

实现效果图如下：

![img](https://www.runoob.com/wp-content/uploads/2015/07/88423721.jpg)

PS:这里素材的原因，有点小...

```xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item
        android:state_enabled="true"
        android:state_checked="true"
        android:drawable="@mipmap/ic_checkbox_checked"/>
    <item
        android:state_enabled="true"
        android:state_checked="false"
        android:drawable="@mipmap/ic_checkbox_normal" />
</selector>
```

写好后，我们有两种方法设置，也可以说一种吧！你看看就知道了~

①android:button属性设置为上述的selctor

```
android:button="@drawable/rad_btn_selctor"
```

②在style中定义一个属性，然后通过android style属性设置，先往style添加下述代码：

```
    <style name="MyCheckBox" parent="@android:style/Widget.CompoundButton.CheckBox">
        <item name="android:button">@drawable/rad_btn_selctor</item>
    </style>
```

然后布局那里:

```
style="@style/MyCheckBox"
```

------

## 改变文字与选择框的相对位置

> 这个实现起来也很简单，还记得我们之前学TextView的时候用到的drawableXxx吗？ 要控制选择框的位置，两部即可！设置：
>
> **Step 1.** android:button="@null"
> **Step 2.** android:drawableTop="@android:drawable/btn_radio"
> 当然我们可以把drawableXxx替换成自己喜欢的效果！

------

## 修改文字与选择框的距离

> 有时，我们可能需要调节文字与选择框之间的距离，让他们看起来稍微没那么挤，我们可以：
> 1.在XML代码中控制： 使用android:paddingXxx = "xxx" 来控制距离
> 2.在Java代码中，稍微好一点，动态计算paddingLeft!

**示例代码如下：**

```
rb.setButtonDrawable(R.drawable.rad_btn_selctor);
int rb_paddingLeft = getResources().getDrawable(R.mipmap.ic_checkbox_checked).getIntrinsicWidth()+5; 
rb.setPadding(rb_paddingLeft, 0, 0, 0);
```

# 开关按钮ToggleButton和开关Switch

## 1.核心属性讲解：

1）ToggleButton(开关按钮)

> - **android:disabledAlpha**：设置按钮在禁用时的透明度
> - **android:textOff：**按钮没有被选中时显示的文字
> - **android:textOn：**按钮被选中时显示的文字 另外，除了这个我们还可以自己写个selector，然后设置下Background属性即可~

2) Switch(开关)

> - **android:showText：**设置on/off的时候是否显示文字,boolean
> - **android:splitTrack：**是否设置一个间隙，让滑块与底部图片分隔,boolean
> - **android:switchMinWidth：**设置开关的最小宽度
> - **android:switchPadding：**设置滑块内文字的间隔
> - **android:switchTextAppearance：**设置开关的文字外观，暂时没发现有什么用...
> - **android:textOff：**按钮没有被选中时显示的文字
> - **android:textOn：**按钮被选中时显示的文字
> - **android:textStyle：**文字风格，粗体，斜体写划线那些
> - **android:track：**底部的图片
> - **android:thumb：**滑块的图片
> - **android:typeface：**设置字体，默认支持这三种:sans, serif, monospace;除此以外还可以使用 其他字体文件(***.ttf**)，首先要将字体文件保存在assets/fonts/目录下，不过需要在Java代码中设置： **Typeface typeFace =Typeface.createFromAsset(getAssets(),"fonts/HandmadeTypewriter.ttf"); textView.setTypeface(typeFace);**

------

## 2.使用示例

我们为Switch设置下滑块和底部的图片，实现 一个类似于IOS 7的滑块的效果，但是有个缺点就是不能在XML中对滑块和底部的大小进行设置， 就是素材多大，Switch就会多大，我们可以在Java中获得Drawable对象，然后对大小进行修改， 简单的例子：

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/10/44095159.jpg)

**实现代码：** 先是两个drawable的文件： **thumb_selctor.xml:**

```xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:state_pressed="true" android:drawable="@drawable/switch_btn_pressed"/>
    <item android:state_pressed="false" android:drawable="@drawable/switch_btn_normal"/>
</selector>
```

**track_selctor.xml:**

```xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:state_checked="true" android:drawable="@drawable/switch_btn_bg_green"/>
    <item android:state_checked="false" android:drawable="@drawable/switch_btn_bg_white"/>
</selector>
```

**布局文件:activity_main.xml:**

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    tools:context=".MainActivity">

    <ToggleButton
        android:id="@+id/tbtn_open"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:checked="true"
        android:textOff="关闭声音"
        android:textOn="打开声音" />

    <Switch
        android:id="@+id/swh_status"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:textOff=""
        android:textOn=""
        android:thumb="@drawable/thumb_selctor"
        android:track="@drawable/track_selctor" />

</LinearLayout>
```

**MainActivity.java：**

```java
public class MainActivity extends AppCompatActivity implements CompoundButton.OnCheckedChangeListener{
    private ToggleButton tbtn_open;
    private Switch swh_status;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tbtn_open = (ToggleButton) findViewById(R.id.tbtn_open);
        swh_status = (Switch) findViewById(R.id.swh_status);
        tbtn_open.setOnCheckedChangeListener(this);
        swh_status.setOnCheckedChangeListener(this);
    }

    @Override
    public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
        switch (compoundButton.getId()){
            case R.id.tbtn_open:
                if(compoundButton.isChecked()) Toast.makeText(this,"打开声音",Toast.LENGTH_SHORT).show();
                else Toast.makeText(this,"打开声音",Toast.LENGTH_SHORT).show();
                break;
            case R.id.swh_status:
                if(compoundButton.isChecked()) Toast.makeText(this,"开关:ON",Toast.LENGTH_SHORT).show();
                else Toast.makeText(this,"开关:OFF",Toast.LENGTH_SHORT).show();
                break;
        }
    }
}
```

#  ProgressBar(进度条)

## 1.常用属性讲解与基础实例

从官方文档，我们看到了这样一个类关系图：

![img](https://www.runoob.com/wp-content/uploads/2015/08/46760225.jpg)

ProgressBar继承与View类，直接子类有AbsSeekBar和ContentLoadingProgressBar， 其中AbsSeekBar的子类有SeekBar和RatingBar，可见这二者也是基于ProgressBar实现的

**常用属性详解：**

> - android:**max**：进度条的最大值
> - android:**progress**：进度条已完成进度值
> - android:**progressDrawable**：设置轨道对应的Drawable对象
> - android:**indeterminate**：如果设置成true，则进度条不精确显示进度
> - android:**indeterminateDrawable**：设置不显示进度的进度条的Drawable对象
> - android:**indeterminateDuration**：设置不精确显示进度的持续时间
> - android:**secondaryProgress**：二级进度条，类似于视频播放的一条是当前播放进度，一条是缓冲进度，前者通过progress属性进行设置！

对应的再Java中我们可调用下述方法：

> - **getMax**()：返回这个进度条的范围的上限
> - **getProgress**()：返回进度
> - **getSecondaryProgress**()：返回次要进度
> - **incrementProgressBy**(int diff)：指定增加的进度
> - **isIndeterminate**()：指示进度条是否在不确定模式下
> - **setIndeterminate**(boolean indeterminate)：设置不确定模式下

接下来来看看系统提供的默认的进度条的例子吧！

**系统默认进度条使用实例：**

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/08/34906854.jpg)

**实现布局代码：**

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    tools:context=".MainActivity">

    <!-- 系统提供的圆形进度条,依次是大中小 -->

    <ProgressBar
        style="@android:style/Widget.ProgressBar.Small"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content" />

    <ProgressBar
        android:layout_width="wrap_content"
        android:layout_height="wrap_content" />

    <ProgressBar
        style="@android:style/Widget.ProgressBar.Large"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content" />

    <!--系统提供的水平进度条-->
    <ProgressBar
        style="@android:style/Widget.ProgressBar.Horizontal"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:max="100"
        android:progress="18" />

    <ProgressBar
        style="@android:style/Widget.ProgressBar.Horizontal"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="10dp"
        android:indeterminate="true" />

</LinearLayout>
```

系统提供的肯定是满足不了我们的需求的！ 下面我们就来讲解下实际开发中我们对进度条的处理！

------

## 2.使用动画来替代圆形进度条

第一个方案是，使用一套连续图片，形成一个帧动画，当需要进度图的时候，让动画可见，不需要 的时候让动画不可见即可！而这个动画，一般是使用AnimationDrawable来实现的！好的，我们来 定义一个AnimationDrawable文件：

PS:用到的图片素材：[进度条图片素材打包.zip](https://www.runoob.com/wp-content/uploads/2015/08/进度条动画素材打包.zip)

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/08/716773.jpg) 

**实现步骤**：
在res目录下新建一个:anim文件件，然后创建amin_pgbar.xml的资源文件：
接着写个布局文件，里面仅仅有一个ImageView即可，用于显示进度条，把src设置为上述drawable资源即可！ 

```xml
<?xml version="1.0" encoding="utf-8"?>  
<animation-list xmlns:android="http://schemas.android.com/apk/res/android"  
    android:oneshot="false" >  
  
    <item  
        android:drawable="@drawable/loading_01"  
        android:duration="200"/>  
    <item  
        android:drawable="@drawable/loading_02"  
        android:duration="200"/>  
    <item  
        android:drawable="@drawable/loading_03"  
        android:duration="200"/>  
    <item  
        android:drawable="@drawable/loading_04"  
        android:duration="200"/>  
    <item  
        android:drawable="@drawable/loading_05"  
        android:duration="200"/>  
    <item  
        android:drawable="@drawable/loading_06"  
        android:duration="200"/>  
    <item  
        android:drawable="@drawable/loading_07"  
        android:duration="200"/>  
    <item  
        android:drawable="@drawable/loading_08"  
        android:duration="200"/>  
    <item  
        android:drawable="@drawable/loading_09"  
        android:duration="200"/>  
    <item  
        android:drawable="@drawable/loading_10"  
        android:duration="200"/>  
    <item  
        android:drawable="@drawable/loading_11"  
        android:duration="200"/>  
    <item  
        android:drawable="@drawable/loading_12"  
        android:duration="200"/>  
  
</animation-list> 
```

最后到MainActivity.java

```java
public class MainActivity extends AppCompatActivity {

    private ImageView img_pgbar;
    private AnimationDrawable ad;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        img_pgbar = (ImageView) findViewById(R.id.img_pgbar);
        ad = (AnimationDrawable) img_pgbar.getDrawable();
        img_pgbar.postDelayed(new Runnable() {
            @Override
            public void run() {
                ad.start();
            }
        }, 100);
    }

}
```

在需要显示进度条的时候，让ImageView可见； 在不需要的时候让他隐藏即可！
另外其实Progressbar本身有一个indeterminateDrawable，只需把 这个参数设置成上述的动画资源即可，但是进度条条的图案大小是不能直接修改的，需要Java代码中修改，如果你设置了宽高，而且这个宽高过大的时候，你会看到有多个进度条...

------

## 3.自定义圆形进度条

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/08/17272953.jpg)

**实现代码：**

**自定义View类：**

```java
/**
 * Created by Jay on 2015/8/5 0005.
 */
public class CirclePgBar extends View {


    private Paint mBackPaint;
    private Paint mFrontPaint;
    private Paint mTextPaint;
    private float mStrokeWidth = 50;
    private float mHalfStrokeWidth = mStrokeWidth / 2;
    private float mRadius = 200;
    private RectF mRect;
    private int mProgress = 0;
    //目标值，想改多少就改多少
    private int mTargetProgress = 90;
    private int mMax = 100;
    private int mWidth;
    private int mHeight;


    public CirclePgBar(Context context) {
        super(context);
        init();
    }

    public CirclePgBar(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public CirclePgBar(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }


    //完成相关参数初始化
    private void init() {
        mBackPaint = new Paint();
        mBackPaint.setColor(Color.WHITE);
        mBackPaint.setAntiAlias(true);
        mBackPaint.setStyle(Paint.Style.STROKE);
        mBackPaint.setStrokeWidth(mStrokeWidth);

        mFrontPaint = new Paint();
        mFrontPaint.setColor(Color.GREEN);
        mFrontPaint.setAntiAlias(true);
        mFrontPaint.setStyle(Paint.Style.STROKE);
        mFrontPaint.setStrokeWidth(mStrokeWidth);


        mTextPaint = new Paint();
        mTextPaint.setColor(Color.GREEN);
        mTextPaint.setAntiAlias(true);
        mTextPaint.setTextSize(80);
        mTextPaint.setTextAlign(Paint.Align.CENTER);
    }


    //重写测量大小的onMeasure方法和绘制View的核心方法onDraw()
    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
        mWidth = getRealSize(widthMeasureSpec);
        mHeight = getRealSize(heightMeasureSpec);
        setMeasuredDimension(mWidth, mHeight);

    }


    @Override
    protected void onDraw(Canvas canvas) {
        initRect();
        float angle = mProgress / (float) mMax * 360;
        canvas.drawCircle(mWidth / 2, mHeight / 2, mRadius, mBackPaint);
        canvas.drawArc(mRect, -90, angle, false, mFrontPaint);
        canvas.drawText(mProgress + "%", mWidth / 2 + mHalfStrokeWidth, mHeight / 2 + mHalfStrokeWidth, mTextPaint);
        if (mProgress < mTargetProgress) {
            mProgress += 1;
            invalidate();
        }

    }

    public int getRealSize(int measureSpec) {
        int result = 1;
        int mode = MeasureSpec.getMode(measureSpec);
        int size = MeasureSpec.getSize(measureSpec);

        if (mode == MeasureSpec.AT_MOST || mode == MeasureSpec.UNSPECIFIED) {
            //自己计算
            result = (int) (mRadius * 2 + mStrokeWidth);
        } else {
            result = size;
        }

        return result;
    }

    private void initRect() {
        if (mRect == null) {
            mRect = new RectF();
            int viewSize = (int) (mRadius * 2);
            int left = (mWidth - viewSize) / 2;
            int top = (mHeight - viewSize) / 2;
            int right = left + viewSize;
            int bottom = top + viewSize;
            mRect.set(left, top, right, bottom);
        }
    }


}
```

然后在布局文件中加上：

```xml
 <com.jay.progressbardemo.CirclePgBar
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>
```

# SeekBar(拖动条)



> 本节我们继续来学习Android的基本UI控件中的拖动条——SeekBar，相信大家对他并不陌生，最常见的 地方就是音乐播放器或者视频播放器了，音量控制或者播放进度控制，都用到了这个SeekBar，我们 先来看看SeekBar的类结构，来到官方文档：[SeekBar](http://androiddoc.qiniudn.com/reference/android/widget/SeekBar.html)
>
> ![img](https://www.runoob.com/wp-content/uploads/2015/08/45807422.jpg)
>
> 这是ProgressBar的子类，也就是ProgressBar的属性都可以用！ 而且他还有一个自己的属性就是：**android:thumb**，就是允许我们自定义滑块~

------

## 1.SeekBar基本用法

好吧，基本用法其实很简单，常用的属性无非就下面这几个常用的属性，Java代码里只要setXxx即可：

> **android:max**="100" //滑动条的最大值
>
> **android:progress**="60" //滑动条的当前值
>
> **android:secondaryProgress**="70" //二级滑动条的进度
>
> **android:thumb** = "@mipmap/sb_icon" //滑块的drawable

接着要说下SeekBar的事件了，**SeekBar.OnSeekBarChangeListener** 我们只需重写三个对应的方法：

> **onProgressChanged**：进度发生改变时会触发
>
> **onStartTrackingTouch**：按住SeekBar时会触发
>
> **onStopTrackingTouch**：放开SeekBar时触发

**简单的代码示例:**

**效果图:**

![img](https://www.runoob.com/wp-content/uploads/2015/08/22291787.jpg)

**实现代码：**

```java
public class MainActivity extends AppCompatActivity {

    private SeekBar sb_normal;
    private TextView txt_cur;
    private Context mContext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mContext = MainActivity.this;
        bindViews();
    }

    private void bindViews() {
        sb_normal = (SeekBar) findViewById(R.id.sb_normal);
        txt_cur = (TextView) findViewById(R.id.txt_cur);
        sb_normal.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                txt_cur.setText("当前进度值:" + progress + "  / 100 ");
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
                Toast.makeText(mContext, "触碰SeekBar", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                Toast.makeText(mContext, "放开SeekBar", Toast.LENGTH_SHORT).show();
            }
        });
    }
}
```

------

## 2.简单SeekBar定制

**运行效果图：**

![img](https://www.runoob.com/wp-content/uploads/2015/08/34246693.jpg)

**代码实现：** **1.滑块状态Drawable：sb_thumb.xml**

```xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:state_pressed="true" android:drawable="@mipmap/seekbar_thumb_pressed"/>
    <item android:state_pressed="false" android:drawable="@mipmap/seekbar_thumb_normal"/>
</selector>
```

**贴下素材：**

![seekbar_thumb_normal.png](https://www.runoob.com/wp-content/uploads/2015/08/71397914.jpg)![seekbar_thumb_pressed.png](https://www.runoob.com/wp-content/uploads/2015/08/25576180.jpg)

**2.条形栏Bar的Drawable：sb_bar.xml**

这里用到一个layer-list的drawable资源！其实就是层叠图片，依次是:背景，二级进度条，当前进度：

```xml
<?xml version="1.0" encoding="utf-8"?>
<layer-list
    xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:id="@android:id/background">
        <shape>
            <solid android:color="#FFFFD042" />
        </shape>
    </item>
    <item android:id="@android:id/secondaryProgress">
        <clip>
            <shape>
                <solid android:color="#FFFFFFFF" />
            </shape>
        </clip>
    </item>
    <item android:id="@android:id/progress">
        <clip>
            <shape>
                <solid android:color="#FF96E85D" />
            </shape>
        </clip>
    </item>
</layer-list>
```

**3.然后布局引入SeekBar后，设置下progressDrawable与thumb即可！**

```xml
<SeekBar
        android:id="@+id/sb_normal"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:maxHeight="5.0dp"
        android:minHeight="5.0dp"
        android:progressDrawable="@drawable/sb_bar"
        android:thumb="@drawable/sb_thumb"/>
```