from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from .models import User, Authority, UserAuthority

class UserAuthorityInline(admin.TabularInline):
    """Allows selecting & ordering authorities inside UserAdmin."""
    model = UserAuthority
    extra = 1  # Allow adding new authorities
    ordering = ["order"]
    fields = ["authority", "order"]  # Display order field

class UserAdmin(BaseUserAdmin):  # Extend Django's built-in UserAdmin
    """Customize User model in admin to allow ordered authority selection."""
    inlines = [UserAuthorityInline]  # Add inline for authorities
    list_display = ("username", "email", "role")  # Show email in list
    search_fields = ("username", "email")  # Allow searching by email

    fieldsets = (
        (None, {"fields": ("username", "email", "password")}),
        ("Roles", {"fields": ("role",)}),  # Use role dropdown
    )

    # Ensure email is required when adding a user
    add_fieldsets = (
        (None, {
            "classes": ("wide",),
            "fields": ("username", "email", "password1", "password2", "role"),
        }),
    )

admin.site.register(User, UserAdmin)
admin.site.register(Authority)  # Allow adding predefined authorities
