from django.contrib.auth.models import User


def gen_master(apps, schema_editor):
    User.objects.create_superuser(username="admin", password="qwer1234", email="")