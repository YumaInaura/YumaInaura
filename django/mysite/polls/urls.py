from django.urls import path

from . import views
from polls.views import SomeUpdateView


app_name = 'polls'
urlpatterns = [
    path('', views.IndexView.as_view(), name='index'),
    path('<int:pk>/', views.DetailView.as_view(), name='detail'),
    path('<int:question_id>/', views.DetailView.as_view(), name='detail'),
    path('<int:mainid>/<int:secondid>', views.detail, name='detail'),
    path('<int:pk>/update/', SomeUpdateView.as_view(), name='update'),
    path('<int:pk>/results/', views.ResultsView.as_view(), name='results'),
    path('<int:question_id>/vote/', views.vote, name='vote'),
]