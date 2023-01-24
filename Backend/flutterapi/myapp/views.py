from django.shortcuts import render
from django.http import JsonResponse
from .serializers import TodolistSerializer
from .models import Todollist
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status


@api_view(['GET'])
def get_Todolist(request):
    gettodolist = Todollist.objects.all()
    serializer = TodolistSerializer(gettodolist,many = True)
    return Response(serializer.data,status=status.HTTP_200_OK)

@api_view(['POST'])
def post_Todolist(request):
    if request.method == 'POST':
        serialzer = TodolistSerializer(data=request.data)
        if serialzer.is_valid():
            serialzer.save()
            return Response(serialzer.data, status=status.HTTP_201_CREATED)
        return Response(serialzer.data,status=status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def put_Todolist(request,PID):
    todo = Todollist.objects.get(id = PID)
    
    if request.method == 'PUT':
        data = {}
        serializer = TodolistSerializer(todo,data=request.data)
        
        if serializer.is_valid():
            serializer.save()
            #data['status']='updated' ที่ post man จะปรากฎ {"status": "updated"}
            data['status']='updated'
            print("serializer :",serializer)
            return Response(data=data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors,status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_Todolist(request,PID):
    todo = Todollist.objects.get(id=PID)

    if request.method == 'DELETE':
        delete = todo.delete()
        
        if delete:
            data = {}
            data['status']='deleted'
            statuscode = status.HTTP_200_OK
        else:
            data['status']='failed'
            statuscode = status.HTTP_400_BAD_REQUEST
        return Response(data=data,status=statuscode)

def Home(request):
    data = [{
    "name1":"ดอกโป๊ยเซียน",
    "image1":"https://raw.githubusercontent.com/Khanthamalee/API_basic/main/asset/flo.jpg",
    "name2":"ดอกทานตะวัน",
    "image2":"https://raw.githubusercontent.com/Khanthamalee/API_basic/main/asset/sunflower.png",
    "name3":"ดอกแพงพวย",
    "image3":"https://raw.githubusercontent.com/Khanthamalee/API_basic/main/asset/watercress.png"
    },
    {
    "name1":"แก๊สหุงต้ม",
    "image1":"https://raw.githubusercontent.com/Khanthamalee/API_basic/main/asset/gas.png",
    "name2":"น้ำดื่ม",
    "image2":"https://raw.githubusercontent.com/Khanthamalee/API_basic/main/asset/water.png",
    "name3":"ส้มเขียวหวาน",
    "image3":"https://raw.githubusercontent.com/Khanthamalee/API_basic/main/asset/Orange.png"
    }]
    #return JsonResponse(data=data) รันแบบลิสไม่ได้ ต้องเพิ่ม safe= False
    #return JsonResponse(data=data,safe=False) มันจะไม่เป็นภาษาไทยเลยต้องใช้ ต้องเพิ่ม 'ensure_ascii':False
    return JsonResponse(data=data,safe=False,json_dumps_params={'ensure_ascii':False})

# Create your views here.
