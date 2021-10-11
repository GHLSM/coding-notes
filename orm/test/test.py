from src.model import Model
from src.field import IntegerField, StringField


class User(Model):
    id = IntegerField('id')
    name = StringField('username')
    email = StringField('email')
    password = StringField('password')


# if __name__ == '__main__':
user1 = User(id=12345, name='Michael', email='test@orm.org', password='my-pwd')
user1.save()
# print(user1)
# print(type(type(user1)))
