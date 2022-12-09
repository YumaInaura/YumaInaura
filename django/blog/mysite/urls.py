from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('articles/', include('polls.urls')),
    path('admin/', admin.site.urls),
]