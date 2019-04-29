from django.db import models
class Person(models.Model):
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)

class Hello(models.Model):
    your_name = models.CharField(max_length=10)

    def __str__(self):
        return "<{0}>".format(self.your_name)
