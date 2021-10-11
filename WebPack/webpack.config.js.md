```js
const path = require('path'); //node内置  引入命令  实际上是个构造函数
// __dirname表示当前文件的绝对路径
const HtmlWebpackPlugin = require('html-webpack-plugin');
const {CleanWebpackPlugin} = require('clean-webpack-plugin'); //清除每次出口文件夹内部多余文件所引入的插件
const VueLoaderPlugin = require('vue-loader/lib/plugin');
/*
* 使用commenjs模块化语法
*向外暴露一个配置对象
* */

function resolve(dir) {
    //返回指定项目根目录下文件的绝对路径
    return path.resolve(__dirname, dir)
}
module.exports = {
    // //指定模式  在package.js中已经设置过了
    // mode:'development',

    //入口  字符串或者对象
    /*
    * entry:{
    * app:'./src/index.js'
    * }
    *output: {
            path: path.resolve(__dirname, 'dist'), //dist绝对路径
            filename: "[name].bundle.js",   //[name].是占位符自动显示entry内部的键值，此处为app
        },
    *
    * */
    entry: './src/index.js',

    //出口   必须为对象
    output: {
        path: resolve( 'dist'), //dist绝对路径
        filename: "static/js/[name].bundle.js",
    },

    //模块加载器   必须为对象

    module: {
        rules: [//内部配置loader
            //配置的babel-loader,将es6==》es5
            {
                test: /\.js$/,  //匹配处理文件  此处为处理js文件
                // exclude: /(node_modules|bower_components)/,  //排除哪些文件夹的文件
                include: [resolve('src')],   //指定处理哪些文件夹的文件
                use: {
                    loader: 'babel-loader',  //指定loader
                    options: {
                        presets: ['@babel/preset-env'], //配置预设包（大包里面的小包）
                        // plugins:[
                        //     //内部配设预设包之外的包
                        // ]
                    }
                }
            },
            //处理css
            {
                test: /\.css$/,
                //css-loader将css文件打包到js中
                //style-loader将js中的css转移到页面中的style标签中
                use:['vue-style-loader', 'css-loader'] //loader处理文件是从右向左，从下向上
            },

            //处理图片文件
            {
                test: /\.png|jpe?g|gif|svg/,
                loader: 'url-loader',  //单个loader可以这么写  会进行小图片的base64处理  内部也使用file-loader
                // loader: 'file-loader',  //不会进行小图片的base64处理
                options: {
                    limit: 10 * 1024,  //小于10k的图片进行base64处理
                    name:'[name].[hash:7].[ext]'   //相对于output.path
                }

            },
            {
                test: /\.vue$/,
                loader: 'vue-loader'
            }
        ]
    },

    //插件  为array
    plugins: [
        new HtmlWebpackPlugin({
            //指定模板(打包的基础，因为不想丢失index.html里面的内容)
            template: "index.html" //在执行命令的目录下找
        }),
        new CleanWebpackPlugin(),  //插件的使用
        new VueLoaderPlugin(),


    ],

    //开发服务器配置
    devServer: {
        open: true,  //是否自动打开浏览器运行
        quiet: false,  //修改log产生数目
        port: 8080  //修改端口号
    },

    //模块引入时的解析
    resolve: {
        alias: { //模块路径别名，简化路径编写，加快文件打包（提前定位了）
            '@': resolve('src')  //表示@符以后就代表了src的绝对路径
        },
        extensions: ['.js', '.vue', ]   //指定某些模块名后缀可以省略，在引入时自己来依次找后缀
    }
}
```

## TypeScript打包

### webpack整合

通常情况下，实际开发中我们都需要使用构建工具对代码进行打包；

TS同样也可以结合构建工具一起使用，下边以webpack为例介绍一下如何结合构建工具使用TS；

步骤如下：

#### 初始化项目

进入项目根目录，执行命令 `npm init -y`，创建package.json文件

#### 下载构建工具

命令如下：

```
npm i -D webpack webpack-cli webpack-dev-server typescript ts-loader clean-webpack-plugin
```

共安装了7个包:

- webpack：构建工具webpack
- webpack-cli：webpack的命令行工具
- webpack-dev-server：webpack的开发服务器
- typescript：ts编译器
- ts-loader：ts加载器，用于在webpack中编译ts文件
- html-webpack-plugin：webpack中html插件，用来自动创建html文件
- clean-webpack-plugin：webpack中的清除插件，每次构建都会先清除目录

#### 配置webpack

根目录下创建webpack的配置文件`webpack.config.js`：

```
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const { CleanWebpackPlugin } = require("clean-webpack-plugin");

module.exports = {
   optimization:{
       minimize: false // 关闭代码压缩，可选
   },

   entry: "./src/index.ts",

   devtool: "inline-source-map",

   devServer: {
       contentBase: './dist'
   },

   output: {
       path: path.resolve(__dirname, "dist"),
       filename: "bundle.js",
       environment: {
           arrowFunction: false // 关闭webpack的箭头函数，可选
       }
   },

   resolve: {
       extensions: [".ts", ".js"]
   },

   module: {
       rules: [
           {
               test: /\.ts$/,
               use: {
                   loader: "ts-loader"     
               },
               exclude: /node_modules/
           }
       ]
   },

   plugins: [
       new CleanWebpackPlugin(),
       new HtmlWebpackPlugin({
           title:'TS测试'
       }),
   ]
}
```

#### 配置TS编译选项

根目录下创建tsconfig.json，配置可以根据自己需要

```
{
   "compilerOptions": {
       "target": "ES2015",
       "module": "ES2015",
       "strict": true
   }
}
```

#### 修改package.json配置

修改package.json添加如下配置

```
{
   ...
   "scripts": {
       "test": "echo \"Error: no test specified\" && exit 1",
       "build": "webpack",
       "start": "webpack serve --open chrome.exe"
   },
   ...
}
```

#### 项目使用

在src下创建ts文件，并在并命令行执行`npm run build`对代码进行编译；

或者执行`npm start`来启动开发服务器；



### Babel

除了webpack，开发中还经常需要结合babel来对代码进行转换；

以使其可以兼容到更多的浏览器，在上述步骤的基础上，通过以下步骤再将babel引入到项目中；

> 虽然TS在编译时也支持代码转换，但是只支持简单的代码转换；
>
> 对于例如：Promise等ES6特性，TS无法直接转换，这时还要用到babel来做转换；

安装依赖包：

```
npm i -D @babel/core @babel/preset-env babel-loader core-js
```

共安装了4个包，分别是：

- @babel/core：babel的核心工具
- @babel/preset-env：babel的预定义环境
- @babel-loader：babel在webpack中的加载器
- core-js：core-js用来使老版本的浏览器支持新版ES语法

修改webpack.config.js配置文件

```
...
module: {
    rules: [
        {
            test: /\.ts$/,
            use: [
                {
                    loader: "babel-loader",
                    options:{
                        presets: [
                            [
                                "@babel/preset-env",
                                {
                                    "targets":{
                                        "chrome": "58",
                                        "ie": "11"
                                    },
                                    "corejs":"3",
                                    "useBuiltIns": "usage"
                                }
                            ]
                        ]
                    }
                },
                {
                    loader: "ts-loader",

                }
            ],
            exclude: /node_modules/
        }
    ]
}
...
```

如此一来，使用ts编译后的文件将会再次被babel处理；

使得代码可以在大部分浏览器中直接使用；

同时可以在配置选项的targets中指定要兼容的浏览器版本；
