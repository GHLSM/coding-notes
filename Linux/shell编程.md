## SHELL编程

## shell的分类

bash、ash、ksh、csh等

---

## bash

bash-complete	自动补全程序（好像已经自带了）

### 命令历史记录

历史命令是保存在``.bash_history``隐藏文件中的

命令：``history``

- 数字	显示最近的几条命令
- -d n     删除第n条历史

命令：``!某一条历史记录编号``重新运行该编号的程序

- !-n     执行倒数第几条命令
- !!        执行最后一天命令

### bash环境文件

| 文件                          | 描述                                 | 图形界面 | 文本界面 | su -l | su   |
| ----------------------------- | ------------------------------------ | -------- | -------- | ----- | ---- |
| /etc/profile                  | 全局配置，所有用户登陆的时候都会读取 | 1        | 2        | 2     |      |
| /etc/bashrc(/etc/bash.bashrc) | 全局配置文件，bash执行的时候读取     | 3        | 1        | 1     | 1    |
| ~/.profile                    |                                      | 2        |          |       |      |
| ~/.bash_login                 |                                      |          |          |       |      |
| ~/.bash_profile               |                                      |          | 3        | 3     |      |
| ~/.bashrc                     |                                      | 4        |          |       | 2    |
| ~/.bash_logout                |                                      |          |          |       |      |

### bash特性



### bash风格规范

### bash注释

---

## shell脚本运行

命令：``[sh、bash] [参数] 脚本文件``

- -n      不要执行script，仅检查语法的问题
- -v      在执行script之前，先将script的内容显示到屏幕上
- -x      将使用的脚本的内容一步一步输出到屏幕上

#### 脚本运行的其他方式

首先==脚本必须要有执行权限==，否则无法执行

``绝对路径、相对路径``

`` . 脚本``

``source 脚本``

```pwd` 脚本``

### 进程脱机管理

对进程切换到后台可以避免由于误操作导致的job被异常中断的情况，脱机管理主要是针对终端异常断开的情景

通常使用nohup命令来使得脱机或注销之后，job可以继续运行，也就是说，nohup忽略所有挂断信号（SIGHUP）

通常该方式命令之后未指定&符号，则job位于前台，否则位于后台

```shell
# 使用nohup案例，省略日志输出，原job的输出会自己重定向到缺省的nohup.out文件
nohup ./echo_time.sh

# 以下流程是直接断开连接，新建一个连接的端口之后
jobs  # 此命令此时无法看到任何进程
ps -ef | grep echo_time.sh  # 使用ps命令可以查看到进程
more nohup.out   #上述执行文件执行的日志输出会被重定向到nohup.out，通过more命令查看

# 改变运行文件方式，将job放入后台，且重定向文件输出日志
nohup ./echo_time.sh >temp2.log 2>&1 & 
```

### screen命令使用

---

## shell变量

### 整体变量类型

运行shell时，会同时存在三种变量：

- **局部变量** 
  - 局部变量在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量。
- **环境变量**
  - 所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。必要的时候shell脚本也可以定义环境变量。
- **shell变量**
  - shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行

#### 自定义变量（局部变量）

正常程序变量命名，``变量名=变量值``，==无空格==，变量名一般为大写

- ``echo $变量名`` 
- set      查看所有变量:包括自定义变量和环境变量
- 取消变量: unset 变量名
- 作用范围：当前shell中有效

变量值好像并不做区别，没有典型的数据类型限制，在定义变量时，只需要针对bash命令的情况做思考即可

```shell
"" '' ``
# 三这并不代表任何数据类型
```

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211208160000787.png" alt="image-20211208160000787" style="zoom:80%;" />



<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211208160301704.png" alt="image-20211208160301704" style="zoom:80%;" />

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211208162002146.png" alt="image-20211208162002146" style="zoom:80%;" />

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211208163219690.png" alt="image-20211208163219690" style="zoom:80%;" />

#### 只读变量（静态变量）

使用 readonly 命令可以将变量定义为只读变量，==只读变量的值不能被改变，也不能unset==。

下面的例子尝试更改只读变量，结果报错：

```shell
#!/bin/bash
myUrl="https://www.google.com"
readonly myUrl
myUrl="https://www.runoob.com"
```

运行脚本，结果如下：

```bash
/bin/sh: NAME: This variable is read only.
```

#### 环境变量

``/etc/配置文件``  配置文件内部的环境变量改变

除了配置文件定义的环境变量以外，也可以将一些自定义变量定义为环境变量

- ``export 自定义变量``=变量值		将shell变量输出为环境变量
- source 配置文件                               将修改后的配置文件立即生效
- ``echo $变量名``

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211208163539118.png" alt="image-20211208163539118" style="zoom:80%;" />



### 赋值

将命令的返回结果赋值给变量

==变量=\`命令`==

==let 变量=运算式==

### 变量内字符长度

