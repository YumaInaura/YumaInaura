from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('articles/', include('articles.urls')),
    path('admin/', admin.site.urls),
]