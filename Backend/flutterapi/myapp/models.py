from django.db import models


class Todollist(models.Model):
    date = models.DateField()
    title = models.CharField(max_length=200)
    detail = models.TextField(null=True,blank=True)
    def __str__(self):
        return self.title


