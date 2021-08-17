from rest_framework import serializers
from pingponghit import models


class PingponghitSerializer(serializers.Serializer):
    class Meta:
        fields = (
            'id',
            'title',
            'data'
        )
        model = models.Pingponghit
