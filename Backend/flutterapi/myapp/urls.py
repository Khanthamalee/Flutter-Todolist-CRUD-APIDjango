from django.urls import path
from .views import Home,get_Todolist,post_Todolist,put_Todolist,delete_Todolist

urlpatterns = [
    path('',Home),
    path('api/get_Todolist/',get_Todolist),
    path('api/post_Todolist',post_Todolist),
    path('api/put_Todolist/<int:PID>',put_Todolist),
    path('api/delete_Todolist/<int:PID>',delete_Todolist),
]