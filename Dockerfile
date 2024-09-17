FROM python:3.8

COPY requirements.txt /requirements.txt
COPY app/app.py /app/app.py
COPY app/models.py /app/models.py
COPY app/templates /app/templates

RUN pip install --upgrade pip && pip install -r /requirements.txt

WORKDIR /app/

ENV FLASK_APP app.py

RUN flask db init \
    && flask db migrate -m "Create guests." \
    && flask db upgrade

EXPOSE 5000

CMD flask run -h 0.0.0.0 -p 5000