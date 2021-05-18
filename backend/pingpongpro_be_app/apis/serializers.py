from django.db import models
from rest_framework import serializers
from .models import Sensors

class SensorsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model= Sensors
        fileds = ('xaccele','yaccele','zaccele','xgyro','ygyro','zgyro','timestemp')