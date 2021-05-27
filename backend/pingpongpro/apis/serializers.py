from rest_framework import serializers
from pingponghit import models


class PingponghitSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'title',
            'data'
        )
        model = models.Pingponghit
