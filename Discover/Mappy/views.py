from django.shortcuts import render
from . import models
from . import serializers

from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import AnonymousUser, Permission, User, Group
from django.http import HttpResponse
from rest_framework import permissions, generics
from rest_framework.exceptions import NotAuthenticated
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response

from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView


class NotificationList(
	generics.ListAPIView):
	permission_class = permissions.AllowAny

	queryset = models.Notification.objects.all()
	serializer_class = serializers.NotificationSerializer


class NotificationDetail(
	generics.RetrieveUpdateDestroyAPIView,
	generics.CreateAPIView
):
	queryset = models.Notification.objects.all()
	serializer_class = serializers.NotificationSerializer


class UserList(
	generics.ListAPIView
):
	permission_class = permissions.AllowAny
	queryset = User.objects.all()
	serializer_class = serializers.UserSerializer


class UserDetail(
	generics.RetrieveUpdateDestroyAPIView,
	generics.CreateAPIView
):
	permission_class = permissions.IsAuthenticated
	queryset = User.objects.all()
	serializer_class = serializers.UserSerializer


class ParkingZoneList(
	generics.ListAPIView
):
	permission_class = permissions.AllowAny
	queryset = models.ParkingZone.objects.all()
	serializer_class = serializers.ParkingZoneSerializer


class ParkingZoneDetail(
	generics.RetrieveUpdateDestroyAPIView,
	generics.CreateAPIView
):
	queryset = models.ParkingZone.objects.all()
	serializer_class = serializers.ParkingZoneSerializer

