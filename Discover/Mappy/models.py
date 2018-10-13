from django.db import models


# Create your models here.
class Notification(models.Model):
    notificationID = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    isResolved = models.BooleanField(default=False)
    description = models.TextField(default="")

class Users(models.Model):
    userID = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    userEmail = models.EmailField(max_length=255,unique=True,verbose_name="Email")

class ParkingZone(models.Model):
    name = models.CharField(primary_key = True, max_length=255)
    # draw in zone
