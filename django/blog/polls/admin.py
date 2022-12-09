from django.contrib import admin

from .models import Choice, Question, Article, Comment

class ArticleAdmin(admin.ModelAdmin):
    fieldsets = [
        (None,               {'fields': ['article_title']}),
        ('Date information', {'fields': ['pub_date'], 'classes': ['collapse']}),
    ]

class CommentAdmin(admin.ModelAdmin):
    fieldsets = [
        (None,               {'fields': ['comment_text']}),
    ]

class ChoiceInline(admin.StackedInline):
    model = Choice
    extra = 3


class QuestionAdmin(admin.ModelAdmin):
    fieldsets = [
        (None,               {'fields': ['question_text']}),
        ('Date information', {'fields': ['pub_date'], 'classes': ['collapse']}),
    ]
    inlines = [ChoiceInline]
    list_display = ('question_text', 'pub_date', 'was_published_recently')
    list_filter = ['pub_date']
    search_fields = ['question_text']

admin.site.register(Article, ArticleAdmin)
admin.site.register(Comment, CommentAdmin)
admin.site.register(Question, QuestionAdmin)