命令：`${#变量名}`

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211208164903816.png" alt="image-20211208164903816" style="zoom:80%;" />

### 分隔符变量

`$IFS`

可以将分隔符改为其他的

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209121314529.png" alt="image-20211209121314529" style="zoom:80%;" />





---

## Shell 传递参数

我们可以在执行 Shell 脚本时，向脚本传递参数，脚本内获取参数的格式为：**``$n``**。**n** 代表一个数字，1 为执行脚本的第一个参数，2 为执行脚本的第二个参数，以此类推……

**echo** "Shell 传递参数实例！";
**echo** "执行的文件名：`$0`";

**echo** "第一个参数为：`$1`";

**echo** "第二个参数为：`$2`";

**echo** "第三个参数为：`$3`";

为脚本设置可执行权限，并执行脚本，输出结果如下所示：

```shell
$ chmod +x test.sh 
$ ./test.sh 1 2 3
Shell 传递参数实例！
执行的文件名：./test.sh
第一个参数为：1
第二个参数为：2
第三个参数为：3
```

另外，还有几个特殊字符用来处理参数：

| 参数处理 | 说明                                                         |
| :------- | :----------------------------------------------------------- |
| ``$#``   | 传递到脚本的参数个数                                         |
| ``$*``   | 以一个单字符串显示所有向脚本传递的参数。 如`$*`用「"」括起来的情况、以"`$1` `$2` … `$n`"的形式输出所有参数。 |
| ``$$``   | 脚本运行的当前进程ID号                                       |
| ``$!``   | 后台运行的最后一个进程的ID号                                 |
| `$?`     | 显示最后命令的返回值，如果是判断true或false，对应0和1        |
| ``$@``   | 与`$*`相同，但是使用时加引号，并在引号中返回每个参数。 如`$@`用「"」括起来的情况、以"`$1`" "`$2`" … "`$n`" 的形式输出所有参数。 |
| ``$-``   | 显示Shell使用的当前选项，与[set命令](https://www.runoob.com/linux/linux-comm-set.html)功能相同。 |

**echo** "Shell 传递参数实例！";
**echo** "第一个参数为：`$1`";

**echo** "参数个数为：`$#`";
**echo** "传递的参数作为一个字符串显示：`$*`";

执行脚本，输出结果如下所示：

```shell
$ chmod +x test.sh 
$ ./test.sh 1 2 3
Shell 传递参数实例！
第一个参数为：1
参数个数为：3
传递的参数作为一个字符串显示：1 2 3
```

$* 与 $@ 区别：

- 相同点：都是引用所有参数。
- 不同点：只有在双引号中体现出来。假设在脚本运行时写了三个参数 1、2、3，，则 " * " 等价于 "1 2 3"（传递了一个参数），而 "@" 等价于 "1" "2" "3"（传递了三个参数）。

实例

```shell
echo "-- \$* 演示 ---"
for i in "`$*`"; do
  echo $i
done

echo "-- \$@ 演示 ---"
for i in "`$@`"; do
  echo $i
done
```

执行脚本，输出结果如下所示：

```txt
$ chmod +x test.sh 
$ ./test.sh 1 2 3
-- $* 演示 ---
1 2 3
-- $@ 演示 ---
1
2
3
```

---

## Shell 基本运算符

Shell 和其他编程语言一样，支持多种运算符，包括：

- 算数运算符
- 关系运算符
- 布尔运算符
- 字符串运算符
- 文件测试运算符

原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如 awk 和 expr，expr 最常用。

expr 是一款表达式计算工具，使用它能完成表达式的求值操作。

例如，两个数相加(**注意使用的是反引号 ` 而不是单引号**)：

```shell
#!/bin/bash

val=`expr 2 + 2`
echo "两数之和为 : $val"
```

执行脚本，输出结果如下所示：

```
两数之和为 : 4
```

两点注意：

- ==表达式和运算符之间要有空格==，例如 2+2 是不对的，必须写成 2 + 2，这与我们熟悉的大多数编程语言不一样。
- 完整的表达式要被反引号包围

### 算术运算符

下表列出了常用的算术运算符，假定变量 a 为 10，变量 b 为 20：

| 运算符 | 说明                                        | 举例                         |
| :----- | :------------------------------------------ | :--------------------------- |
| +      | 加法                                        | `expr $a + $b` 结果为 30     |
| -      | 减法                                        | `expr $a - $b` 结果为 -10    |
| *      | 乘法                                        | `expr $a \* $b` 结果为  200  |
| /      | 除法                                        | `expr $b / $a` 结果为 2      |
| %      | 取余                                        | `expr $b % $a` 结果为 0      |
| =      | 赋值                                        | `a=$b `将把变量 b 的值赋给 a |
| ==     | 相等，用于比较两个数字，相同则返回 true     | `[ $a == $b ]` 返回 false    |
| !=     | 不相等，用于比较两个数字，不相同则返回 true | `[ $a != $b ] `返回 true     |

**注意：**==条件表达式要放在方括号之间，并且要有空格==，例如: [`$a`==`$b`] 是错误的，必须写成 [ `$a` == `$b` ]。

```shell
a=10
b=20

val=`expr $a + $b`
echo "a + b : $val"

val=`expr $a - $b`
echo "a - b : $val"

val=`expr $a \ $b`
echo "a  b : $val"

val=`expr $b / $a`
echo "b / a : $val"

val=`expr $b % $a`
echo "b % a : $val"

if [ $a == $b ]
then
  echo "a 等于 b"
fi
if [ $a != $b ]
then
  echo "a 不等于 b"
fi
```

执行脚本，输出结果如下所示：

```
a + b : 30
a - b : -10
a * b : 200
b / a : 2
b % a : 0
a 不等于 b
```

> **注意：**
>
> - 乘号(*)前边必须加反斜杠`\`才能实现乘法运算；
> - 在 MAC 中 shell 的 expr 语法是：**`$((表达式))`**，此处表达式中的 "*" 不需要转义符号 "`\`" 。

### 关系运算符

关系运算符只支持数字，不支持字符串，除非字符串的值是数字

下表列出了常用的关系运算符，假定变量 a 为 10，变量 b 为 20：

| 运算符 | 说明                                                | 举例                       |
| :----- | :-------------------------------------------------- | :------------------------- |
| -eq    | 检测两个数是否相等，相等返回 true                   | `[ $a -eq $b ] `返回 false |
| -ne    | 检测两个数是否不相等，不相等返回 true               | `[ $a -ne $b ] `返回 true  |
| -gt    | 检测左边的数是否大于右边的，如果是，则返回 true     | `[ $a -gt $b ] `返回 false |
| -lt    | 检测左边的数是否小于右边的，如果是，则返回 true     | `[ $a -lt $b ] `返回 true  |
| -ge    | 检测左边的数是否大于等于右边的，如果是，则返回 true | `[ $a -ge $b ] `返回 false |
| -le    | 检测左边的数是否小于等于右边的，如果是，则返回 true | `[ $a -le $b ] `返回 true  |

```shell
a=10
b=20

if [ $a -eq $b ]
then
  echo "$a -eq $b : a 等于 b"
else
  echo "$a -eq $b: a 不等于 b"
fi
if [ $a -ne $b ]
then
  echo "$a -ne $b: a 不等于 b"
else
  echo "$a -ne $b : a 等于 b"
fi
if [ $a -gt $b ]
then
  echo "$a -gt $b: a 大于 b"
else
  echo "$a -gt $b: a 不大于 b"
fi
if [ $a -lt $b ]
then
  echo "$a -lt $b: a 小于 b"
else
  echo "$a -lt $b: a 不小于 b"
fi
if [ $a -ge $b ]
then
  echo "$a -ge $b: a 大于或等于 b"
else
  echo "$a -ge $b: a 小于 b"
fi
if [ $a -le $b ]
then
  echo "$a -le $b: a 小于或等于 b"
else
  echo "$a -le $b: a 大于 b"
fi
```

执行脚本，输出结果如下所示：

```
10 -eq 20: a 不等于 b
10 -ne 20: a 不等于 b
10 -gt 20: a 不大于 b
10 -lt 20: a 小于 b
10 -ge 20: a 小于 b
10 -le 20: a 小于或等于 b
```

### 布尔运算符

下表列出了常用的布尔运算符，假定变量 a 为 10，变量 b 为 20：

| 运算符 | 说明                                              | 举例                                     |
| :----- | :------------------------------------------------ | :--------------------------------------- |
| !      | 非运算，表达式为 true 则返回 false，否则返回 true | `[ ! false ] `返回 true                  |
| -o     | 或运算，有一个表达式为 true 则返回 true           | `[ $a -lt 20 -o $b -gt 100 ]` 返回 true  |
| -a     | 与运算，两个表达式都为 true 才返回 true           | `[ $a -lt 20 -a $b -gt 100 ] `返回 false |

```shell
a=10
b=20

if [ $a != $b ]
then
  echo "$a != $b : a 不等于 b"
else
  echo "$a == $b: a 等于 b"
fi
if [ $a -lt 100 -a $b -gt 15 ]
then
  echo "$a 小于 100 且 $b 大于 15 : 返回 true"
else
  echo "$a 小于 100 且 $b 大于 15 : 返回 false"
fi
if [ $a -lt 100 -o $b -gt 100 ]
then
  echo "$a 小于 100 或 $b 大于 100 : 返回 true"
else
  echo "$a 小于 100 或 $b 大于 100 : 返回 false"
fi
if [ $a -lt 5 -o $b -gt 100 ]
then
  echo "$a 小于 5 或 $b 大于 100 : 返回 true"
else
  echo "$a 小于 5 或 $b 大于 100 : 返回 false"
fi
```

执行脚本，输出结果如下所示：

```
10 != 20 : a 不等于 b
10 小于 100 且 20 大于 15 : 返回 true
10 小于 100 或 20 大于 100 : 返回 true
10 小于 5 或 20 大于 100 : 返回 false
```

### 逻辑运算符

以下介绍 Shell 的逻辑运算符，假定变量 a 为 10，变量 b 为 20:

| 运算符 | 说明       | 举例                                        |
| :----- | :--------- | :------------------------------------------ |
| `&&`   | 逻辑的 AND | `[[ $a -lt 100 && $b -gt 100 ]] `返回 false |
| `||`   | 逻辑的 OR  | `[[ $a -lt 100 || $b -gt 100 ]]` 返回 true  |

```shell
a=10
b=20

if [[ $a -lt 100 && $b -gt 100 ]]
then
  echo "返回 true"
else
  echo "返回 false"
fi

if [[ $a -lt 100 || $b -gt 100 ]]
then
  echo "返回 true"
else
  echo "返回 false"
fi
```

执行脚本，输出结果如下所示：

```
返回 false
返回 true
```

### 字符串运算符

下表列出了常用的字符串运算符，假定变量 a 为 "abc"，变量 b 为 "efg"：

| 运算符 | 说明                                       | 举例                     |
| :----- | :----------------------------------------- | :----------------------- |
| `=`    | 检测两个字符串是否相等，相等返回 true      | `[ $a = $b ] `返回 false |
| `!=`   | 检测两个字符串是否不相等，不相等返回 true  | `[ $a != $b ]` 返回 true |
| `-z`   | 检测字符串长度是否为0，为0返回 true        | `[ -z $a ] `返回 false   |
| `-n`   | 检测字符串长度是否不为 0，不为 0 返回 true | `[ -n "$a" ] `返回 true  |
| `$`    | 检测字符串是否为空，不为空返回 true        | `[ $a ] `返回 true       |

```shell
a="abc"
b="efg"

if [ $a = $b ]
then
  echo "$a = $b : a 等于 b"
else
  echo "$a = $b: a 不等于 b"
fi
if [ $a != $b ]
then
  echo "$a != $b : a 不等于 b"
else
  echo "$a != $b: a 等于 b"
fi
if [ -z $a ]
then
  echo "-z $a : 字符串长度为 0"
else
  echo "-z $a : 字符串长度不为 0"
fi
if [ -n "$a" ]
then
  echo "-n $a : 字符串长度不为 0"
else
  echo "-n $a : 字符串长度为 0"
fi
if [ $a ]
then
  echo "$a : 字符串不为空"
else
  echo "$a : 字符串为空"
fi
```

执行脚本，输出结果如下所示：

```
abc = efg: a 不等于 b
abc != efg : a 不等于 b
-z abc : 字符串长度不为 0
-n abc : 字符串长度不为 0
abc : 字符串不为空
```

### 文件测试运算符

文件测试运算符用于检测 Unix 文件的各种属性。

属性检测描述如下：

| 操作符  | 说明                                                      | 举例                      |
| :------ | :-------------------------------------------------------- | :------------------------ |
| -b file | 检测文件是否是块设备文件，如果是，则返回 true             | `[ -b $file ] `返回 false |
| -c file | 检测文件是否是字符设备文件，如果是，则返回 true           | `[ -c $file ]` 返回 false |
| -d file | 检测文件是否是目录，如果是，则返回 true                   | `[ -d $file ]` 返回 false |
| -f file | 检测文件是否是普通文件（既不是目录，也不是设备文件）      | `[ -f $file ]` 返回 true  |
| -g file | 检测文件是否设置了 SGID 位，如果是，则返回 true           | `[ -g $file ] `返回 false |
| -k file | 检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true | `[ -k $file ] `返回 false |
| -p file | 检测文件是否是有名管道，如果是，则返回 true               | `[ -p $file ]` 返回 false |
| -u file | 检测文件是否设置了 SUID 位，如果是，则返回 true           | `[ -u $file ]` 返回 false |
| -r file | 检测文件是否可读，如果是，则返回 true                     | `[ -r $file ] `返回 true  |
| -w file | 检测文件是否可写，如果是，则返回 true                     | `[ -w $file ]` 返回 true  |
| -x file | 检测文件是否可执行，如果是，则返回 true                   | `[ -x $file ]` 返回 true  |
| -s file | 检测文件是否为空（文件大小是否大于0），不为空返回 true    | `[ -s $file ] `返回 true  |
| -e file | 检测文件（包括目录）是否存在，如果是，则返回 true         | `[ -e $file ] `返回 true  |

其他检查符：

- **-S**: 判断某文件是否 socket
- **-L**: 检测文件是否存在并且是一个符号链接

```shell
file="/var/www/runoob/test.sh"
if [ -r $file ]
then
  echo "文件可读"
else
  echo "文件不可读"
fi
if [ -w $file ]
then
  echo "文件可写"
else
  echo "文件不可写"
fi
if [ -x $file ]
then
  echo "文件可执行"
else
  echo "文件不可执行"
fi
if [ -f $file ]
then
  echo "文件为普通文件"
else
  echo "文件为特殊文件"
fi
if [ -d $file ]
then
  echo "文件是个目录"
else
  echo "文件不是个目录"
fi
if [ -s $file ]
then
  echo "文件不为空"
else
  echo "文件为空"
fi
if [ -e $file ]
then
  echo "文件存在"
else
  echo "文件不存在"
fi
```

执行脚本，输出结果如下所示：

```
文件可读
文件可写
文件可执行
文件为普通文件
文件不是个目录
文件不为空
文件存在
```

## Shell 流程控制

和 Java、PHP 等语言不一样，==sh 的流程控制不可为空==，如(以下为 PHP 流程控制写法)：

### 条件语句

#### 简单if

if 语句语法格式：

```shell
if condition
then
    command1 
    command2
    ...
    commandN 
fi
```

写成一行（适用于终端命令提示符）：

```shell
if [ $(ps -ef | grep -c "ssh") -gt 1 ]; then echo "true"; fi
```

末尾的 fi 就是 if 倒过来拼写，后面还会遇到类似的

#### if else

if else 语法格式：

```shell
if condition
then
    command1 
    command2
    ...
    commandN
else
    command
fi
```

#### if else-if else

if else-if else 语法格式：

```shell
if condition1
then
    command1
elif condition2 
then 
    command2
else
    commandN
fi
```

```shell
a=10
b=20
if [ $a == $b ]
then
  echo "a 等于 b"
elif [ $a -gt $b ]
then
  echo "a 大于 b"
elif [ $a -lt $b ]
then
  echo "a 小于 b"
else
  echo "没有符合的条件"
fi
```

输出结果：

```
a 小于 b
```

if else 语句经常与 test 命令结合使用，如下所示：

```shell
num1=$[23]
num2=$[1+5]
if test $[num1] -eq $[num2]
then
  echo '两个数字相等!'
else
  echo '两个数字不相等!'
fi
```

输出结果：

```
两个数字相等!
```

#### case ... esac

**case ... esac** 为多选择语句，与其他语言中的 switch ... case 语句类似，是一种多分枝选择结构，每个 case 分支用右圆括号开始，用两个分号` ;; `表示 break，即执行结束，跳出整个 case ... esac 语句，esac（就是 case 反过来）作为结束标记

可以用 case 语句匹配一个值与一个模式，如果匹配成功，执行相匹配的命令

**case ... esac** 语法格式如下：

```shell
case 值 in
模式1)
    command1
    command2
    ...
    commandN
    ;;
模式2)
    command1
    command2
    ...
    commandN
    ;;
