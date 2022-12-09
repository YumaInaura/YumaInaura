from django.urls import path

from . import views

app_name = 'articles'
urlpatterns = [
    path('', views.IndexView.as_view(), name='index'),
    path('<int:article_id>/', views.detail, name='detail'),
#    path('<int:pk>/', views.DetailView.as_view(), name='detail'),
    path('<int:pk>/results/', views.ResultsView.as_view(), name='results'),
    path('<int:article_id>/comment/', views.comment, name='comment'),
]