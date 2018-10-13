from django.contrib import admin
from django.conf.urls import url, include
from Discover import views

urlpatterns = [
	url(r'^$', views.IndexView.as_view()),
	url(r'^admin/', admin.site.urls, name='admin'),
	url(r'^home', views.IndexView.as_view(), name='home'),
]
