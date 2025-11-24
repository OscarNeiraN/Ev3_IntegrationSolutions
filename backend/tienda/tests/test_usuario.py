from django.test import TestCase
from django.contrib.auth.models import User

class UsuarioTest(TestCase):
    def test_creacion_usuario(self):
        user = User.objects.create_user(username="oscar", password="1234")
        self.assertEqual(user.username, "oscar")
