class Field(object):
    def __init__(self, column_name, column_type, primary_key=False):
        self.column_name = column_name
        self.column_type = column_type
        self.primary_key = primary_key

    def __str__(self):
        return "<%s, %s>" % (self.__class__.__name__, self.column_name)


class StringField(Field):
    def __init__(self, column_name, primary_key, column_type="varchar(255)"):
        super().__init__(column_name, column_type, primary_key)


class IntegerField(Field):
    def __init__(self, column_name, primary_key, column_type="bigint"):
        super().__init__(column_name, column_type, primary_key)