esac
```

case 工作方式如上所示，取值后面必须为单词 **in**，每一模式必须以右括号结束。取值可以为变量或常数，匹配发现取值符合某一模式后，其间所有命令开始执行直至 **`;;`**。

取值将检测匹配的每一个模式。一旦模式匹配，则执行完匹配模式相应命令后不再继续其他模式。如果无一匹配模式，使用星号 `*` 捕获该值，再执行后面的命令。

下面的脚本提示输入 1 到 4，与每一种模式进行匹配：

```shell
echo '输入 1 到 4 之间的数字:'
echo '你输入的数字为:'
read aNum
case $aNum in
  1) echo '你选择了 1'
  ;;
  2) echo '你选择了 2'
  ;;
  3) echo '你选择了 3'
  ;;
  4) echo '你选择了 4'
  ;;
  *) echo '你没有输入 1 到 4 之间的数字'
  ;;
esac
```

输入不同的内容，会有不同的结果，例如：

```
输入 1 到 4 之间的数字:
你输入的数字为:
3
你选择了 3
```

下面的脚本匹配字符串：

```shell
#!/bin/sh

site="gh"

case "$site" in
  "gh") echo "gh"
  ;;
  "google") echo "Google 搜索"
  ;;
  "taobao") echo "淘宝网"
  ;;
