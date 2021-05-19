from django.shortcuts import render
from rest_framework import viewsets

# Create your views here.
from .serializers import SensorsSerializer
from .models import Sensors

class SensorsViewSet(viewsets.ModelViewSet):
    queryset = Sensors.objects.all()
    serializer_class = SensorsSerializer