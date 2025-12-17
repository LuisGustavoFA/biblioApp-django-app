from django.urls import path
from . import views

app_name = 'core'

urlpatterns = [
    path('', views.home, name='home'),
    path('my_ip/', views.my_ip, name='my_ip'),
]