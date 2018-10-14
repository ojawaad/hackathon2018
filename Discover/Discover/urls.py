from django.contrib import admin
from django.conf.urls import url, include
from Mappy import views
from django.contrib.staticfiles.views import serve
from django.views.decorators.csrf import ensure_csrf_cookie
from rest_framework.urlpatterns import format_suffix_patterns


# Authentication API patterns
auth_apipatterns = [
	# url(r'^login/$', views.LoginView.as_view()),
	# url(r'^logout/$', views.LogoutView.as_view()),
]

discover_apipatterns = [
	url(r'^notifications/$', views.NotificationList.as_view()),
	url(r'^notifications/(?P<pk>[0-9]+)/$', views.NotificationDetail.as_view()),
	url(r'^users/$', views.UserList.as_view()),
	url(r'^Users/(?P<pk>[0-9]+)/$', views.UserDetail.as_view()),
	url(r'^parkingzone/$', views.ParkingZoneList.as_view()),
	url(r'^parkingzone/(?P<pk>[0-9]+)/$', views.ParkingZoneDetail.as_view()),

]

apipatterns = [
	url(r'^authenticate/', include(format_suffix_patterns(auth_apipatterns))),
	url(r'^discover/', include(format_suffix_patterns(discover_apipatterns)))
]

urlpatterns = [
	url(r'^admin/', admin.site.urls, name='admin'),
	url(r'^api/', include(apipatterns)),
]
