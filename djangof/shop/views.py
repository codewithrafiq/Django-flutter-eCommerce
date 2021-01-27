from .serializers import *
from .models import *
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication


class ProductView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        query = Product.objects.all()
        data = []
        serializers = ProductSerializer(query, many=True)
        for product in serializers.data:
            fab_query = Favorire.objects.filter(
                user=request.user).filter(product_id=product['id'])
            if fab_query:
                product['favorit'] = fab_query[0].isFavorit
            else:
                product['favorit'] = False
            data.append(product)
        return Response(data)
