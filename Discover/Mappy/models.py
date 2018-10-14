from django.db import models


# Create your models here.
class Annotation(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    longitude = models.DecimalField(max_digits=8, decimal_places=6)
    latitude = models.DecimalField(max_digits=8, decimal_places=6)
    isResolved = models.BooleanField(default=False)
    description = models.TextField(default="")


class ParkingZone(models.Model):
	id = models.AutoField(primary_key=True)
	name = models.CharField(max_length=255)
	timeLimit = models.IntegerField(default=0)
	longitude = models.DecimalField(max_digits=8, decimal_places=6)
	latitude = models.DecimalField(max_digits=8, decimal_places=6)
	radius = models.DecimalField(max_digits=3, decimal_places=2)
