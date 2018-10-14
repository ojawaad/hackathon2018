from django.shortcuts import render
from . import models
from . import serializers

from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import AnonymousUser, Permission, User, Group
from django.http import HttpResponse
from rest_framework import permissions, generics
from django.contrib.auth import authenticate
from django.views.decorators.csrf import csrf_exempt
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework import status
from rest_framework.response import Response

@csrf_exempt
@api_view(["POST"])
@permission_classes((AllowAny,))
def login(request):
    username = request.data.get("username")
    password = request.data.get("password")
    if username is None or password is None:
        return Response({'error': 'Please provide both username and password'},
                        status=status.HTTP_400_BAD_REQUEST)
    user = authenticate(username=username, password=password)
    if not user:
        return Response({'error': 'Invalid Credentials'},
                        status=status.HTTP_404_NOT_FOUND)
    token, _ = Token.objects.get_or_create(user=user)
    return Response({'token': token.key},
                    status=status.HTTP_200_OK)



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

