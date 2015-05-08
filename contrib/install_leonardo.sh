#!/bin/bash

virtualenv -p /usr/bin/python2.7 leonardo_venv
cd leonardo_venv
. $PWD/bin/activate

pip install django-leonardo>=2015.0.4.dev17

django-admin startproject --template=https://github.com/django-leonardo/site-template/archive/master.zip myproject

export PYTHONPATH=$PWD/myproject
echo $PYTHONPATH
cd ./myproject

python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py sync_all

echo "from django.contrib.auth.models import User; User.objects.create_superuser('root', 'mail@leonardo.cz', 'admin')" | python manage.py shell

python manage.py runserver 0.0.0.0:80
