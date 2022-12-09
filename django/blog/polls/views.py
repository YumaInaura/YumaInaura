from django.http import HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.urls import reverse
from django.views import generic

from .models import Choice, Question, Article, Comment

class IndexView(generic.ListView):
    template_name = 'articles/index.html'
    context_object_name = 'latest_articles_list'

    def get_queryset(self):
        return Article.objects.order_by('-pub_date')[:5]

def detail(request, article_id):
    article = get_object_or_404(Article, pk=article_id)
    return render(request, 'articles/detail.html', {'article': article})

# class DetailView(generic.DetailView):
#     model = Article
#     template_name = 'articles/detail.html'

class ResultsView(generic.DetailView):
    model = Article
    template_name = 'articles/results.html'

def comment(request, article_id):
    article = get_object_or_404(Article, pk=article_id)

    try:
        Comment.objects.create(article=article, comment_text=request.POST['comment'])
    except (KeyError, Choice.DoesNotExist):
        return render(request, 'articles/detail.html', {
            'article': article,
            'error_message': "Something wrong.",
        })
    else:
        return HttpResponseRedirect(reverse('articles:results', args=(article.id,)))