esac
```

输出结果为：

```
gh
```

### 循环

#### for 循环

for循环在输入为文件时，比如``for i in `cat a.txt`是以文件中的空格和回车截断的``

for循环一般格式为：

```shell
for var in item1 item2 ... itemN
do
    command1
    command2
    ...
    commandN
done
```

写成一行：

```shell
for var in item1 item2 ... itemN; do command1; command2… done;
```

当变量值在列表里，for 循环即执行一次所有命令，使用变量名获取列表中的当前取值。命令可为任何有效的 shell 命令和语句。in 列表可以包含替换、字符串和文件名。

in列表是可选的，如果不用它，for循环使用命令行的位置参数。

例如，顺序输出当前列表中的数字：

```shell
for loop in 1 2 3 4 5
do
  echo "The value is: $loop"
done
```

输出结果：

```
The value is: 1
The value is: 2
The value is: 3
The value is: 4
The value is: 5
```

顺序输出字符串中的字符：

```shell
#!/bin/bash

for str in This is a string
do
    echo $str
done
```

输出结果：

```
This
is
a
string
```

#### while 循环

while 循环用于不断执行一系列命令，也用于从输入文件中读取数据。从输入文件取数据时，以文件内的==回车作为分隔==。

其语法格式为：

```shell
while condition
do
    command
