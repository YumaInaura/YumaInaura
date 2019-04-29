from django.db import models

# Create your models here.

class Hello(models.Model):
    your_name = models.CharField(max_length=10)

    def __str__(self):
        return "<{0}>".format(self.your_name)


