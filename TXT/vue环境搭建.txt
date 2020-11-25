const path = require('path') //node内置  引入命令  实际上是个构造函数
// __dirname表示当前文件的绝对路径
const HtmlWebpackPlugin = require('html-webpack-plugin')
const {CleanWebpackPlugin} = require('clean-webpack-plugin'); //清除每次出口文件夹内部多余文件所引入的插件
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
        path: resolve('dist'), //dist绝对路径
        filename: "bundle.js",
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
                use:['style-loader', 'css-loader'] //loader处理文件是从右向左，从下向上
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

            }
        ]
    },

    //插件  为array
    plugins: [
        new HtmlWebpackPlugin({
            //指定模板
            template: "index.html" //在执行命令的目录下找
        }),
        new CleanWebpackPlugin(),  //插件的使用


    ],

    //开发服务器
    devServer: {
        open: true,  //是否自动打开浏览器运行
        quiet: true,  //修改log产生数目
        port: 8081  //修改端口号
    }
}