### Flask初学

Flask 依赖 [Jinja](https://www.palletsprojects.com/p/jinja/) 模板引擎和 [Werkzeug](https://www.palletsprojects.com/p/werkzeug/) WSGI 套件

```python
from flask import Flask
from flask import render_template
from flask import request
from flask import redirect
from flask import session

# 创建的Flask对象，__name__指的是文件名
app = Flask(__name__)
# 设置session加密的时候的”盐“，即secret_key
app.secret_key = "sdsafasgvds"
# 调试模式，保存之后就自动重启
app.debug = True


# 路由所对应的执行函数，默认只允许get方法，可由methods字段更改
@app.route('/login', methods=["GET", "POST"])
def login():
    # print(request)
    # print("request coming")
    # if request.method=="GET“:
    #   return render_template("login.html", **{"msg":"content"}) # 返回index页面及数据
    #   return render_template("login.html", msg="content") # 返回index页面及数据
    if request.method == "POST":
        name = request.form.get("name")
        if name == "GH":
            # 用户信息放进session，此时默认是放进了cookie而不是数据库内部，一般需要签名（加个密）
            session["user_info_name"] = name
            redirect("/index")

    return '信息'


'''
request内部（类似中间件）将request信息都封装在request中
    request.method  -->请求的方法
    request.form    -->获取POST请求的参数
        request.form.get("字段名")
    request.args    -->获取GET请求的数据（连接在URL后面的参数）
        request.args.get("字段名")
'''


@app.route("/index")
def index():
    if not session.get("user_info_name"):
        # return render_template("login.html")
        return redirect("/login")
    return "welcome"


@app.route("/logout")
def logout():
    if session.get("user_info_name"):
        del session["user_info_name"]
    return redirect("/login")


if __name__ == '__main__':
    app.run()
    '''
    内部执行run_simple(t.cast(str, host), port, self, **options)
    此时self就是app对象
    执行过程会将run_simple第三个参数加()运行，此时则应该是app()，即是app对象的call方法
    '''
from flask import Flask

# 创建的Flask对象，__name__指的是文件名
app = Flask(__name__)


# 路由所对应的执行函数
@app.route('/')
def hello_world():
    return 'Hello World!'


if __name__ == '__main__':
    app.run()
    '''
    内部执行run_simple方法，run_simple(t.cast(str, host), port, self, **options)
    此时self就是app对象
    执行过程会将run_simple第三个参数加()运行，此时则应该是app()，即是app对象的call方法
    '''
```

### 配置文件

#### 所有的配置项

```python
flask中的配置文件是一个flask.config.Config对象（继承字典）,默认配置为：
    {
        'DEBUG':                                get_debug_flag(default=False),  是否开启Debug模式
        'TESTING':                              False,                          是否开启测试模式
        'PROPAGATE_EXCEPTIONS':                 None,                          
        'PRESERVE_CONTEXT_ON_EXCEPTION':        None,
        'SECRET_KEY':                           None,
        'PERMANENT_SESSION_LIFETIME':           timedelta(days=31),
        'USE_X_SENDFILE':                       False,
        'LOGGER_NAME':                          None,
        'LOGGER_HANDLER_POLICY':               'always',
        'SERVER_NAME':                          None,
        'APPLICATION_ROOT':                     None,
        'SESSION_COOKIE_NAME':                  'session',
        'SESSION_COOKIE_DOMAIN':                None,
        'SESSION_COOKIE_PATH':                  None,
        'SESSION_COOKIE_HTTPONLY':              True,
        'SESSION_COOKIE_SECURE':                False,
        'SESSION_REFRESH_EACH_REQUEST':         True,
        'MAX_CONTENT_LENGTH':                   None,
        'SEND_FILE_MAX_AGE_DEFAULT':            timedelta(hours=12),
        'TRAP_BAD_REQUEST_ERRORS':              False,
        'TRAP_HTTP_EXCEPTIONS':                 False,
        'EXPLAIN_TEMPLATE_LOADING':             False,
        'PREFERRED_URL_SCHEME':                 'http',
        'JSON_AS_ASCII':                        True,
        'JSON_SORT_KEYS':                       True,
        'JSONIFY_PRETTYPRINT_REGULAR':          True,
        'JSONIFY_MIMETYPE':                     'application/json',
        'TEMPLATES_AUTO_RELOAD':                None,
    }
 

```

#### 配置的方式

```python
方式一：
    app.config['DEBUG'] = True
 
    PS： 由于Config对象本质上是字典，所以还可以使用app.config.update(...)
 
方式二：
    app.config.from_pyfile("python文件名称")
        如：
            settings.py
                DEBUG = True
 
            app.config.from_pyfile("settings.py")
 
    app.config.from_envvar("环境变量名称")
        环境变量的值为python文件名称名称，内部调用from_pyfile方法
 
 
    app.config.from_json("json文件名称")
        JSON文件名称，必须是json格式，因为内部会执行json.loads
 
    app.config.from_mapping({'DEBUG':True})
        字典格式
 
    app.config.from_object("python类或类的路径")
 
        app.config.from_object('pro_flask.settings.TestingConfig')
 
        settings.py
 
            class Config(object):
                DEBUG = False
                TESTING = False
                DATABASE_URI = 'sqlite://:memory:'
 
            class ProductionConfig(Config):
                DATABASE_URI = 'mysql://user@localhost/foo'
 
            class DevelopmentConfig(Config):
                DEBUG = True
 
            class TestingConfig(Config):
                TESTING = True
 
        PS: 从sys.path中已经存在路径开始写
     
 
    PS: settings.py文件默认路径要放在程序root_path目录，
    		如果instance_relative_config为True，则就是instance_path目录
```

### 路由系统

#### 路由创建

```python
"""
1. decorator = route("/index", methods=["GET", "POST"]
2. @decorator
    - index = decorator(index)
    - self.add_url_rule(rule, endpoint, f, **options) 
        rule为"/index", endpoint默认为None, f为rule对应的函数
        
3. endpoint默认为空，其是路由的别称，可以在之后的使用中反向生成路由
    不起别名时就是装饰器装饰的函数名
      def decorator(f):
         self.view_functions[endpoint] = f
         return f
"""

from flask import url_for

# 方式一，使用装饰器，一般使用第一种
@app.route("/index", methods=["GET", "POST"], endpoint="r1")
def index():
    print(url_for("r1"))  # 输出”/index“ 
    return "hello"

# 方式二，直接使用内部运行的函数
app.add_url_rule("/index", view_func=index)
```

#### 路由附加参数

```python
@app.route('/user/<username>')
@app.route('/post/<int:post_id>')
@app.route('/post/<float:post_id>')
@app.route('/post/<path:path>')
@app.route('/login', methods=['GET', 'POST'])

# 常用路由系统有以上五种，所有的路由系统都是基于一下对应关系来处理：
DEFAULT_CONVERTERS = {
    'default':          UnicodeConverter,
    'string':           UnicodeConverter,
    'any':              AnyConverter,
    'path':             PathConverter,
    'int':              IntegerConverter,
    'float':            FloatConverter,
    'uuid':             UUIDConverter,
}
```

#### 自定义附加参数的转换关系

```python
class RegexConverter(BaseConverter):
  """
  自定义URL匹配正则表达式
  """
  def __init__(self, map, regex):
    super(RegexConverter, self).__init__(map)
    self.regex = regex

  def to_python(self, value):
      """
      路由匹配时，匹配成功后传递给视图函数中参数的值
      :param value: 
      :return: 
      """
      return int(value)

  def to_url(self, value):
      """
      使用url_for反向生成URL时，传递的参数经过该方法处理，返回的值用于生成URL中的参数
      :param value: 
      :return: 
      """
      val = super(RegexConverter, self).to_url(value)
      return val
   
app.url_map.converters['regex'] = RegexConverter
```

#### 注册路由时的可传参数

```python
@app.route和app.add_url_rule参数：
    rule,                URL规则
    view_func,           视图函数名称
    defaults=None,       默认值,当URL中无参数，函数需要参数时，使用defaults={'k':'v'}为函数提供参数
    endpoint=None,       名称，用于反向生成URL，即： url_for('名称')
    methods=None,        允许的请求方式，如：["GET","POST"]


    strict_slashes=None  对URL最后的 / 符号是否严格要求，
        如： @app.route('/index',strict_slashes=False)，
            访问 http://www.xx.com/index/ 或 http://www.xx.com/index均可
            @app.route('/index',strict_slashes=True)
            仅访问 http://www.xx.com/index 

    redirect_to=None     重定向到指定地址
        如：@app.route('/index/<int:nid>', redirect_to='/home/<nid>')
        或
           def func(adapter, nid):
              return "/home/888"
           @app.route('/index/<int:nid>', redirect_to=func)

    subdomain=None         子域名访问
```

#### 对view_func添加自己的装饰器

1. 装饰器位置
2. 函数名的解析问题

```python
import functools

def wapper(func)：
	# 如果不加functools.wraps装饰器，那么由于加上此装饰器的实际函数名都会变成inner，则会报错
  @functools.wraps(func)
  def inner(args, **kwargs)：
  	rec = func(args, **kwargs)
  	return rec
  return inner

@app.route(”/index“)
@wapper  # 位置只能是在这才能确保装饰准确
def index()
	return "hello"

@app.route(”/new“)
@wapper  # 位置只能是在这才能确保装饰准确
def new()
	return "hi"
```

### FBV&CBV

一般是建议使用FBV

```python
def wrapper(func):
    # 如果不加functools.wraps装饰器，那么由于加上此装饰器的实际函数名都会变成inner，则会报错
    @functools.wraps(func)
    def inner(args, **kwargs):
        rec = func(args, **kwargs)
        return rec

    return inner


# FBV
@app.route("/index", methods=["GET", "POST"])
def index():
    return "hi"


# CBV
class IndexView(views.View):
    methods = ["GET", "POST"]
    decorators = [wrapper, ]

    def dispatch_request(self):
        return "hi"


class IndexView2(views.MethodView):
    methods = ["GET", "POST"]
    decorators = [wrapper, ]

    def get(self):
        return "hi"

    def post(self):
        return "hi"


app.add_url_rule("/index", view_func=IndexView.as_view(name="index"))
app.add_url_rule("/index", view_func=IndexView2.as_view(name="index"))
```

#### 请求和响应

```python
@app.route('/login.html', methods=['GET', "POST"])
def login():

  # 请求相关信息
  # request.method
  # request.args
  # request.form
  # request.headers
  # request.cookies
  # request.files
  # obj = request.files['the_file_name']
  # obj.save('/var/www/uploads/' + secure_filename(f.filename))
  
  
  # request.path
  # request.values
  # request.full_path
  # request.script_root
  # request.url
  # request.base_url
  # request.url_root
  # request.host_url
  # request.host


  # 响应相关信息
  # return "字符串"
  # return render_template('html模板路径',**{})
  # return redirect('/index.html')
  # return jsonify({})   # return json.dumps({}) 两个是一样的
  

  # response = make_response(render_template('index.html'))
  # response是flask.wrappers.Response类型
  # response.delete_cookie('key')
  # response.set_cookie('key', 'value')
  # response.headers['X-Something'] = 'A value'
  # return response
	pass
```

### session

#### 写入过程

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20210820133949813.png" alt="image-20210820133949813" style="zoom: 50%;" />

#### 第三方的session（不存在浏览器）

```python
from flask import Flask, session, redirect
from flask.ext.session import Session


app = Flask(__name__)
app.debug = True
app.secret_key = 'asdfasdfasd'


app.config['SESSION_TYPE'] = 'redis'
from redis import Redis
app.config['SESSION_REDIS'] = Redis(host='192.168.0.94',port='6379')
Session(app)


@app.route('/login')
def login():
    session['username'] = 'alex'
    return redirect('/index')


@app.route('/index')
def index():
    name = session['username']
    return name


if __name__ == '__main__':
    app.run()
```



### 生命周期钩子函数（类似于中间件）

```python
@app.before_first_request
def before_first_request1():
    print('before_first_request1')


@app.before_first_request
def before_first_request2():
    print('before_first_request2')


@app.before_request
def before_request1():
    Request.nnn = 123
    print('before_request1')


@app.before_request
def before_request2():
    print('before_request2')


@app.after_request
def after_request1(response):
    print('before_request1', response)
    return response


@app.after_request
def after_request2(response):
    print('before_request2', response)
    return response


@app.errorhandler(404)
def page_not_found(error):
    return 'This page does not exist', 404


@app.template_global()
def sb(a1, a2):
    return a1 + a2


@app.template_filter()
def db(a1, a2, a3):
    return a1 + a2 + a3
```

### Flash

用于存放临时数据，阅后即焚的数据

```python
from flask import Flask, flash, redirect, render_template, request, get_flashed_messages

app = Flask(__name__)
app.secret_key = 'some_secret'


@app.route('/')
def index1():
  messages = get_flashed_messages(category_filter=["c1",])
  print(messages)
  return "Index1"


@app.route('/set')
def index2():
  v = request.args.get('p')
  flash(v, category = "c1")
  flash(v, category = "c2")
  return 'ok'


if __name__ == "__main__":
  app.run()
```

### 中间件

```python
from flask import Flask, flash, redirect, render_template, request
 
app = Flask(__name__)
app.secret_key = 'some_secret'
 
@app.route('/')
def index1():
    return render_template('index.html')
 
@app.route('/set')
def index2():
    v = request.args.get('p')
    flash(v)
    return 'ok'
 
class MiddleWare:
    def __init__(self,wsgi_app):
        self.wsgi_app = wsgi_app
 
    def __call__(self, *args, **kwargs):
 
        return self.wsgi_app(*args, **kwargs)
 
if __name__ == "__main__":
    app.wsgi_app = MiddleWare(app.wsgi_app)
    app.run(port=9999)
```

### Threading local

```python
from threading import Thread, local
import time

hello = local()
# 在每个线程自己的空间开辟一个地方存储变量值
# 修改时，每个线程的同一个参数不互相影响，无需用锁机制解决


def task(arg):
    hello.value = arg
    time.sleep(2)
    print(hello.value)


for i in range(10):
    t = Thread(target=task, args=(i,))
    t.start()

# 9, 2, 1, 0, 4, 3, 5, 8, 7 ,6

```

#### 

### SqlAchemy

SQLAlchemy是[Python](http://baike.baidu.com/subview/21087/21087.htm)编程语言下的一款ORM框架，该框架建立在数据库API之上，使用关系对象映射进行数据库操作，简言之便是：将对象转换成SQL，然后使用数据API执行SQL并获取执行结果。

安装：

```
pip3 install SQLAlchemy
```

<img src="https://images2015.cnblogs.com/blog/425762/201607/425762-20160723192854919-886727948.png" alt="img" style="zoom:50%;" />

 

SQLAlchemy本身无法操作数据库，其必须以来pymsql等第三方插件，Dialect用于和数据API进行交流，根据配置文件的不同调用不同的数据库API，从而实现对数据库的操作，如：

```python
MySQL-Python``  ``mysql+mysqldb://<``user``>:<``password``>@<host>[:<port>]/<dbname>`` ` `pymysql``  ``mysql+pymysql://<MySQL-Python
    mysql+mysqldb://<user>:<password>@<host>[:<port>]/<dbname>
   
pymysql
    mysql+pymysql://<username>:<password>@<host>/<dbname>[?<options>]
   
MySQL-Connecto
    mysql+mysqlconnector://<user>:<password>@<host>[:<port>]/<dbname>
   
cx_Oracle
    oracle+cx_oracle://user:pass@host:port/dbname[?key=value&key=value...]
   
更多详见：http://docs.sqlalchemy.org/en/latest/dialects/index.html
```

**一、内部处理**

使用 Engine/ConnectionPooling/Dialect 进行数据库操作，Engine使用ConnectionPooling连接数据库，然后再通过Dialect执行SQL语句。

```python
#!/usr/bin/env python
# -*- coding:utf-8 -*-
from sqlalchemy import create_engine
  
  
engine = create_engine("mysql+pymysql://root:123@127.0.0.1:3306/t1", max_overflow=5)
  
# 执行SQL
cur = engine.execute(
     "INSERT INTO hosts (host, color_id) VALUES ('1.1.1.22', 3)"
 )
  
# 新插入行自增ID
 cur.lastrowid
  
# 执行SQL
# cur = engine.execute(
#     "INSERT INTO hosts (host, color_id) VALUES(%s, %s)",[('1.1.1.22', 3),('1.1.1.221', 3),]
# )
  
  
# 执行SQL
 cur = engine.execute(
     "INSERT INTO hosts (host, color_id) VALUES (%(host)s, %(color_id)s)",
     host='1.1.1.99', color_id=3
 )
  
# 执行SQL
cur = engine.execute('select * from hosts')
# 获取第一行数据
cur.fetchone()
# 获取第n行数据
cur.fetchmany(3)
# 获取所有数据
cur.fetchall()
```

**二、ORM功能使用**

使用 ORM/Schema Type/SQL Expression Language/Engine/ConnectionPooling/Dialect 所有组件对数据进行操作。根据类创建对象，对象转换成SQL，执行SQL。

1、创建表

```python

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint, Index
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy import create_engine
 
engine = create_engine("mysql+pymysql://root:123@127.0.0.1:3306/t1", max_overflow=5)
 
Base = declarative_base()
 
# 创建单表
class Users(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    name = Column(String(32))
    extra = Column(String(16))
 
    __table_args__ = (
    UniqueConstraint('id', 'name', name='uix_id_name'),
        Index('ix_id_name', 'name', 'extra'),
    )
 
 
# 一对多
class Favor(Base):
    __tablename__ = 'favor'
    nid = Column(Integer, primary_key=True)
    caption = Column(String(50), default='red', unique=True)
 
 
class Person(Base):
    __tablename__ = 'person'
    nid = Column(Integer, primary_key=True)
    name = Column(String(32), index=True, nullable=True)
    favor_id = Column(Integer, ForeignKey("favor.nid"))
 
 
# 多对多
class Group(Base):
    __tablename__ = 'group'
    id = Column(Integer, primary_key=True)
    name = Column(String(64), unique=True, nullable=False)
    port = Column(Integer, default=22)
 
 
class Server(Base):
    __tablename__ = 'server'
 
    id = Column(Integer, primary_key=True, autoincrement=True)
    hostname = Column(String(64), unique=True, nullable=False)
 
 
class ServerToGroup(Base):
    __tablename__ = 'servertogroup'
    nid = Column(Integer, primary_key=True, autoincrement=True)
    server_id = Column(Integer, ForeignKey('server.id'))
    group_id = Column(Integer, ForeignKey('group.id'))
 
 
def init_db():
    Base.metadata.create_all(engine)
 
 
def drop_db():
    Base.metadata.drop_all(engine)
```

*注：设置外检的另一种方式 ForeignKeyConstraint(['other_id'], ['othertable.other_id'])*

#### 操作表

```python
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint, Index
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy import create_engine

engine = create_engine("mysql+pymysql://root:123@127.0.0.1:3306/t1", max_overflow=5)

Base = declarative_base()

# 创建单表
class Users(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    name = Column(String(32))
    extra = Column(String(16))

    __table_args__ = (
    UniqueConstraint('id', 'name', name='uix_id_name'),
        Index('ix_id_name', 'name', 'extra'),
    )

    def __repr__(self):
        return "%s-%s" %(self.id, self.name)

# 一对多
class Favor(Base):
    __tablename__ = 'favor'
    nid = Column(Integer, primary_key=True)
    caption = Column(String(50), default='red', unique=True)

    def __repr__(self):
        return "%s-%s" %(self.nid, self.caption)

class Person(Base):
    __tablename__ = 'person'
    nid = Column(Integer, primary_key=True)
    name = Column(String(32), index=True, nullable=True)
    favor_id = Column(Integer, ForeignKey("favor.nid"))
    # 与生成表结构无关，仅用于查询方便
    favor = relationship("Favor", backref='pers')

# 多对多
class ServerToGroup(Base):
    __tablename__ = 'servertogroup'
    nid = Column(Integer, primary_key=True, autoincrement=True)
    server_id = Column(Integer, ForeignKey('server.id'))
    group_id = Column(Integer, ForeignKey('group.id'))
    group = relationship("Group", backref='s2g')
    server = relationship("Server", backref='s2g')

class Group(Base):
    __tablename__ = 'group'
    id = Column(Integer, primary_key=True)
    name = Column(String(64), unique=True, nullable=False)
    port = Column(Integer, default=22)
    # group = relationship('Group',secondary=ServerToGroup,backref='host_list')


class Server(Base):
    __tablename__ = 'server'

    id = Column(Integer, primary_key=True, autoincrement=True)
    hostname = Column(String(64), unique=True, nullable=False)


def init_db():
    Base.metadata.create_all(engine)


def drop_db():
    Base.metadata.drop_all(engine)


Session = sessionmaker(bind=engine)
session = Session()
```

#### 增

```python
obj = Users(name="alex0", extra='sb')
session.add(obj)
session.add_all([
    Users(name="alex1", extra='sb'),
    Users(name="alex2", extra='sb'),
])
session.commit()
```

#### 删

```python
session.query(Users).filter(Users.id > 2).delete()
session.commit()
```

#### 改

```python
session.query(Users).filter(Users.id > 2).update({"name" : "099"})
session.query(Users).filter(Users.id > 2).update({Users.name: Users.name + "099"}, synchronize_session=False)
session.query(Users).filter(Users.id > 2).update({"num": Users.num + 1}, synchronize_session="evaluate")
session.commit()
```

#### 查

```python
ret = session.query(Users).all()
ret = session.query(Users.name, Users.extra).all()
ret = session.query(Users).filter_by(name='alex').all()
ret = session.query(Users).filter_by(name='alex').first()

ret = session.query(Users).filter(text("id<:value and name=:name")).params(value=224, name='fred').order_by(User.id).all()

ret = session.query(Users).from_statement(text("SELECT * FROM users where name=:name")).params(name='ed').all()
```

#### 其他

```python
#　条件
ret = session.query(Users).filter_by(name='alex').all()
ret = session.query(Users).filter(Users.id > 1, Users.name == 'eric').all()
ret = session.query(Users).filter(Users.id.between(1, 3), Users.name == 'eric').all()
ret = session.query(Users).filter(Users.id.in_([1,3,4])).all()
ret = session.query(Users).filter(~Users.id.in_([1,3,4])).all()
ret = session.query(Users).filter(Users.id.in_(session.query(Users.id).filter_by(name='eric'))).all()
from sqlalchemy import and_, or_
ret = session.query(Users).filter(and_(Users.id > 3, Users.name == 'eric')).all()
ret = session.query(Users).filter(or_(Users.id < 2, Users.name == 'eric')).all()
ret = session.query(Users).filter(
    or_(
        Users.id < 2,
        and_(Users.name == 'eric', Users.id > 3),
        Users.extra != ""
    )).all()


# 通配符
ret = session.query(Users).filter(Users.name.like('e%')).all()
ret = session.query(Users).filter(~Users.name.like('e%')).all()

# 限制
ret = session.query(Users)[1:2]

# 排序
ret = session.query(Users).order_by(Users.name.desc()).all()
ret = session.query(Users).order_by(Users.name.desc(), Users.id.asc()).all()

# 分组
from sqlalchemy.sql import func

ret = session.query(Users).group_by(Users.extra).all()
ret = session.query(
    func.max(Users.id),
    func.sum(Users.id),
    func.min(Users.id)).group_by(Users.name).all()

ret = session.query(
    func.max(Users.id),
    func.sum(Users.id),
    func.min(Users.id)).group_by(Users.name).having(func.min(Users.id) >2).all()

# 连表

ret = session.query(Users, Favor).filter(Users.id == Favor.nid).all()

ret = session.query(Person).join(Favor).all()

ret = session.query(Person).join(Favor, isouter=True).all()


# 组合
q1 = session.query(Users.name).filter(Users.id > 2)
q2 = session.query(Favor.caption).filter(Favor.nid < 2)
ret = q1.union(q2).all()

q1 = session.query(Users.name).filter(Users.id > 2)
q2 = session.query(Favor.caption).filter(Favor.nid < 2)
ret = q1.union_all(q2).all()
```

### 跨域请求