done
```

以下是一个基本的 while 循环，测试条件是：如果 int 小于等于 5，那么条件返回真。int 从 1 开始，每次循环处理时，int 加 1。运行上述脚本，返回数字 1 到 5，然后终止。

```shell
#!/bin/bash
int=1
while(( $int<=5 ))
do
  echo $int
  let "int++"
done
```

运行脚本，输出：

```
1
2
3
4
5
```

以上实例使用了 Bash let 命令，它用于执行一个或多个表达式，变量计算中不需要加上 $ 来表示变量

while循环可用于读取键盘信息。下面的例子中，输入信息被设置为变量FILM，按<Ctrl-D>结束循环。

```shell
echo '按下 <CTRL-D> 退出'
echo -n '输入你最喜欢的网站名: '
while read FILM
do
  echo "是的！$FILM 是一个好网站"
done
```

运行脚本，输出类似下面：

```
按下 <CTRL-D> 退出
输入你最喜欢的网站名:www.gh.com
是的！www.gh.com 是一个好网站
```

#### 无限循环

无限循环语法格式：

```shell
while :
do
    command
done
```

或者

```shell
while true
do
    command
done
```

或者

```shell
for (( ; ; ))
```

#### until 循环

until 循环执行一系列命令直至条件为 true 时停止

until 循环与 while 循环在处理方式上刚好相反

一般 while 循环优于 until 循环，但在某些时候—也只是极少数情况下，until 循环更加有用

until 语法格式:

```shell
until condition
do
    command
