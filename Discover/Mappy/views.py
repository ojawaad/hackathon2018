from django.shortcuts import render
from . import models
from . import serializers


from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import AnonymousUser, Permission, User, Group
from django.http import HttpResponse
from rest_framework import permissions, generics
from rest_framework.exceptions import NotAuthenticated
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response


# Create your views here.

class NotificationList(
	generics.ListCreateAPIView):
	queryset = models.Notification.objects.all()
	serializer_class = serializers.NotificationSerializer
