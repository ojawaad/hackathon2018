from . import models
from django.contrib.auth.models import User, Group, Permission
from rest_framework import serializers


class UserSerializer(serializers.ModelSerializer):
	class Meta:
		model = User
		fields = '__all__'


class NotificationSerializer(serializers.ModelSerializer):
	class Meta:
		model = models.Annotation
		fields = '__all__'


class ParkingZoneSerializer(serializers.ModelSerializer):
	class Meta:
		model = models.ParkingZone
		fields = '__all__'
