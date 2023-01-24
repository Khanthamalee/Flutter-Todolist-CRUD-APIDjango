from rest_framework import serializers
from .models import Todollist

class TodolistSerializer(serializers.ModelSerializer):
    class Meta:
        model = Todollist
        fields = ('id','date','title','detail')