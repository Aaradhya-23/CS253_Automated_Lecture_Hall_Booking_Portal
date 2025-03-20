from rest_framework import permissions

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
            # Allow read access to all roles
            return True
        
        
        elif not request.user.is_authenticated:
            return False
        elif request.method in ['POST']:
            return request.user.role in ['admin', 'Faculty', 'Student']
        
        elif request.method in ['PUT', 'PATCH']:
            # Allow write access to admin only, no updates, delete and then recreate booking
            return False
        
        elif request.method == 'DELETE':
            # Allow delete access only to admin
            return request.user.role in ['admin', 'Faculty', 'Student']
        
        return False
    
    def has_object_permission(self, request, view, obj):
         # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True
        
        #only delete pending or canncelled requests 
        
        if(obj.status not in ['pending', 'cancelled']):
            return False
        
        if(request.user.role == 'admin'):return True
        else: return obj.creator == request.user



# //room permission is admin
    