from django.db import models
from django.db.models import fields
from rest_framework import serializers
from .models import Sensors

class SensorsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model= Sensors
        #fileds = ('xaccele','yaccele','zaccele','xgyro','ygyro','zgyro','timestemp')
        fields = '__all__'