done
```

condition 一般为条件表达式，如果返回值为 false，则继续执行循环体内的语句，否则跳出循环

以下实例我们使用 until 命令来输出 0 ~ 9 的数字：

```shell
#!/bin/bash
a=0
until [ ! $a -lt 10 ]
do
  echo $a
  a=`expr $a + 1`
done
```

输出结果为：

```
0
1
2
3
4
5
6
7
8
9
```

### 跳出循环

#### exit

退出整个程序

#### break

break命令允许跳出所有循环（终止执行后面的所有循环）

```shell
#!/bin/bash
while :
do
  echo -n "输入 1 到 5 之间的数字:"
  read aNum
  case $aNum in
    1|2|3|4|5) echo "你输入的数字为 $aNum!"
    ;;
    ) echo "你输入的数字不是 1 到 5 之间的! 游戏结束"
      break
    ;;
  esac
done
```

执行以上代码，输出结果为：

```
输入 1 到 5 之间的数字:3
你输入的数字为 3!
输入 1 到 5 之间的数字:7
你输入的数字不是 1 到 5 之间的! 游戏结束
```

#### continue

continue命令与break命令类似，只有一点差别，它不会跳出所有循环，仅仅跳出当前循环

```shell
#!/bin/bash
while :
do
  echo -n "输入 1 到 5 之间的数字: "
  read aNum
  case $aNum in
    1|2|3|4|5) echo "你输入的数字为 $aNum!"
    ;;
    ) echo "你输入的数字不是 1 到 5 之间的!"
      continue
      echo "游戏结束"
    ;;
  esac
done
```

运行代码发现，当输入大于5的数字时，该例中的循环不会结束，语句 **echo "游戏结束"** 永远不会被执行

## shell的expect程序

帮助和机器交互的程序，内部问什么即答什么。没有则需要安装，文件扩展为`.exp`

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209090237817.png" alt="image-20211209090237817" style="zoom:80%;" />

| set timeout num | 设置超时时间num |
| --------------- | --------------- |
| expect eof      | 退出            |

## shell数组

### declare -a

查看系统定义的所有数组

### 普通数组

索引为数字，索引值可以更改，定义及使用

```shell
# array=([0]=1 [1]=2 [2]=3 [3]=4 [4]=5)
array=(1 2 3 4 5)
echo ${array}										# 1
echo ${array[2]}								# 3
echo ${array:0:2}								# 1 2	# 初始值:个数
echo ${array:2}									# 3 4 5	# 初始值到最后
echo ${array[@]:3}							# 从第三个打印到最后
echo ${array[*]}								# 1 2 3 4 5
echo ${!array[*]}								# 0 1 2 3 4		#索引



# 定义扩展
array=(`cat ip.txt`)
array=(wode nide "shei de")		# “”已就位弱引用，去除空格的截断含义
array=($var1 $var2)						# 可以变量

