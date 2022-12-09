from django.http import HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.urls import reverse
from django.views import generic

from .models import Choice, Question, Article

class IndexView(generic.ListView):
    template_name = 'articles/index.html'
    context_object_name = 'latest_articles_list'

    def get_queryset(self):
        return Article.objects.order_by('-pub_date')[:5]

class DetailView(generic.DetailView):
    model = Article
    template_name = 'articles/detail.html'


class ResultsView(generic.DetailView):
    model = Question
    template_name = 'articles/results.html'


def comment(request, article_id):
    article = get_object_or_404(Article, pk=article_id)

    try:
        new_comment = article.comment_set.get(pk=request.POST['article'])
    except (KeyError, Choice.DoesNotExist):
        return render(request, 'articles/detail.html', {
            'article': article,
            'error_message': "Something wrong.",
        })
    else:
        new_comment.comment_text = request.POST['comment']
        new_comment.save()
        return HttpResponseRedirect(reverse('polls:results', args=(article.id,)))


def vote(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    try:
        selected_choice = question.choice_set.get(pk=request.POST['choice'])
    except (KeyError, Choice.DoesNotExist):
        # Redisplay the question voting form.
        return render(request, 'polls/detail.html', {
            'question': question,
            'error_message': "You didn't select a choice.",
        })
    else:
        selected_choice.votes += 1
        selected_choice.save()
        # Always return an HttpResponseRedirect after successfully dealing
        # with POST data. This prevents data from being posted twice if a
        # user hits the Back button.
        return HttpResponseRedirect(reverse('polls:results', args=(question.id,)))

