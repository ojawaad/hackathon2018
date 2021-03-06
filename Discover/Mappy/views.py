from . import models
from . import serializers
from django.contrib.auth.models import AnonymousUser, Permission, User, Group
from rest_framework import permissions, generics, authentication
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
	generics.ListCreateAPIView):
	permission_class = permissions.AllowAny

	queryset = models.Annotation.objects.all()
	serializer_class = serializers.NotificationSerializer


class NotificationDetail(
	generics.RetrieveUpdateDestroyAPIView,
):
	authentication_class = authentication.TokenAuthentication
	queryset = models.Annotation.objects.all()
	serializer_class = serializers.NotificationSerializer


class UserList(
	generics.ListCreateAPIView
):
	permission_class = permissions.AllowAny
	queryset = User.objects.all()
	serializer_class = serializers.UserSerializer


class UserDetail(
	generics.RetrieveUpdateDestroyAPIView,
):
	authentication_class = authentication.TokenAuthentication
	permission_class = permissions.IsAuthenticated
	queryset = User.objects.all()
	serializer_class = serializers.UserSerializer


class ParkingZoneList(
	generics.ListCreateAPIView
):
	permission_class = permissions.AllowAny
	queryset = models.ParkingZone.objects.all()
	serializer_class = serializers.ParkingZoneSerializer


class ParkingZoneDetail(
	generics.RetrieveUpdateDestroyAPIView,
):
	authentication_class = authentication.TokenAuthentication
	queryset = models.ParkingZone.objects.all()
	serializer_class = serializers.ParkingZoneSerializer

