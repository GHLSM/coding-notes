# Activity入门

**介绍如下：** ![img](https://www.runoob.com/wp-content/uploads/2015/08/48284031.jpg) 
**大概意思：**

> Activity是一个应用程序的组件，他在屏幕上提供了一个区域，允许用户在上面做一些交互性的操作， 比如打电话，照相，发送邮件，或者显示一个地图！Activity可以理解成一个绘制用户界面的窗口， 而这个窗口可以填满整个屏幕，也可能比屏幕小或者浮动在其他窗口的上方！

从上面这段话，我们可以得到以下信息：

> **1.** Activity用于显示用户界面，用户通过Activity交互完成相关操作 **2.** 一个App允许有多个Activity

## 1.Activity的概念与Activity的生命周期图：

![img](https://www.runoob.com/wp-content/uploads/2015/08/18364230.jpg)

**注意事项：**

> **1.** **onPause()和onStop()被调用的前提是**： 打开了一个新的Activity！而前者是旧Activity还可见的状态；后者是旧Activity已经不可见！
>
> 2. 另外，亲测：AlertDialog和PopWindow是不会触发上述两个回调方法的~

------

## 2.Activity/ActionBarActivity/AppCompatActivity的区别：

> 在开始讲解创建Activity之前要说下这三个的一个区别： Activity就不用说啦，后面这两个都是为了低版本兼容而提出的提出来的，他们都在v7包下， ActionBarActivity已被废弃，从名字就知道，ActionBar~，而在5.0后，被Google弃用了，现在用 ToolBar...而我们现在在Android Studio创建一个Activity默认继承的会是：AppCompatActivity! 当然你也可以只写Activity，不过AppCompatActivity给我们提供了一些新的东西而已！ 两个选一个，Just you like~

------

## 3.Activity的创建流程

![img](https://www.runoob.com/wp-content/uploads/2015/08/48768883.jpg)

**PS:**

> 好了，上面也说过，可以继承Activity和AppCompatActivity，只不过后者提供了一些新的东西而已！ 另外，切记，Android中的四大组件，只要你定义了，无论你用没用，都要在AndroidManifest.xml对 这个组件进行声明，不然运行时程序会直接退出，报ClassNotFindException...

------

## 4.onCreate()一个参数和两个参数的区别：

相信用as的朋友在重写Act的onCreate()方法时会发现，这玩意有两个参数：

![img](https://www.runoob.com/wp-content/uploads/2015/08/18677320.jpg)

可是正常的才只有一个参数啊：

![img](https://www.runoob.com/wp-content/uploads/2015/08/28609433.jpg)

恩呢，这就是5.0给我们提供的新的方法，要用它，先要在配置文件中为我们的Activity设置一个属性：

```
android:persistableMode="persistAcrossReboots"
```

然后我们的Activity就拥有了持久化的能力了，一般我们会搭配另外两个方法来使用：

```java
public void onSaveInstanceState(Bundle outState, PersistableBundle outPersistentState)
public void onRestoreInstanceState(Bundle savedInstanceState, PersistableBundle persistentState)
```

相信有些朋友对这两个方法名不陌生吧，前一个方法会在下述情形中被调用：

> 1. 点击home键回到主页或长按后选择运行其他程序
> 2. 按下电源键关闭屏幕
> 3. 启动新的Activity
> 4. 横竖屏切换时，肯定会执行，因为横竖屏切换的时候会先销毁Act，然后再重新创建 重要原则：当系统"未经你许可"时销毁了你的activity，则onSaveInstanceState会被系统调用， 这是系统的责任，因为它必须要提供一个机会让你保存你的数据（你可以保存也可以不保存）。

而后一个方法，和onCreate同样可以从取出前者保存的数据： 一般是在onStart()和onResume()之间执行！ 之所以有两个可以获取到保存数据的方法，是为了避免Act跳转而没有关闭， 然后不走onCreate()方法，而你又想取出保存数据~

**说回来：** 说回这个Activity拥有了持久化的能力，增加的这个PersistableBundle参数令这些方法 拥有了系统**关机后重启**的数据恢复能力！！而且不影响我们其他的序列化操作，卧槽， 具体怎么实现的，暂时还不了解，可能是另外弄了个文件保存吧~！后面知道原理的话会告知下大家！ 另外，API版本需要>=21，就是要5.0以上的版本才有效~

------

## 4.启动一个Activity的几种方式

> 在Android中我们可以通过下面两种方式来启动一个新的Activity,注意这里是怎么启动，而非启动模式！！分为显示启动和隐式启动！

**1. 显式启动：通过包名来启动，写法如下：**

> **①最常见的：**
>
> ```
> startActivity(new Intent(当前Act.this,要启动的Act.class));
> ```
>
> ②通过Intent的ComponentName：
>
> ```
> ComponentName cn = new ComponentName("当前Act的全限定类名","启动Act的全限定类名") ;
> Intent intent = new Intent() ;
> intent.setComponent(cn) ;
> startActivity(intent) ;
> ```
>
> ③初始化Intent时指定包名：
>
> ```
> Intent intent = new Intent("android.intent.action.MAIN");
> intent.setClassName("当前Act的全限定类名","启动Act的全限定类名");
> startActivity(intent);
> ```

**2.隐式启动：通过Intent-filter的Action,Category或data来实现 这个是通过Intent的** intent-filter**来实现的，这个Intent那章会详细讲解！ 这里知道个大概就可以了！

![img](https://www.runoob.com/wp-content/uploads/2015/08/291262381.jpg)

**3. 另外还有一个直接通过包名启动apk的：**

```
Intent intent = getPackageManager().getLaunchIntentForPackage
("apk第一个启动的Activity的全限定类名") ;
if(intent != null) startActivity(intent) ;
```

------

## 5.横竖屏切换与状态保存的问题

> 前面也也说到了App横竖屏切换的时候会销毁当前的Activity然后重新创建一个，你可以自行在生命周期 的每个方法里都添加打印Log的语句，来进行判断，又或者设一个按钮一个TextView点击按钮后，修改TextView 文本，然后横竖屏切换，会神奇的发现TextView文本变回之前的内容了！ 横竖屏切换时Act走下述生命周期：
> **onPause-> onStop-> onDestory-> onCreate->onStart->onResume**
> 关于横竖屏切换可能遇到下述问题：

------

1.先说下如何**禁止屏幕横竖屏自动切换**吧，很简单，在AndroidManifest.xml中为Act添加一个属性： **android:screenOrientation**， 有下述可选值：

- **unspecified**:默认值 由系统来判断显示方向.判定的策略是和设备相关的，所以不同的设备会有不同的显示方向。
- **landscape**:横屏显示（宽比高要长）
- **portrait**:竖屏显示(高比宽要长)
- **user**:用户当前首选的方向
- **behind**:和该Activity下面的那个Activity的方向一致(在Activity堆栈中的)
- **sensor**:有物理的感应器来决定。如果用户旋转设备这屏幕会横竖屏切换。
- **nosensor**:忽略物理感应器，这样就不会随着用户旋转设备而更改了（"unspecified"设置除外）。

------

2.**横竖屏时想加载不同的布局**：

1）准备两套不同的布局，Android会自己根据横竖屏加载不同布局： 创建两个布局文件夹：**layout-land**横屏,**layout-port**竖屏 然后把这两套布局文件丢这两文件夹里，文件名一样，Android就会自行判断，然后加载相应布局了！

2 )自己在代码中进行判断，自己想加载什么就加载什么：

我们一般是在onCreate()方法中加载布局文件的，我们可以在这里对横竖屏的状态做下判断，关键代码如下：

```
if (this.getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE){  
     setContentView(R.layout.横屏);
}  

else if (this.getResources().getConfiguration().orientation ==Configuration.ORIENTATION_PORTRAIT) {  
    setContentView(R.layout.竖屏);
}
```

------

**3. 如何让模拟器横竖屏切换**

如果你的模拟器是GM的话。直接按模拟器上的切换按钮即可，原生模拟器可按ctrl + f11/f12切换！

------

**4. 状态保存问题：**

这个上面也说过了，通过一个Bundle savedInstanceState参数即可完成！ 三个核心方法：

------

```
onCreate(Bundle savedInstanceState);
onSaveInstanceState(Bundle outState);
onRestoreInstanceState(Bundle savedInstanceState);
```

你只重写onSaveInstanceState()方法，往这个bundle中写入数据，比如：

> outState.putInt("num",1);

这样，然后你在onCreate或者onRestoreInstanceState中就可以拿出里面存储的数据，不过拿之前要判断下是否为null哦！

> savedInstanceState.getInt("num");

然后想干嘛就干嘛~

------

## 6.系统给我们提供的常见的Activity

好的，最后给大家附上一些系统给我们提供的一些常见的Activtiy吧！

```java
//1.拨打电话
// 给移动客服10086拨打电话
Uri uri = Uri.parse("tel:10086");
Intent intent = new Intent(Intent.ACTION_DIAL, uri);
startActivity(intent);

//2.发送短信
// 给10086发送内容为“Hello”的短信
Uri uri = Uri.parse("smsto:10086");
Intent intent = new Intent(Intent.ACTION_SENDTO, uri);
intent.putExtra("sms_body", "Hello");
startActivity(intent);

//3.发送彩信（相当于发送带附件的短信）
Intent intent = new Intent(Intent.ACTION_SEND);
intent.putExtra("sms_body", "Hello");
Uri uri = Uri.parse("content://media/external/images/media/23");
intent.putExtra(Intent.EXTRA_STREAM, uri);
intent.setType("image/png");
startActivity(intent);

//4.打开浏览器:
// 打开Google主页
Uri uri = Uri.parse("http://www.baidu.com");
Intent intent  = new Intent(Intent.ACTION_VIEW, uri);
startActivity(intent);

//5.发送电子邮件:(阉割了Google服务的没戏!!!!)
// 给someone@domain.com发邮件
Uri uri = Uri.parse("mailto:someone@domain.com");
Intent intent = new Intent(Intent.ACTION_SENDTO, uri);
startActivity(intent);
// 给someone@domain.com发邮件发送内容为“Hello”的邮件
Intent intent = new Intent(Intent.ACTION_SEND);
intent.putExtra(Intent.EXTRA_EMAIL, "someone@domain.com");
intent.putExtra(Intent.EXTRA_SUBJECT, "Subject");
intent.putExtra(Intent.EXTRA_TEXT, "Hello");
intent.setType("text/plain");
startActivity(intent);
// 给多人发邮件
Intent intent=new Intent(Intent.ACTION_SEND);
String[] tos = {"1@abc.com", "2@abc.com"}; // 收件人
String[] ccs = {"3@abc.com", "4@abc.com"}; // 抄送
String[] bccs = {"5@abc.com", "6@abc.com"}; // 密送
intent.putExtra(Intent.EXTRA_EMAIL, tos);
intent.putExtra(Intent.EXTRA_CC, ccs);
intent.putExtra(Intent.EXTRA_BCC, bccs);
intent.putExtra(Intent.EXTRA_SUBJECT, "Subject");
intent.putExtra(Intent.EXTRA_TEXT, "Hello");
intent.setType("message/rfc822");
startActivity(intent);

//6.显示地图:
// 打开Google地图中国北京位置（北纬39.9，东经116.3）
Uri uri = Uri.parse("geo:39.9,116.3");
Intent intent = new Intent(Intent.ACTION_VIEW, uri);
startActivity(intent);

//7.路径规划
// 路径规划：从北京某地（北纬39.9，东经116.3）到上海某地（北纬31.2，东经121.4）
Uri uri = Uri.parse("http://maps.google.com/maps?f=d&saddr=39.9 116.3&daddr=31.2 121.4");
Intent intent = new Intent(Intent.ACTION_VIEW, uri);
startActivity(intent);

//8.多媒体播放:
Intent intent = new Intent(Intent.ACTION_VIEW);
Uri uri = Uri.parse("file:///sdcard/foo.mp3");
intent.setDataAndType(uri, "audio/mp3");
startActivity(intent);

//获取SD卡下所有音频文件,然后播放第一首=-= 
Uri uri = Uri.withAppendedPath(MediaStore.Audio.Media.INTERNAL_CONTENT_URI, "1");
Intent intent = new Intent(Intent.ACTION_VIEW, uri);
startActivity(intent);

//9.打开摄像头拍照:
// 打开拍照程序
Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE); 
startActivityForResult(intent, 0);
// 取出照片数据
Bundle extras = intent.getExtras(); 
Bitmap bitmap = (Bitmap) extras.get("data");

//另一种:
//调用系统相机应用程序，并存储拍下来的照片
Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE); 
time = Calendar.getInstance().getTimeInMillis();
intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.fromFile(new File(Environment
.getExternalStorageDirectory().getAbsolutePath()+"/tucue", time + ".jpg")));
startActivityForResult(intent, ACTIVITY_GET_CAMERA_IMAGE);

//10.获取并剪切图片
// 获取并剪切图片
Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
intent.setType("image/*");
intent.putExtra("crop", "true"); // 开启剪切
intent.putExtra("aspectX", 1); // 剪切的宽高比为1：2
intent.putExtra("aspectY", 2);
intent.putExtra("outputX", 20); // 保存图片的宽和高
intent.putExtra("outputY", 40); 
intent.putExtra("output", Uri.fromFile(new File("/mnt/sdcard/temp"))); // 保存路径
intent.putExtra("outputFormat", "JPEG");// 返回格式
startActivityForResult(intent, 0);
// 剪切特定图片
Intent intent = new Intent("com.android.camera.action.CROP"); 
intent.setClassName("com.android.camera", "com.android.camera.CropImage"); 
intent.setData(Uri.fromFile(new File("/mnt/sdcard/temp"))); 
intent.putExtra("outputX", 1); // 剪切的宽高比为1：2
intent.putExtra("outputY", 2);
intent.putExtra("aspectX", 20); // 保存图片的宽和高
intent.putExtra("aspectY", 40);
intent.putExtra("scale", true);
intent.putExtra("noFaceDetection", true); 
intent.putExtra("output", Uri.parse("file:///mnt/sdcard/temp")); 
startActivityForResult(intent, 0);

//11.打开Google Market 
// 打开Google Market直接进入该程序的详细页面
Uri uri = Uri.parse("market://details?id=" + "com.demo.app");
Intent intent = new Intent(Intent.ACTION_VIEW, uri);
startActivity(intent);

//12.进入手机设置界面:
// 进入无线网络设置界面（其它可以举一反三）  
Intent intent = new Intent(android.provider.Settings.ACTION_WIRELESS_SETTINGS);  
startActivityForResult(intent, 0);

//13.安装apk:
Uri installUri = Uri.fromParts("package", "xxx", null);   
returnIt = new Intent(Intent.ACTION_PACKAGE_ADDED, installUri);

//14.卸载apk:
Uri uri = Uri.fromParts("package", strPackageName, null);      
Intent it = new Intent(Intent.ACTION_DELETE, uri);      
startActivity(it); 

//15.发送附件:
Intent it = new Intent(Intent.ACTION_SEND);      
it.putExtra(Intent.EXTRA_SUBJECT, "The email subject text");      
it.putExtra(Intent.EXTRA_STREAM, "file:///sdcard/eoe.mp3");      
sendIntent.setType("audio/mp3");      
startActivity(Intent.createChooser(it, "Choose Email Client"));

//16.进入联系人页面:
Intent intent = new Intent();
intent.setAction(Intent.ACTION_VIEW);
intent.setData(People.CONTENT_URI);
startActivity(intent);

//17.查看指定联系人:
Uri personUri = ContentUris.withAppendedId(People.CONTENT_URI, info.id);//info.id联系人ID
Intent intent = new Intent();
intent.setAction(Intent.ACTION_VIEW);
intent.setData(personUri);
startActivity(intent);
```

# Activity初窥门径

## Activity间的数据传递：

![img](https://www.runoob.com/wp-content/uploads/2015/08/7185831.jpg)

## 多个Activity间的交互(后一个传回给前一个)

![img](https://www.runoob.com/wp-content/uploads/2015/08/67124491.jpg)

## 知晓当前是哪个Activity

![img](https://www.runoob.com/wp-content/uploads/2015/08/19579941.jpg)

## 随时关闭所有Activity

> 有时我们可能会打开了很多个Activity，突然来个这样的需求，在某个页面可以关掉 所有的Activity并退出程序！好吧，下面提供一个关闭所有Activity的方法， 就是用一个list集合来存储所有Activity!

![img](https://www.runoob.com/wp-content/uploads/2015/08/59443692.jpg)

**具体代码如下：**

```java
public class ActivityCollector {  
    public static LinkedList<Activity> activities = new LinkedList<Activity>();  
    public static void addActivity(Activity activity)  
    {  
        activities.add(activity);  
    }  
    public static void removeActivity(Activity activity)  
    {  
        activities.remove(activity);  
    }  
    public static void finishAll()  
    {  
        for(Activity activity:activities)  
        {  
            if(!activity.isFinishing())  
            {  
                activity.finish();  
            }  
        }  
    }  
}  
```

## 完全退出App的方法

上面说的是关闭所有Activity的，但是有些时候我们可能想杀死整个App，连后台任务都杀死 杀得一干二净的话，可以使用搭配着下述代码使用：

**实现代码：**

```java
/** 
 * 退出应用程序 
 */  
public void AppExit(Context context) {  
    try {  
        ActivityCollector.finishAll();  
        ActivityManager activityMgr = (ActivityManager) context  
                .getSystemService(Context.ACTIVITY_SERVICE);  
        activityMgr.killBackgroundProcesses(context.getPackageName());  
        System.exit(0);  
    } catch (Exception ignored) {}  
}  
```

------

## 双击退出程序的两种方法

1）定义一个变量，来标识是否退出

```java
// 定义一个变量，来标识是否退出
private static boolean isExit = false;
Handler mHandler = new Handler() {
    @Override
    public void handleMessage(Message msg) {
        super.handleMessage(msg);
        isExit = false;
    }
};

public boolean onKeyDown(int keyCode, KeyEvent event) {
    if (keyCode == KeyEvent.KEYCODE_BACK) {
        if (!isExit) {
            isExit = true;
            Toast.makeText(getApplicationContext(), "再按一次退出程序",
                    Toast.LENGTH_SHORT).show();
            // 利用handler延迟发送更改状态信息
            mHandler.sendEmptyMessageDelayed(0, 2000);
        } else {
            exit(this);
        }
        return false;
    }
return super.onKeyDown(keyCode, event);}
```

2）保存点击时间：

```java
//保存点击的时间
private long exitTime = 0;
public boolean onKeyDown(int keyCode, KeyEvent event) {
    if (keyCode == KeyEvent.KEYCODE_BACK) {
        if ((System.currentTimeMillis() - exitTime) > 2000) {
            Toast.makeText(getApplicationContext(), "再按一次退出程序",
                    Toast.LENGTH_SHORT).show();
            exitTime = System.currentTimeMillis();
        } else {
                        exit();
                      }
        return false;
    }
        return super.onKeyDown(keyCode, event);
}
```

## 为Activity设置过场动画

> 所谓的过场动画就是切换到另外的Activity时加上一些切换动画，比如淡入淡出，放大缩小，左右互推等！ 当然，我们并不在这里详细讲解动画，后面有专门的章节来讲解这个，这里只教大家如何去加载动画，另外 给大家提供了一些比较常用的过渡动画，只要将相关动画文件添加到res/anim目录下，然后下述方法二选一 就可以实现Activity的切换动画了！

1）方法一：

![img](https://www.runoob.com/wp-content/uploads/2015/08/16878455.jpg)

2）方法二：

通过style进行配置，这个是全局的哦，就是所有的Activity都会加载这个动画！

**实现代码如下：**

**①在style.xml中自定义style：**

```xml
<!-- 默认Activity跳转动画 -->
<style name="default_animation" mce_bogus="1" parent="@android:style/Animation.Activity">
    <item name="android:activityOpenEnterAnimation">@anim/default_anim_in</item>
    <item name="android:activityOpenExitAnimation">@anim/anim_stay</item>
    <item name="android:activityCloseEnterAnimation">@anim/anim_stay</item>
    <item name="android:activityCloseExitAnimation">@anim/default_anim_out</item>
</style>
```

**解释：**
4个item分别代表:

- Activity A跳转到Activity B时Activity B进入动画;
- Activity A跳转到Activity B时Activity A退出动画;
- Activity B返回Activity A时Activity A的进入动画
- Activity B返回Activity A时ActivityB的退出动画

**②然后修改下AppTheme:**

```
<style name="AppTheme" mce_bogus="1" parent="@android:style/Theme.Light">
        <item name="android:windowAnimationStyle">@style/default_animation</item>
        <item name="android:windowNoTitle">true</item>
</style>
```

**③最后在appliction设置下：**

```
<application
   android:icon="@drawable/logo"
   android:label="@string/app_name"
   android:theme="@style/AppTheme" >
```

3）其他

好的，除了上面两种方法以外，还可以使用**TransitionManager**来实现，但是需求版本是API 19以上的， 另外还有一种**addOnPreDrawListener**的转换动画，这个用起来还是有点麻烦的，可能不是适合初学者 这里也不讲，最后提供下一些常用的动画效果打包，选择需要的特效加入工程即可！ [Activity常用过渡动画.zip](https://www.runoob.com/wp-content/uploads/2015/08/Activity常用过渡动画.zip)

## Bundle传递数据的限制

> 在使用Bundle传递数据时，要注意，Bundle的大小是有限制的 < 0.5MB，如果大于这个值 是会报TransactionTooLargeException异常的！！！

## 使用命令行查看当前所有Activity的命令

> 使用下述命令即可，前提是你为SDK配置了环境变量:
> **adb shell dumpsys activity**

## 设置Activity全屏的方法：

**1）代码隐藏ActionBar**

在Activity的onCreate方法中调用getActionBar.hide();即可

**2）通过requestWindowFeature设置**

requestWindowFeature(Window.FEATURE_NO_TITLE); 该代码需要在setContentView ()之前调用，不然会报错！！！

> **注：** 把 requestWindowFeature(Window.FEATURE_NO_TITLE);放在super.onCreate(savedInstanceState);前面就可以隐藏ActionBar而不报错。

**3）通过AndroidManifest.xml的theme**

在需要全屏的Activity的标签内设置 theme = @android:style/Theme.NoTitleBar.FullScreen

## onWindowFocusChanged方法妙用

![img](https://www.runoob.com/wp-content/uploads/2015/08/17084157.jpg)

当Activity得到或者失去焦点的时候，就会回调该方法！ 如果我们想监控Activity是否加载完毕，就可以用到这个方法

## 定义对话框风格的Activity

> 在某些情况下，我们可能需要将Activity设置成对话框风格的，Activity一般是占满全屏的， 而Dialog则是占据部分屏幕的！实现起来也很简单！

直接设置下Activity的theme:

```xml
android:theme="@android:style/Theme.Dialog"
```

```
//设置左上角小图标
requestWindowFeature(Window.FEATURE_LEFT_ICON);
setContentView(R.layout.main);
getWindow().setFeatureDrawableResource(Window.FEATURE_LEFT_ICON, android.R.drawable.ic_lion_icon);
//设置文字:
setTitle(R.string.actdialog_title);  //XML代码中设置:android:label="@string/activity_dialog"
```

# Activity登堂入室

## 1.Activity，Window与View的关系

> 小结图：

![img](https://www.runoob.com/wp-content/uploads/2015/08/93497523.jpg)

**流程解析：** Activity调用startActivity后最后会调用attach方法，然后在PolicyManager实现一个Ipolicy接口，接着实现一个Policy对象，接着调用makenewwindow(Context)方法，该方法会返回一个PhoneWindow对象，而PhoneWindow 是Window的子类，在这个PhoneWindow中有一个DecorView的内部类，是所有应用窗口的根View，即View的老大， 直接控制Activity是否显示(引用老司机原话..)，好吧，接着里面有一个LinearLayout，里面又有两个FrameLayout他们分别拿来装ActionBar和CustomView，而我们setContentView()加载的布局就放到这个CustomView中！

**总结下这三者的关系：** 打个牵强的比喻： 我们可以把这三个类分别堪称：画家，画布，画笔画出的东西； 画家通过画笔( **LayoutInflater.infalte**)画出图案，再绘制在画布(**addView**)上！ 最后显示出来(**setContentView**)

------

## 2.Activity，Task和Back Stack的一些概念

接着我们来了解Android中Activity的管理机制，这就涉及到了两个名词：Task和Back Stack了！

**概念解析：**

我们的APP一般都是由多个Activity构成的，而在Android中给我们提供了一个**Task(任务)**的概念， 就是将多个相关的Activity收集起来，然后进行Activity的跳转与返回！当然，这个Task只是一个 frameworker层的概念，而在Android中实现了Task的数据结构就是**Back Stack（回退堆栈）**！ 相信大家对于栈这种数据结构并不陌生，Java中也有个Stack的集合类！栈具有如下特点：

> **后进先出(LIFO)，常用操作入栈(push)，出栈(pop)，处于最顶部的叫栈顶，最底部叫栈底**

而Android中的Stack Stack也具有上述特点，他是这样来管理Activity的：

> 当切换到新的Activity，那么该Activity会被压入栈中，成为栈顶！ 而当用户点击Back键，栈顶的Activity出栈，紧随其后的Activity来到栈顶！

我们来看下官方文档给出的一个流程图：

![img](https://www.runoob.com/wp-content/uploads/2015/08/93537362.jpg)

**流程解析：**

应用程序中存在A1,A2,A3三个activity，当用户在Launcher或Home Screen点击应用程序图标时， 启动主A1，接着A1开启A2，A2开启A3，这时栈中有三个Activity，并且这三个Activity默认在 同一个任务（Task）中，当用户按返回时，弹出A3，栈中只剩A1和A2，再按返回键， 弹出A2，栈中只剩A1，再继续按返回键，弹出A1，任务被移除，即程序退出！

接着在官方文档中又看到了另外两个图，处于好奇，我又看了下解释，然后跟群里的人讨论了下：

![img](https://www.runoob.com/wp-content/uploads/2015/08/76132682.jpg) ![img](https://www.runoob.com/wp-content/uploads/2015/08/2159561.jpg)

然后还有这段解释：

![img](https://www.runoob.com/wp-content/uploads/2015/08/94874923.jpg)

**然后总结下了结论：**

> Task是Activity的集合，是一个概念，实际使用的Back Stack来存储Activity，可以有多个Task，但是 同一时刻只有一个栈在最前面，其他的都在后台！那栈是如何产生的呢？
>
> 答：当我们通过主屏幕，点击图标打开一个新的App，此时会创建一个新的Task！举个例子：
> 我们通过点击通信录APP的图标打开APP，这个时候会新建一个栈1，然后开始把新产生的Activity添加进来，可能我们在通讯录的APP中打开了短信APP的页面，但是此时不会新建一个栈，而是继续添加到栈1中，这是 Android推崇一种用户体验方式，即不同应用程序之间的切换能使用户感觉就像是同一个应用程序， 很连贯的用户体验，官方称其为seamless (无缝衔接）！ ——————这个时候假如我们点击Home键，回到主屏幕，此时栈1进入后台，我们可能有下述两种操作：
> 1）点击菜单键(正方形那个按钮)，点击打开刚刚的程序，然后栈1又回到前台了！ 又或者我们点击主屏幕上通信录的图标，打开APP，此时也不会创建新的栈，栈1回到前台！
> 2）如果此时我们点击另一个图标打开一个新的APP，那么此时则会创建一个新的栈2，栈2就会到前台， 而栈1继续呆在后台；
> 3) 后面也是这样...以此类推！

------

## 3.Task的管理

**1）文档翻译：**

从文档中的ManagingTasks开始，翻译如下：

> 如上面所述，Android会将新成功启动的Activity添加到同一个Task中并且按照以"先进先出"方式管理多个Task 和Back Stack，用户就无需去担心Activites如何与Task任务进行交互又或者它们是如何存在于Back Stack中！ 或许，你想改变这种正常的管理方式。比如，你希望你的某个Activity能够在一个新的Task中进行管理； 或者你只想对某个Activity进行实例化，又或者你想在用户离开任务时清理Task中除了根Activity所有Activities。你可以做这些事或者更多，只需要通过修改AndroidManifest.xml中 < activity >的相关属性值或者在代码中通过传递特殊标识的Intent给startActivity( )就可以轻松的实现 对Actvitiy的管理了。

**< activity >中我们可以使用的属性如下：**

> - **taskAffinity**
> - **launchMode**
> - **allowTaskReparenting**
> - **clearTaskOnLaunch**
> - **alwaysRetainTaskState**
> - **finishOnTaskLaunch**

**你能用的主要的Intent标志有：**

> - **FLAG_ACTIVITY_NEW_TASK**
> - **FLAG_ACTIVITY_CLEAR_TOP**
> - **FLAG_ACTIVITY_SINGLE_TOP**

**2）taskAffinity和allowTaskReparenting**

默认情况下，一个应用程序中的**所有activity都有一个Affinity**，这让它们属于同一个Task。 你可以理解为是否处于同一个Task的标志，然而，每个Activity可以通过 < activity>中的taskAffinity属性设置单独的Affinity。 不同应用程序中的Activity可以共享同一个Affinity，同一个应用程序中的不同Activity 也可以设置成不同的Affinity。 Affinity属性在2种情况下起作用：

> 1）当启动 activity的Intent对象包含**FLAG_ACTIVITY_NEW_TASK**标记： 当传递给startActivity()的Intent对象包含 FLAG_ACTIVITY_NEW_TASK标记时，系统会为需要启动的Activity寻找与当前Activity不同Task。如果要启动的 Activity的Affinity属性与当前所有的Task的Affinity属性都不相同，系统会新建一个带那个Affinity属性的Task，并将要启动的Activity压到新建的Task栈中；否则将Activity压入那个Affinity属性相同的栈中。
>
> 2）**allowTaskReparenting**属性设置为true 如果一个activity的allowTaskReparenting属性为true， 那么它可以从一个Task（Task1）移到另外一个有相同Affinity的Task（Task2）中（Task2带到前台时）。 如果一个.apk文件从用户角度来看包含了多个"应用程序"，你可能需要对那些 Activity赋不同的Affinity值。

------

3）**launchMode**：

四个可选值，启动模式我们研究的核心，下面再详细讲! 他们分别是：**standard**(默认)，**singleTop**，**singleTask**，**singleInstance**

------

**4）清空栈**

> 当用户长时间离开Task（当前task被转移到后台）时，系统会清除task中栈底Activity外的所有Activity 。这样，当用户返回到Task时，只留下那个task最初始的Activity了。我们可以通过修改下面这些属性来 改变这种行为！
>
> **alwaysRetainTaskState**： 如果栈底Activity的这个属性被设置为true，上述的情况就不会发生。 Task中的所有activity将被长时间保存。
>
> **clearTaskOnLaunch** 如果栈底activity的这个属性被设置为true，一旦用户离开Task， 则 Task栈中的Activity将被清空到只剩下栈底activity。这种情况刚好与 alwaysRetainTaskState相反。即使用户只是短暂地离开，task也会返回到初始状态 （只剩下栈底acitivty）。
>
> **finishOnTaskLaunch** 与clearTaskOnLaunch相似，但它只对单独的activity操 作，而不是整个Task。它可以结束任何Activity，包括栈底的Activity。 当它设置为true时，当前的Activity只在当前会话期间作为Task的一部分存在， 当用户退出Activity再返回时，它将不存在。

------

## 4.Activity的四种加载模式详解：

接下来我们来详细地讲解下四种加载模式： 他们分别是：**standard**(默认)，**singleTop**，**singleTask**，**singleInstance** 

![img](https://www.runoob.com/wp-content/uploads/2015/08/50179298.jpg)

**模式详解：**

------

**standard模式：**

标准启动模式，也是activity的默认启动模式。在这种模式下启动的activity可以被多次实例化，即在同一个任务中可以存在多个activity的实例，每个实例都会处理一个Intent对象。如果Activity A的启动模式为standard，并且A已经启动，在A中再次启动Activity A，即调用startActivity（new Intent（this，A.class）），会在A的上面再次启动一个A的实例，即当前的桟中的状态为A-->A

**singleTop模式：**

如果一个以singleTop模式启动的Activity的实例已经存在于任务栈的栈顶， 那么再启动这个Activity时，不会创建新的实例，而是重用位于栈顶的那个实例， 并且会调用该实例的**onNewIntent()**方法将Intent对象传递到这个实例中。 举例来说，如果A的启动模式为singleTop，并且A的一个实例已经存在于栈顶中， 那么再调用startActivity（new Intent（this，A.class））启动A时， 不会再次创建A的实例，而是重用原来的实例，并且调用原来实例的onNewIntent()方法。 这时任务栈中还是这有一个A的实例。如果以singleTop模式启动的activity的一个实例 已经存在与任务栈中，但是不在栈顶，那么它的行为和standard模式相同，也会创建多个实例。

**singleTask模式：**

只允许在系统中有一个Activity实例。如果系统中已经有了一个实例， 持有这个实例的任务将移动到顶部，同时intent将被通过onNewIntent()发送。 如果没有，则会创建一个新的Activity并置放在合适的任务中。

官方文档中提到的一个问题：

> 系统会创建一个新的任务，并将这个Activity实例化为新任务的根部（root） 这个则需要我们对taskAffinity进行设置了，使用taskAffinity后的解雇：

**singleInstance模式**

保证系统无论从哪个Task启动Activity都只会创建一个Activity实例,并将它加入新的Task栈顶 也就是说被该实例启动的其他activity会自动运行于另一个Task中。 当再次启动该activity的实例时，会重用已存在的任务和实例。并且会调用这个实例 的onNewIntent()方法，将Intent实例传递到该实例中。和singleTask相同， 同一时刻在系统中只会存在一个这样的Activity实例。

------

## 5.Activity拾遗

**开源中国客户端Activity管理类：**

```java
package net.oschina.app;

import java.util.Stack;

import android.app.Activity;
import android.app.ActivityManager;
import android.content.Context;


public class AppManager {
    
    private static Stack<Activity> activityStack;
    private static AppManager instance;
    
    private AppManager(){}
    /**
     * 单一实例
     */
    public static AppManager getAppManager(){
        if(instance==null){
            instance=new AppManager();
        }
        return instance;
    }
    /**
     * 添加Activity到堆栈
     */
    public void addActivity(Activity activity){
        if(activityStack==null){
            activityStack=new Stack<Activity>();
        }
        activityStack.add(activity);
    }
    /**
     * 获取当前Activity（堆栈中最后一个压入的）
     */
    public Activity currentActivity(){
        Activity activity=activityStack.lastElement();
        return activity;
    }
    /**
     * 结束当前Activity（堆栈中最后一个压入的）
     */
    public void finishActivity(){
        Activity activity=activityStack.lastElement();
        finishActivity(activity);
    }
    /**
     * 结束指定的Activity
     */
    public void finishActivity(Activity activity){
        if(activity!=null){
            activityStack.remove(activity);
            activity.finish();
            activity=null;
        }
    }
    /**
     * 结束指定类名的Activity
     */
    public void finishActivity(Class<?> cls){
        for (Activity activity : activityStack) {
            if(activity.getClass().equals(cls) ){
                finishActivity(activity);
            }
        }
    }
    /**
     * 结束所有Activity
     */
    public void finishAllActivity(){
        for (int i = 0, size = activityStack.size(); i < size; i++){
            if (null != activityStack.get(i)){
                activityStack.get(i).finish();
            }
        }
        activityStack.clear();
    }
    /**
     * 退出应用程序
     */
    public void AppExit(Context context) {
        try {
            finishAllActivity();
            ActivityManager activityMgr= (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
            activityMgr.restartPackage(context.getPackageName());
            System.exit(0);
        } catch (Exception e) {    }
    }
}
```

------



> - 按Home键，将之前的Task切换到后台
> - 长按Home键，会显示出最近执行过的Task列表
> - 在Launcher或HomeScreen点击app图标，开启一个新Task，或者是将已有的Task调度到前台
> - 启动singleTask模式的Activity时，会在系统中搜寻是否已经存在一个合适的Task，若存在，则会将这个Task调度到前台以重用这个Task。如果这个Task中已经存在一个要启动的Activity的实例，则清除这个实例之上的所有Activity，将这个实例显示给用户。如果这个已存在的Task中不存在一个要启动的Activity的实例，则在这个Task的顶端启动一个实例。若这个Task不存在，则会启动一个新的Task，在这个新的Task中启动这个singleTask模式的Activity的一个实例。
> - 启动singleInstance的Activity时，会在系统中搜寻是否已经存在一个这个Activity的实例，如果存在，会将这个实例所在的Task调度到前台，重用这个Activity的实例（该Task中只有这一个Activity），如果不存在，会开启一个新任务，并在这个新Task中启动这个singleInstance模式的Activity的一个实例。