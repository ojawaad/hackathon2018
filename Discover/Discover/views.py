from django.shortcuts import render
from django.views.generic import TemplateView
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth import authenticate, login


class IndexView(TemplateView):
	def get(self, request, **kwargs):
		return render(request, 'index.html', context=None)
