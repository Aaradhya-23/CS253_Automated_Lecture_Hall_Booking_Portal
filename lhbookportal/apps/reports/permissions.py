from rest_framework import permissions




class DownloadPermissions(permissions.BasePermission):
    def has_permission(self, request, view):
        # return False
        if request.user.is_authenticated:
            return True;
    def has_object_permission(self, request, view, obj):
        # return False
        if request.user.role == 'admin':return True;
        else:  return obj.creator == request.user