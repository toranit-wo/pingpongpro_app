from django.db import models

# Create your models here.
class Sensors(models.Model):
    xaccele = models.FloatField()
    yaccele = models.FloatField()
    zaccele = models.FloatField()
    xgyro = models.FloatField()
    ygyro = models.FloatField()
    zgyro = models.FloatField()
    timestemp = models.TimeField()

    def __str__(self):
        return self.timestemp