array[0]=pear
array[1]=apple
echo ${array[*]}								# pear apple
echo ${array[@]}								# 也是打印数组内所有元素
```

### 关联数组

索引为字符型的数组，定义及使用，有点像是字典

```shell
# 定义关联数组需要声明，定义语法和普通数组一样，只有索引改变
declare -A position
position=([up]=1 [center]=2 [down]=3)
echo ${position[up]}		# 1

# 分别定义
position[index1]=pear
position[index2]=apple
```







## shell函数

### 系统函数

#### basename

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211208141905449.png" alt="image-20211208141905449" style="zoom:80%;" />

不会判断文件是否存在，只是将最后的路径（文件名或文件夹名）提取出来

- 接后缀，会自动将后缀给隐藏掉

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211208142108490.png" alt="image-20211208142108490" style="zoom:80%;" />

#### dirname

获取文件夹路径，不考虑文件夹是否存在

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211208142230762.png" alt="image-20211208142230762" style="zoom:80%;" />

### 自定义函数

定义，==function可以不写，无形参，直接传入参数，内部使用`$系列`接受==

```shell
# 定义
function funcname(){
	command
	command
	$1...
	$2...
}

# 调用及传参
funcname $1 $2
funcname $3 $4
```

#### 无参

```shell
demoFun(){
    echo "这是我的第一个 shell 函数!"
}
echo "-----函数开始执行-----"
demoFun
echo "-----函数执行完毕-----"
```

#### 有参

```shell
function cal(){
	NUM1=$1
	NUM2=$2
	SUM=$[$NUM1+$NUM2]
	echo "num plus is $SUM"
}
cal $1 $2
```

### 特殊

| break -n | n默认为1指跳出一层循环                   |
| -------- | ---------------------------------------- |
| shift    | 参数左移，指`$1消失，$2变成$1，以此类推` |

---

## shell文本处理三剑客

### 正则表达式

两个/中间的字段即是正则表达式

| `^`             | 行首定位符 (以什么开始)                                      |
| :-------------- | ------------------------------------------------------------ |
| `[Ow]`          | O或w                                                         |
| `*`             | 匹配前导0或多次                                              |
| `+`             | 匹配一个或多个前导符                                         |
| `？`            | 匹配一个或0个前导符                                          |
| `$`             | 行尾定位符(以什么结尾)                                       |
| `.`             | 匹配任意单个字符                                             |
| `.*`            | 任意多个字符                                                 |
| `[]`            | 匹配中括号内的一个字符                                       |
| `[a-z]/[0-9]`   | 匹配从a到z或者从0到9的字符                                   |
| `[^]`           | 匹配不在中括号内的字符                                       |
| `\`和`""`和`''` | 转义字符，`""`脱意部分，`\`脱意跟在后面的字符，`''`将内部所有的部分全部脱意 |
| `\<`            | 词首定位符                                                   |
| `\>`            | 词尾定位符                                                   |
| `()`            | 组合并交给后面的\num                                         |
| `|`             | 或                                                           |

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209174254197.png" alt="image-20211209174254197" style="zoom:80%;" />

### grep（查）

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209180801261.png" alt="image-20211209180801261" style="zoom:80%;" />

| 字母 | 含义               |
| ---- | ------------------ |
| -q   | 静默               |
| -v   | 去反               |
| -R   | 查看目录下面的内容 |
| -o   | 只找关键字即可     |
| -B2  | before 2行         |
| -n   | 列出行号           |
| -A2  | after 2行          |
| -C2  | 上下两行           |
| -l   | 只要文件名         |



#### egrep

支持正则表达式的grep

#### fgrep



---

### awk（找及切片）

#### awk的两种形式

```shell
awk '{指令内容}' 目标文件
awk 'BEGIN{}{}END{}' 目标文件		# 目标文件处理前执行BEGIN内的，处理时执行{}内的，处理后执行END{}内的
awk -f awk的脚本 目标文件
```

- -Ffs指定输入文件折分隔符，fs是一个字符串或者是一个正则表达式，如`-F:`==默认为空格或者制表符==
- 分隔后的数据，依照原顺序赋值给`$1、$2、$3、$4`...`$0`代表一整行数据

#### 内部变量

```shell
awk -F\; "{指令内容}" 目标文件			# 修改默认分隔符为；
awk '{BEGIN{FS=";"}{}}'						# 修改默认分隔符为；
awk '{BEGIN{FS=";";OFS="++"}}'		# 修改输出的为默认分隔符为；默认为空格
awk '{print NR,$0}' 目标文件1 目标文件2		# 打印文件一行时进行一行一行的编号，每个文件重新编号还是一起编号的区别
```

`BEGIN{}`内部变量见下表；修改见上面的程序块。

| 变量名 | 描述                                                         |
| ------ | ------------------------------------------------------------ |
| FS     | 输入分隔符（默认为空格）                                     |
| OFS    | 输出分隔符（默认为空格）                                     |
| RS     | 输入行分隔符（默认为换行符，修改之后就不按着一行一行处理模式进行） |
| ORS    | 输出行分隔符                                                 |
| NR/FNR | 多文件汇总编号/多文件单独标号                                |
| NF     | 统计列数，则`$NF`为最后一列                                  |

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211210085445171.png" alt="image-20211210085445171" style="zoom:80%;" />

#### 模式（正则表达和动作）

`''`内的内容

- 正则表达式
- 关系
  - ==、!\=
  - <、>
  - <=、>=
- 算数运算
  - \+	\-	\*	/ 	^...
- 逻辑运算
  - &&	\|\|	!

```shell
awk '{$1 ~ /^roo/}'		# 检索分割后第一列中以roo开头的一行	
awk '{$3 == 3}'				# 检索分割后第三列为3的一行
awk '{$7 == "/bin/bash"}'		# 检索分割后第7列为/bin/bash的一行
awk '{$3 * 4 > 50}'					# 检索第三列×4大于50的一行
awk '{$3 * 4 > 50 && $7 == "/bin/bash"}'
```

#### 范围模式

```shell
awk -F: '/从哪里/,/到哪里/' 目标文件 
```

#### awk脚本编程

##### 变量

```shell
awk -F: -v vari=www '$1 == vari' 目标文件		# 查找文件中$1为www的一行

