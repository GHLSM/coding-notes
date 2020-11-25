# **1. Android中的UI（User Interface）组件**

## 1.1. UI Overview

------

在Android APP中，所有的用户界面元素都是由View和ViewGroup的对象构成的。View是绘制在屏幕上的用户能与之交互的一个对象。而ViewGroup则是一个用于存放其他View（和ViewGroup）对象的布局容器！ Android为我们提供了一个View和ViewGroup子类的集合，集合中提供了一些常用的输入控件(比如按钮和文本域)和各种各样的布局模式（比如线性或相对布局）

你的APP的用户界面上的每一个组件都是使用View和ViewGroup对象的层次结构来构成的
每个ViewGroup都是用于组织子View的容器，而它的子View可能是输入控件 或者在UI上绘制了某块区域的小部件
有了层次树，你就可以根据自己的需要，设计简单或者复 杂的布局了(布局越简单性能越好)

![img](https://www.runoob.com/wp-content/uploads/2015/07/68789093.jpg)

定义你的布局，你可以在代码中实例化View对象并且开始构建你的树，但最容易和最高效的方式来定义你的布局则是使用一个XML文件，用XML来构成布局更加符合人的阅读习惯，而XML类似与HTML 使用XML元素的名称代表一个View。所以< TextView >元素会在你的界面中创建一个TextView控件，而一个< LinearLayout >则会创建一个LinearLayout的容器！ 举个例子，一个简单简单的垂直布局上面有一个文本视图和一个按钮，就像下面这样：

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
              android:layout_width="fill_parent" 
              android:layout_height="fill_parent"
              android:orientation="vertical" >
    <TextView android:id="@+id/text"
              android:layout_width="wrap_content"
              android:layout_height="wrap_content"
              android:text="I am a TextView" />
    <Button android:id="@+id/button"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="I am a Button" />
</LinearLayout>
```

当你的App加载上述的布局资源的时候，Android会将布局中的每个节点进行实例化成一个个对象，然后你可以为这些定义一些额外的行为，查询对象的状态，或者修改布局。

## 1.2. User Interface Layout

### **1.2.1. LinearLayout布局**

------

![img](https://www.runoob.com/wp-content/uploads/2015/07/15116314.jpg)

#### 1.2.1.1 weight(权重)属性详解：

![img](https://www.runoob.com/wp-content/uploads/2015/07/89088844.jpg)![img](https://www.runoob.com/wp-content/uploads/2015/07/54011262.jpg)

实现代码：

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"    
    xmlns:tools="http://schemas.android.com/tools"    
    android:id="@+id/LinearLayout1"    
    android:layout_width="match_parent"    
    android:layout_height="match_parent"    
    android:orientation="horizontal">   
        
    <LinearLayout    
        android:layout_width="0dp"    
        android:layout_height="fill_parent"    
        android:background="#ADFF2F"     
        android:layout_weight="1"/>    
       
        
    <LinearLayout    
        android:layout_width="0dp"    
        android:layout_height="fill_parent"    
        android:background="#DA70D6"     
        android:layout_weight="2"/>    
        
</LinearLayout>  
```

要实现第一个的1:1的效果,只需要分别把两个LinearLayout的weight改成1和1就可以了 
用法归纳:  按比例划分水平方向:将涉及到的View的android:width属性设置为0dp
					然后设置为android weight属性设置比例即可
					类推,竖直方向,只需设android:height为0dp,然后设weight属性即可

当然,如果我们不适用上述那种设置为0dp的方式,直接用wrap_content和match_parent, 则要接着解析weight属性了,分为两种情况,wrap_content与match_parent,另外还要看 LinearLayout的orientation方向,这个决定哪个方向等比例划分

##### **1)wrap_content比较简单,直接就按比例的了**

![img](https://www.runoob.com/wp-content/uploads/2015/07/2036364.jpg)

实现代码：

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"    
    xmlns:tools="http://schemas.android.com/tools"    
    android:id="@+id/LinearLayout1"    
    android:layout_width="match_parent"    
    android:layout_height="match_parent"  
    android:orientation="horizontal" >    
    
    <TextView    
        android:layout_weight="1"    
        android:layout_width="wrap_content"    
        android:layout_height="fill_parent"    
        android:text="one"     
        android:background="#98FB98"    
     />    
     <TextView    
        android:layout_weight="2"    
        android:layout_width="wrap_content"    
        android:layout_height="fill_parent"    
        android:text="two"     
        android:background="#FFFF00"    
     />    
     <TextView    
        android:layout_weight="3"    
        android:layout_width="wrap_content"    
        android:layout_height="fill_parent"    
        android:text="three"     
        android:background="#FF00FF"    
     />    
    
</LinearLayout>  
 
```

##### **2)match_parent(fill_parent):这个则需要计算了**

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"    
    xmlns:tools="http://schemas.android.com/tools"    
    android:id="@+id/LinearLayout1"    
    android:layout_width="match_parent"    
    android:layout_height="match_parent" >    
    
    <TextView    
        android:layout_weight="1"    
        android:layout_width="fill_parent"    
        android:layout_height="fill_parent"    
        android:text="one"     
        android:background="#98FB98"    
     />    
     <TextView    
        android:layout_weight="2"    
        android:layout_width="fill_parent"    
        android:layout_height="fill_parent"    
        android:text="two"     
        android:background="#FFFF00"    
     />    
     <TextView    
        android:layout_weight="3"    
        android:layout_width="fill_parent"    
        android:layout_height="fill_parent"    
        android:text="three"     
        android:background="#FF00FF"    
     />    
    
</LinearLayout> 
 
```

运行效果图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/6746070.jpg)

> 这个时候就会有疑问了,怎么会这样,这比例是2:1吧,那么three去哪了？代码里面明明有 three的啊,还设置了3的,而1和2的比例也不对耶,1:2:3却变成了2:1:0,怎么会这样呢? 答:这里其实没那么简单的,还是需要我们计算的,网上给出的算法有几种,这里就给出笔者觉得比较容易理解的一种: 
> **step 1：**个个都是fill_parent,但是屏幕只有一个啦,那么1 - 3 = - 2 fill_parent 
> **step 2：**依次比例是1/6,2/6,3/6 
> **step 3：**先到先得,先分给one,计算: 1 - 2 * (1/6) = 2/3 fill_parent 接着到two,计算: 1 - 2 * (2/6) = 1/3 fill_parent 最后到three,计算 1 - 2 * (3/6) = 0 fill_parent 
> **step 4：**所以最后的结果是:one占了两份,two占了一份,three什么都木有 以上就是为什么three没有出现的原因了,或许大家看完还是有点蒙,没事,我们举多几个例子试试就知道了！

##### Java代码中设置weight属性

```java
setLayoutParams(new LayoutParams(LayoutParams.FILL_PARENT,LayoutParams.WRAP_CONTENT, 1)); 
```

#### 1.2.1.2. 为LinearLayout设置分割线

很多界面开发中都会设置一些下划线,或者分割线,从而使得界面更加整洁美观,比如下面的酷狗 音乐的注册页面:

<img src="https://www.runoob.com/wp-content/uploads/2015/07/91165417.jpg" alt="img" style="zoom:80%;" />

#####  直接在布局中添加一个view

​	这个view的作用仅仅是显示出一条线,代码也很简单:

```xml
<View  
    android:layout_width="match_parent"  
    android:layout_height="1px"  
    android:background="#000000" />  
```

这个是水平方向上的黑线,当然你也可以改成其他颜色,或者使用图片

![img](https://www.runoob.com/wp-content/uploads/2015/07/20682772.jpg)

##### **使用LinearLayout的一个divider属性**

直接为LinearLayout设置分割线 这里就需要你自己准备一张线的图片了 
···android:divider设置作为分割线的图片 
···android:showDividers设置分割线的位置,none(无),beginning(开始),end(结束),middle(每两个组件间) 
···dividerPadding设置分割线的Padding

使用示例：

![img](https://www.runoob.com/wp-content/uploads/2015/07/36880631.jpg)

实现代码：

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"  
    xmlns:tools="http://schemas.android.com/tools"  
    android:id="@+id/LinearLayout1"  
    android:layout_width="match_parent"  
    android:layout_height="match_parent"  
    android:divider="@drawable/ktv_line_div"  
    android:orientation="vertical"  
    android:showDividers="middle"  
    android:dividerPadding="10dp"  
    tools:context="com.jay.example.linearlayoutdemo.MainActivity" >  
  
    <Button  
        android:layout_width="wrap_content"  
        android:layout_height="wrap_content"  
        android:text="按钮1" />  
  
    <Button  
        android:layout_width="wrap_content"  
        android:layout_height="wrap_content"  
        android:text="按钮2" />  
  
    <Button  
        android:layout_width="wrap_content"  
        android:layout_height="wrap_content"  
        android:text="按钮3" />  
  
</LinearLayout>
```

#### 1.2.1.3. LinearLayout的简单例子

![img](https://www.runoob.com/wp-content/uploads/2015/07/20488688.jpg)

实现代码如下：

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"    
    xmlns:tools="http://schemas.android.com/tools"    
    android:id="@+id/LinearLayout1"    
    android:layout_width="fill_parent"    
    android:layout_height="fill_parent"    
    android:orientation="vertical"    
    tools:context=".MainActivity" >    
        
    <TextView    
        android:layout_width="wrap_content"    
        android:layout_height="wrap_content"    
        android:text="请输入要保存的电话号码"/>    
    <EditText    
        android:layout_width="fill_parent"    
        android:layout_height="wrap_content"/>    
    <LinearLayout    
        android:layout_width="fill_parent"    
        android:layout_height="wrap_content"    
        android:orientation="horizontal"    
        android:gravity="right">    
        <Button    
            android:layout_width="wrap_content"    
            android:layout_height="wrap_content"    
            android:text="保存"/>    
        <Button    
            android:layout_width="wrap_content"    
            android:layout_height="wrap_content"    
            android:text="清空"/>    
    </LinearLayout>    
</LinearLayout> 
```

#### 1.2.1.4. 注意事项

使用Layout_gravity的一个很重要的问题!!! 问题内容: 在一个LinearLayout的水平方向中布置两个TextView,想让一个左,一个右,怎么搞? 

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"  
    xmlns:tools="http://schemas.android.com/tools"  
    android:layout_width="match_parent"  
    android:layout_height="match_parent"  
    android:orientation="horizontal"  
    tools:context="com.jay.example.getscreendemo.MainActivity" >  
  
    <TextView  
        android:layout_width="wrap_content"  
        android:layout_height="200dp"  
        android:layout_gravity="left"  
        android:background="#FF7878"  
        android:gravity="center"  
        android:text="O(∩_∩)O哈哈~" />  
  
    <TextView  
        android:layout_width="wrap_content"  
        android:layout_height="200dp"  
        android:layout_gravity="right"  
        android:background="#FF7428"  
        android:gravity="center"  
        android:text="(*^__^*) 嘻嘻……" />  
  
</LinearLayout>
```

运行结果图:

![img](https://www.runoob.com/wp-content/uploads/2015/07/85914414.jpg)

看到这里你会说:哎呀,真的不行耶,要不在外层LinearLayout加个gravity=left的属性,然后设置第二个 TextView的layout_gravity为right,恩,好我们试一下:

```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"  
    xmlns:tools="http://schemas.android.com/tools"  
    android:layout_width="match_parent"  
    android:layout_height="match_parent"  
    android:orientation="horizontal"  
    android:gravity="left"  
    tools:context="com.jay.example.getscreendemo.MainActivity" >  
  
    <TextView  
        android:layout_width="wrap_content"  
        android:layout_height="200dp"  
        android:background="#FF7878"  
        android:gravity="center"  
        android:text="O(∩_∩)O哈哈~" />  
  
    <TextView  
        android:layout_width="wrap_content"  
        android:layout_height="200dp"  
        android:layout_gravity="right"  
        android:background="#FF7428"  
        android:gravity="center"  
        android:text="(*^__^*) 嘻嘻……" />  
  
</LinearLayout> 
```

结果还是一样：

![img](https://www.runoob.com/wp-content/uploads/2015/07/29553670.jpg)

好吧,没辙了,怎么办好?

> **当 android:orientation="vertical" 时， 只有水平方向的设置才起作用，垂直方向的设置不起作用。 即：left，right，center_horizontal 是生效的。 当 android:orientation="horizontal" 时， 只有垂直方向的设置才起作用，水平方向的设置不起作用。 即：top，bottom，center_vertical 是生效的。**

然而，这方法好像并没有什么卵用。比如： 如果只能竖直方向设置左右对齐的话,就会出现下面的效果:

![img](https://www.runoob.com/wp-content/uploads/2015/07/71894191.jpg)

综上,要么按照上述给出的规则来布局,不过对于这种情况还是使用相对布局RelativeLayout吧
网上没给出具体的原因,都是说这样改
有人说这个和orientation的优先级有关 ,暂且先mark下来吧,后续如果知道原因的话再解释

### **1.2.2. RelativeLayout(相对布局)**

------

LinearLayout也是我们 用的比较多的一个布局,我们更多的时候更钟情于他的weight(权重)属性，等比例划分
当界面比较复杂的时候，需要嵌套多层的 LinearLayout,这样就会降低UI Render的效率(渲染速度)
而且如果是listview或者GridView上的 item,效率会更低
另外太多层LinearLayout嵌套会占用更多的系统资源,还有可能引发stackoverflow
但是如果我们使用RelativeLayout的话,可能仅仅需要一层就可以完成了
以父容器或者兄弟组件参考+margin +padding就可以设置组件的显示位置,是比较方便的
当然,也不是绝对的总结就是:**尽量使用RelativeLayout + LinearLayout的weight属性搭配使用**吧！

------

![img](https://www.runoob.com/wp-content/uploads/2015/07/797932661-1.png)

------

父容器定位属性示意图

![img](https://www.runoob.com/wp-content/uploads/2015/07/44967125.jpg)

------

根据兄弟组件定位

兄弟组件就是处于同一层次容器的组件,如图

<img src="https://www.runoob.com/wp-content/uploads/2015/07/23853521.jpg" alt="img" style="zoom: 80%;" />

图中的组件1,2就是兄弟组件了,而组件3与组件1或组件2并不是兄弟组件,所以组件3不能通过 组件1或2来进行定位,比如layout_toleftof = "组件1"这样是会报错的！切记！ 关于这个兄弟组件定位的最经典例子就是"梅花布局"了,下面代码实现下:

运行效果图：

![img](https://www.runoob.com/wp-content/uploads/2015/07/14556678.jpg)

实现代码：

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"    
    xmlns:tools="http://schemas.android.com/tools"    
    android:id="@+id/RelativeLayout1"    
    android:layout_width="match_parent"    
    android:layout_height="match_parent" >    
    
    <!-- 这个是在容器中央的 -->    
        
    <ImageView    
        android:id="@+id/img1"     
        android:layout_width="80dp"    
        android:layout_height="80dp"    
        android:layout_centerInParent="true"    
        android:src="@drawable/pic1"/>    
        
    <!-- 在中间图片的左边 -->    
    <ImageView    
        android:id="@+id/img2"     
        android:layout_width="80dp"    
        android:layout_height="80dp"    
        android:layout_toLeftOf="@id/img1"    
        android:layout_centerVertical="true"    
        android:src="@drawable/pic2"/>    
        
    <!-- 在中间图片的右边 -->    
    <ImageView    
        android:id="@+id/img3"     
        android:layout_width="80dp"    
        android:layout_height="80dp"    
        android:layout_toRightOf="@id/img1"    
        android:layout_centerVertical="true"    
        android:src="@drawable/pic3"/>    
        
    <!-- 在中间图片的上面-->    
    <ImageView    
        android:id="@+id/img4"     
        android:layout_width="80dp"    
        android:layout_height="80dp"    
        android:layout_above="@id/img1"    
        android:layout_centerHorizontal="true"    
        android:src="@drawable/pic4"/>    
        
    <!-- 在中间图片的下面 -->    
    <ImageView    
        android:id="@+id/img5"     
        android:layout_width="80dp"    
        android:layout_height="80dp"    
        android:layout_below="@id/img1"    
        android:layout_centerHorizontal="true"    
        android:src="@drawable/pic5"/>    
    
</RelativeLayout>
```

##### 1.2.2.1. margin与padding的区别

初学者对于这两个属性可能会有一点混淆，这里区分下： 首先margin代表的是偏移,比如marginleft = "5dp"表示组件离容器左边缘偏移5dp; 而padding代表的则是填充,而填充的对象针对的是组件中的元素,比如TextView中的文字 比如为TextView设置paddingleft = "5dp",则是在组件里的元素的左边填充5dp的空间！ margin针对的是容器中的组件，而padding针对的是组件中的元素，要区分开来！ 下面通过简单的代码演示两者的区别:

比较示例代码如下：

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"    
    xmlns:tools="http://schemas.android.com/tools"    
    android:layout_width="match_parent"    
    android:layout_height="match_parent"    
    android:paddingBottom="@dimen/activity_vertical_margin"    
    android:paddingLeft="@dimen/activity_horizontal_margin"    
    android:paddingRight="@dimen/activity_horizontal_margin"    
    android:paddingTop="@dimen/activity_vertical_margin"    
    tools:context=".MainActivity" >    
    
    <Button    
        android:id="@+id/btn1"     
        android:layout_height="wrap_content"    
        android:layout_width="wrap_content"    
        android:text="Button"/>    
    <Button    
        android:paddingLeft="100dp"     
        android:layout_height="wrap_content"    
        android:layout_width="wrap_content"    
        android:text="Button"    
        android:layout_toRightOf="@id/btn1"/>    
        
    <Button    
        android:id="@+id/btn2"     
        android:layout_height="wrap_content"    
        android:layout_width="wrap_content"    
        android:text="Button"    
        android:layout_alignParentBottom="true"/>    
    <Button    
        android:layout_marginLeft="100dp"     
        android:layout_height="wrap_content"    
        android:layout_width="wrap_content"    
        android:text="Button"    
        android:layout_toRightOf="@id/btn2"     
        android:layout_alignParentBottom="true"/>    
        
</RelativeLayout> 
```

运行效果图比较：

![img](https://www.runoob.com/wp-content/uploads/2015/07/68121405.jpg)

------

##### 1.2.2.2. 很常用的一点:margin可以设置为负数

相信很多朋友都不知道一点吧，平时我们设置margin的时候都习惯了是正数的, 其实是可以用负数的,下面写个简单的程序演示下吧,模拟进入软件后,弹出广告 页面的,右上角的cancle按钮的margin则是使用负数的！

效果图如下:

![此处输入图片的描述](https://www.runoob.com/wp-content/uploads/2015/07/78965428.jpg)

贴出的广告Activity的布局代码吧,当然,如果你对这个有兴趣的话可以下下demo, 因为仅仅是实现效果,所以代码会有些粗糙！

```xml
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"  
    xmlns:tools="http://schemas.android.com/tools"  
    android:layout_width="match_parent"  
    android:layout_height="match_parent"  
    tools:context="com.jay.example.relativelayoutdemo.MainActivity"   
    android:background="#00CCCCFF">  
  
    <ImageView  
        android:id="@+id/imgBack"  
        android:layout_width="200dp"  
        android:layout_height="200dp"  
        android:layout_centerInParent="true"  
        android:background="@drawable/myicon" />  
  
    <ImageView  
        android:id="@+id/imgCancle"  
        android:layout_width="28dp"  
        android:layout_height="28dp"  
        android:layout_alignRight="@id/imgBack"  
        android:layout_alignTop="@id/imgBack"  
        android:background="@drawable/cancel"  
        android:layout_marginTop="-15dp"  
        android:layout_marginRight="-10dp" />  
  
</RelativeLayout>  
```

## User Interface Components

------

你无需全部用View和ViewGroup对象来创建你的UI布局。Android给我们提供了一些app控件，标准的UI布局，你只需要定义内容。这些UI组件都有其属性介绍的API文档，比如操作栏，对话框和状态通知栏等。