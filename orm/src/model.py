from src.field import Field


class ModelMetaclass(type):
    def __new__(mcs, name, bases, attrs):
        # print(mcs, name, bases, attrs)
        if name == "Model":
            return type.__new__(mcs, name, bases, attrs)

        mappings = dict()
        # print(attrs)
        for key, value in attrs.items():

            if isinstance(value, Field):
                mappings[key] = value

        for key in mappings.keys():
            attrs.pop(key)

        attrs["__mappings__"] = mappings
        attrs["__table__"] = name

        return type.__new__(mcs, name, bases, attrs)


class Model(dict, metaclass=ModelMetaclass):
    def __init__(self, **kwargs):
        super(Model, self).__init__(**kwargs)

    def __getattr__(self, item):
        try:
            return self[item]
        except KeyError:
            raise AttributeError(r"'Model' object has no attribute '%s'" % item)

    def __setattr__(self, key, value):
        self[key] = value

    def save(self):
        fields = []
        # params = []
        args = []
        for key, value in self.__mappings__.items():
            fields.append(value.column_name)
            # params.append(str(self[key]))
            args.append(str(getattr(self, key, None)))

        sql = "insert into (%s) (%s) values (%s)" % (self.__table__, ','.join(fields), ','.join(args))
        print('SQL: %s' % sql)
        # print('ARGS: %s' % str(args))
