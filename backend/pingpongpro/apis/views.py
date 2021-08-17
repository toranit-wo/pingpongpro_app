from django.shortcuts import render
from rest_framework import generics

# Create your views here.
from pingponghit import models
from .serializers import PingponghitSerializer


class ListPingponghit(generics.ListCreateAPIView):
    queryset = models.Pingponghit.objects.all()
    serializer_class = PingponghitSerializer


class DetailPingponghit(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Pingponghit.objects.all()
    print('queryset')
    field_name =  'data'
    obj = models.Pingponghit.objects.first()
    field_value = getattr(obj, field_name)
    print(field_value)
    serializer_class = PingponghitSerializer