from django.urls import path

from .views import ListPingponghit, DetailPingponghit

urlpatterns = [
    path('', ListPingponghit.as_view()),
    path('<int:pk>/', DetailPingponghit.as_view())
]
