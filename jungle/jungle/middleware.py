class SimpleMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        print(request.user.is_authenticated)

        response = self.get_response(request)

        return response
