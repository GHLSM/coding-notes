## Nosql概述

### 为什么要用Nosql？

大数据时代，数据较多，关系型数据库无法进行存储。

>单机Mysql时代
>
>​	服务器无压力，较多使用静态网页，单个数据库完全足够

- 数据量多一个机器放不下
- 数据索引较大，机器内存放不下
- 访问量（读写混合），一个服务器承受不了

>Memcach（缓存）+MySQL+垂直缓存（读写分离）

- 网站读取的情况较多，每次都要查询数据库就较为麻烦，为了减轻数据压力，添加数据缓存

>分库分离+水平拆分+MySQL集群

- MySQL等关系数据库不够用了，数据量很多，变化很快
- 存储的大文件等，数据库较大，效率较低
- 大数据情况下，表几乎没办法更大

### 什么是NoSQL？

> Not only SQL

泛指非关系型数据库

不需要一个固定的格式，不需要较多的操作就可以横向扩展

- 方便扩展（数据之间没有关系，很好扩展）
- 大数据量高性能（Redis，一秒写8万次，读取11万次），NoSQL的缓存是一种细粒度的缓存，性价比较高
- 不需要事先设计数据库

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211213163722873.png" alt="image-20211213163722873" style="zoom: 80%;" />

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211213163817399.png" alt="image-20211213163817399" style="zoom:80%;" />

### NoSQL四大分类

#### KV键值对

新浪：Redis

美团：Resid+Tair

阿里、百度：Redis + memecache

#### 文档型数据库（bjson和json一样）

mongoDB

分布式文件存储的数据库，C++编写，介于关系型数据库和非关系型数据库中的产品

#### 列存储数据库

Hbase

分布式文件系统

#### 图关系型数据库

neo4j，infoGrid

## Redis基础知识

### 默认端口

6379

```bash
redis-server kconfig/redis.conf	# redis的配置文件
redis-cli -p 6379	# 连通redis
127.0.0.1：6379>ping
PONG
```

共有16个数据库，默认使用第0个数据库，使用select进行数据库切换

```bash
select 3	# 选择第3个数据库（第4个，从0开始数）
dbsize	# 查看数据库大小
```

### 简单使用

```bash
# set命令  set [key] [value]
set name gh
# 此时 disize-->1
get name	# "gh"
```

### 查看数据库中所有的key

```bash
select [db_name]
keys *	# 查看所有的key值
```

### 清空数据库

```bash
select [db_name]
flushdb	# 清空当前数据库

FLUSHALL	# 清空所有数据库内容
```

### Redis为什么是单线程的

Redis基于内存操作，瓶颈不在CPU，而是在内存和网络带宽。将数据全部放在内存中，没有多线程的上下文切换等耗时操作，对于内存系统来说，没有上下文切换效率就是最好的。

---

## Redis五大基础数据类型

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211214175104522.png" alt="image-20211214175104522" style="zoom:80%;" />

