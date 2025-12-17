from django.shortcuts import render
from django.http import HttpResponse
import requests

# Create your views here.

def home(request):
    template_name ='core/home.html'
    context = {}
    return render(request, template_name, context)

def my_ip():
    ip = requests.get('https://api.ipify.org').text
    return HttpResponse(f"Meu IP público: {ip}")