# 使用shell变量，需要多重注释
var2=shutdown
awk -F: '$1 ~ "'"$var2"'"' 目标文件

# 在awk内部使用条件语句,C语言格式（包括else内容）
awk -F: '{if(条件语句){命令}else if(){}else{}}' 目标文件

# 在awk内部使用循环语句，都是C语言格式
awk 'BEGIN{while(i<=10){命令}' 目标文件
awk 'BEGIN{for(i=1;i<=10;i++)}' 目标文件

# 数组使用，此数组没有特殊变量@ *这种，只能用循环打印内容
awk -F: '{username[++i]=$1}END{}' 目标文件
```

---

### sed（改）

使用sed在程序中修改，是一行一行进行的，在缓存区修改，修改完如果有-i才会插入

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209181835097.png" alt="image-20211209181835097" style="zoom:80%;" />

命令：`sed [选项] "内容" 目标文件`

- -i      insert 插入
- -r     支持正则表达

命令：`sed [选项] "内容" -f 脚本文件 目标文件 `

这个命令会将脚本对目标文件运行

命令选项：

| 命令选项 | 含义           |
| -------- | -------------- |
| d        | 删除           |
| s        | 替换           |
| r        | 读写文件       |
| w        | 另存为         |
| a        | 追加           |
| l        | 在什么之前插入 |
| c        | 替换整行命令   |
| n        | 获取下一行命令 |
| l        | 反向选择       |
| e        | 多重编辑       |
| $        | 最后一行       |

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209183032385.png" alt="image-20211209183032385" style="zoom:80%;" />删除root那一行

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209183202473.png" alt="image-20211209183202473" style="zoom:80%;" />删除第三行

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209183243030.png" alt="image-20211209183243030" style="zoom:80%;" />删除第三行

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209183319762.png" alt="image-20211209183319762" style="zoom:80%;" />删除一到三行

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209183433169.png" alt="image-20211209183433169" style="zoom:80%;" />

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209184008154.png" alt="image-20211209184008154" style="zoom:80%;" />

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209184529483.png" alt="image-20211209184529483" style="zoom:80%;" />

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211209185602021.png" alt="image-20211209185602021" style="zoom:80%;" />



---

## 定时维护案例

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211208143616753.png" alt="image-20211208143616753" style="zoom:80%;" />

```shell
DATANAME=$(date +%Y_%m_%d_%H%M%S)
#echo $DATANAME

echo "backup place is $BACKUP_DIR/$DATANAME.tar.gz"

HOST=localhost
OB_USER=root
DB_PWD=root

# 备份路径是否存在，不存在创建
if [ ! -e "$BACKUP_DIR/$DATANAME" ]
then
        mkdir -p  "$BACKUP_DIR/$DATANAME"
fi
# [ ! -e "$BACKUP_DIR/$DATANAME"] && mkdir -p "$BACKUP_DIR/$DATANAME"

DATABASE=ghDB
# 先将文件打包放到一个文件夹内，后续会用别的压缩器压缩，再将中间文件删除
mysqldump -u${DB_USER} -p${DB_PWD} --host=$HOST $DATABASE | gzip > $BACKUP/$DATANAME/$DATANAME.sql.gz
# 打包，并删除中间文件
cd $BACKUP
tar -zcvf $DATANAME.tar.gz $DATANAME
rm -rf $BACKUP/$DATANAME

# 删除十天前的文件
find $BACKUP -mtime +10 -name "*.tar.gz" -exec rm -rf {}\;
echo "over"
```







