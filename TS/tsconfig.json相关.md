```ts
tsc 文件名.ts -w   // w表示watch的意思，监视文件改变，自动在改变的时候进行重新编译
tsc -w // 加入tsconfig.json文件，监视文件夹下所有文档改变
```

```json
{
    // 指定需要编译的文件路径
    "include": ["./*"],
    // 指定不需要编译的文件路径
    // "exclude": ["文件路径"],
    // 定义被继承的配置文件
    // "extends": "",
    // 直接指定需要编译的文件
    "files": ["hello.ts",],
    // 编译器选项
    "compilerOptions": {
        // 编译的目标js语法版本
        // 'es3', 'es5', 'es6', 'es2015', 'es2016', 'es2017', 'es2018', 'es2019', 'es2020', 'es2021', 'esnext'.
        "target": "es6",
        // 模块化规范 
        // 'none', 'commonjs', 'amd', 'system', 'umd', 'es6', 'es2015', 'es2020', 'esnext'.
        "module": "es6",
        // 指定项目中的库，一般情况不需要动， 内部有默认值
        // "lib": []
        // 输出js文件路径
        "outDir": "./dist",
        // 输出的文件,就是将作用域中的多个文件合并到一个文件编译输出
        "outFile": "./dist/app.js",
        // 是否包括js文件，默认是false
        "allowJs": false,
        // 是否在js代码中使用ts语法进行检查，默认为false
        "checkJs": false,
        // 是否编译注释
        "removeComments": true,
        // 是否生成编译后的文件
        "noEmit": false,
        // 是否在有错误的时候生产编译后的文件
        "noEmitOnError": true,

        // 严格检查的总开关
        "strict": true,
        // 在编译后的js代码是否使用严格模式
        "alwaysStrict": false,
        // 没有添加类型时，编译器自动将类型设置为any，此选项是此时编译是否报错
        // 即是否允许隐式any
        "noImplicitAny": false,
        // 是否允许不明确类型的this
        "noImplicitThis": false,
        // 是否严格的检查空值
        "strictNullChecks": false,

    }
}
```