Redis 是一个开源（BSD许可）的，内存中的数据结构存储系统，它可以用作数据库、缓存和消息中间件。 它支持多种类型的数据结构，如 [字符串（strings）](http://www.redis.cn/topics/data-types-intro.html#strings)， [散列（hashes）](http://www.redis.cn/topics/data-types-intro.html#hashes)， [列表（lists）](http://www.redis.cn/topics/data-types-intro.html#lists)， [集合（sets）](http://www.redis.cn/topics/data-types-intro.html#sets)， [有序集合（sorted sets）](http://www.redis.cn/topics/data-types-intro.html#sorted-sets) 与范围查询， [bitmaps](http://www.redis.cn/topics/data-types-intro.html#bitmaps)， [hyperloglogs](http://www.redis.cn/topics/data-types-intro.html#hyperloglogs) 和 [地理空间（geospatial）](http://www.redis.cn/commands/geoadd.html) 索引半径查询。 Redis 内置了 [复制（replication）](http://www.redis.cn/topics/replication.html)，[LUA脚本（Lua scripting）](http://www.redis.cn/commands/eval.html)， [LRU驱动事件（LRU eviction）](http://www.redis.cn/topics/lru-cache.html)，[事务（transactions）](http://www.redis.cn/topics/transactions.html) 和不同级别的 [磁盘持久化（persistence）](http://www.redis.cn/topics/persistence.html)， 并通过 [Redis哨兵（Sentinel）](http://www.redis.cn/topics/sentinel.html)和自动 [分区（Cluster）](http://www.redis.cn/topics/cluster-tutorial.html)提供高可用性（high availability）

### Redis-key

```bash
keys *
set [key]
get [key]
EXSITS [key]			# 查找以此key值对应的所有value个数
move [key]	1			# 此数据库中删除key值对应的数据，1代表当前数据库
EXPIRE [key] 10		# 10秒之后key值对应的数据过期，会被删除
ttl [key]					# 查看某一key值对应的数据过期时间
type [key]				#	查看key值对应数据的数据类型
```

### String（字符串）

```bash
APPEND [key] [value]			# 对同一个key值的数据进行增加（修改），如果key不在，则新建，相当于set
STRLEN [key]							# 返回key值对应的value的长度
incr [key]								# 原子加1操作
decr [key]								# 原子减1操作
incrby [key] [n]					# 原子加n操作
decrby [key] [n]					# 原子减n操作
getrange [key] [start] [end]	# 类似于切片操作，但是是左右都闭合
getrange [key] [start] [-1]	# 全部返回
setrange [key] [start] [new_content]	# 从value的第start个位置开始修改后面的内容，到new_content全部修改完

# setex	# set with expire	设置过期时间
# setnx	# set if not exist	不存在则设置
setex [key] [sec] [value]		# 设置一个key value数据，过期时间为sec

setnx [key] [value]					# 如果key不存在则设置（在分布式锁中经常使用）

# 批量
mset [key1] [value1] [key2] [value2] 	# 批量设置，往后面增加即可
mget [key1] [key2]										# 批量获取
msetnx [key1] [value1] [key2] [value2]	# 批量，原子操作，有一个不成功整条命令失效

# 对象
set user:1 {name:zhan, age:3} # 设置一个user:1对象，来保存值为json字符的一个对象
# 注意key的设计，根据":"(任意符号)进行分割修改即可
set user:1:name zhan user:1:age 13

getset [key] [new_value]		# 先获取再修改
```

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211214180817963.png" alt="image-20211214180817963" style="zoom:80%;" />

### List（列表）

列表，在redis内部可以把list玩成队列、栈、阻塞队列等

注意list的存储结构

```bash
lpush [list_name] [value]					# 定义一个list，从左边开始存入数据value,可以多个
lrange [list_name] [start] [end]	# 从列表左边开始读list内部的数据，注意顺序
rpush [list_name] [value]					# 从列表右边开始添加数据
```

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211214184154562.png" alt="image-20211214184154562" style="zoom:80%;" />

```bash
lpop [list_name]		# 从左边开始，移除（删除）list中头的数据
rpop [list_name]		# 从右边开始，移除（删除）list中头的数据
lindex [list_name] [n]	# 下表
llen [list_name]		# 获得列表的长度

# 删除数据
lrem [list_name] [n] [value]	# 移除list中值为value的数据，移除n个
# 截断数据(批量移除数据，留下需要保存的数据)
ltrim [list_name] [start] [end] # 只保留闭区间[start, end]的数据

# rpoplpush			# 移除列表右侧第一个元素（最后一个元素），从左边push到新列表(目标列表)
rpoplpush [old_list] [new_list]

# lset	# 使用前提是list必须存在
lset [list_name] [index] [value] # 将list中index位改为value值

# linsert # 插入
linsert [list_name] [before/after] [value] [new_value] # 在value的前/后插入new_value
```

- 消息排队
- 消息队列
- 栈、队列等

### Set(集合)

set中的值不能重复

绝大多数的命令都是s开头

```bash
sadd [set_name] [value]				# 设置一个set，并添加value值进入

smembers [set_name]						# 查看某一个set中有哪些成员()value
smember [set_name] [value]		# 查询某一set中是否有这一个value，是返回1，否返回0

scard [set_name]							# 获取set中的元素个数

srem [set_name] [value]				# 从set中移除某一value值

srandmember [set_name] [n]		# 从set中随机查询某n个值，不写n默认一个

spop [set_name]								# 从set中随机移除某个元素

smove [set_name] [new_set] [value]		# 将前一个set中的value移到第二个set中

# 并集
sunion	[setA] [setB]						# setA + setB
# 差集
sdiff [setA] [setB]						# setA -setB
# 交集
sinter [setA] [setB]					# setA + setB
```

- 共同关注
- 共同好友
- 好友推荐

### Hash（哈希）

有点类似于map，key-map，本质和string区别不大，相当于多了一个标识

```go
// key-map:
mykey				: {	name: 			"gh", }
hash_name				field_name	value
```

常用的命令以h开头

```bash
hset [hash_name] [field_name] [value]		# 设置值
hmset [hash_name] [field_name1] [value1] [field_name2] [value2] # 可以设置多个值，同名会覆盖

hget [hash_name] [field_name]						# 查询值
hmget [hash_name] [field_name1] [field_name2] 	# 可以查询多个值
hgetall [hash_name]											# 查询所有

hdel [hash_name] [field_name]						# 删除值

hlen [hash_name]												# 查看hash中有多少个key-value键值对
hexisis [hash_name]	[field_name]				# 是否存在

hkeys [hash_name]												# 查看所有的key值
hvals [hash_name]												# 查看所有的value值

# 深入到string那一层，实际上一样的，很多命令都是相似的
hincr
hincrby
hdecr
hdecrby
hsetnx
```

### Zset（有序集合）

在set的基础上增加了一个值，在这里称为``score``用于排序

```bash
zadd [set_name] [score] [value]			# 增加一个值
zadd [set_name] [score1] [value] [score2] [value] # 增加多个值
zrange [set_name] [start] [end]			# 查询多个值

zrangebyscore [set_name] [min] [max] [withscore(choice)]		# 排序，可选的加上score

zrevange [set_name] 0 -1 		# 反向排序（从大到小）
```

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211216155850186.png" alt="image-20211216155850186" style="zoom: 60%;" />

```bash
zrem [set_name] [value]		# 移除某一个value
zcard [set_name]					# 获取有序集合中的个数

zcount [set_name] [score1] [score2]		# 获取两个score中间的值的数量
```

---

## Redis三种特殊数据类型

### Geospacial（地理位置）

只有六个命令

> geoadd [place] [经度] [维度] [名称]	# 添加地理位置，有一定范围，超出无法添加

```bash
geoadd china:city 116.40 39.90 beijing
geoadd china:city 121.47 31.23 shanghai
geoadd china:city 106.50 29.53 chongqi
```

> geopos [place]	# 获取指定城市的经纬度

```bash
geopos china:city beijing
```

> geodist		# 距离计算

```bash
geodist china:city shanghai beijing [unit(choice)]  # 默认单位为m
```

> georadius [key] [经度] [维度] [距离] [单位] [withcoord(是否以经纬度显示)] [最多显示的个数]	
>
> georadiusbymember [key] [名称] [单位] [withcoord(是否以经纬度显示)] [最多显示的个数]	
>
> #在key中以给定经纬度为中心，找到一定距离的数据

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211216162816172.png" alt="image-20211216162816172" style="zoom:80%;" />

> geohash 		#  将二维经纬度转换为一维字符串

==GEO底层是使用Zset制作的，所以可以使用Zset的命令进行使用==

### Hyperloglog

> 什么是基数？即集合内不重复的元素个数

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211216165240399.png" alt="image-20211216165240399" style="zoom: 80%;" />

> pfadd
>
> pfcount
>
> pfmerge

如果允许容错，既可以使用hyperloglog

### Bitmap

位存储，Bitmap，位图结构，都是操作二进制位来记录，只有0，1两种状态

> setbit	# 设置

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211216165813460.png" alt="image-20211216165813460" style="zoom: 60%;" />

> getbi	# 查询



<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211216165920700.png" alt="image-20211216165920700" style="zoom: 80%;" />



> bitcount [key] [start] [end]	# 统计

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211216170012922.png" alt="image-20211216170012922" style="zoom:80%;" />



## Redis中的事务

事务的本质就是一组命令的集合！所有的事务都需要序列化

原子性：要么同时成功，要么同时失败

==Redis单条命令是保证原子性的，但是redis的事务是不保证原子性的！==

==Redis事务没有隔离级别的概念==

所有的命令在事务中，并没有被执行，只有发起执行命令的时候才会执行

- 开启事务（multi）
- 命令入队（自动进行）
- 执行事务(exec)

> 正常执行事务

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211221122115425.png" alt="image-20211221122115425" style="zoom: 67%;" />

> 放弃事务

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211221122246030.png" alt="image-20211221122246030" style="zoom:67%;" />

> 编译型异常，事务中所有的命令都不执行

> 运行时异常，除了错误命令，其他命令会执行



> 监控，锁机制，Watch

- 悲观锁，认为什么时候都会出问题，都会加锁
- 乐观锁，认为什么时候都不会出问题，所以不会加锁，更新数据时判断，在此期间是否有人修改过这个数据，获取version，更新的时候比较version

