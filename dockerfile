FROM python:3.10

COPY . /app
WORKDIR /app

ENV DJANGO_SETTINGS_MODULE config.production

RUN pip install django whitenoise gunicorn psycopg2-binary pytz
RUN python manage.py collectstatic --no-input

EXPOSE 8080

CMD python manage.py migrate && gunicorn config.wsgi:application -b 0.0.0.0:8080