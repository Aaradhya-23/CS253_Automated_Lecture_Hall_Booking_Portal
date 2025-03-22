from rest_framework import permissions

class Issameuser(permissions.BasePermission):
    def has_permission(self, request, view):
        return super().has_permission(request, view)
    def has_object_permission(self, request, view, obj):
        return super().has_object_permission(request, view, obj)
    

class IsAdmin(permissions.BasePermission):
    def has_permission(self, request, view):
        return request.user.role == 'admin'

class IsFaculty(permissions.BasePermission):
    def has_permission(self, request, view):
        return request.user.role == 'Faculty'

class IsStudent(permissions.BasePermission):
    
    def has_permission(self, request, view):
        return request.user.role == 'Student'

 
class BookingPermissions(permissions.BasePermission):
    """Custom permission class for role-based access control."""
    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return True
        
        
        if request.user.is_authenticated:
            return True
        else: return False
        
    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
        if(request.user.role == 'admin'):return True
        else: return obj.creator == request.user

# //room permission is admin
    