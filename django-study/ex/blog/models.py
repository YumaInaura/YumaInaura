from django.db import models

class Hello(models.Model):
    your_name = models.CharField(max_length=10)

    def __str__(self):
        return "<{0}>".format(self.your_name)

