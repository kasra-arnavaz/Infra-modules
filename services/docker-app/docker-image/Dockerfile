FROM python:3.8
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN pip install -r requirements.txt
ENV FLASK_APP=app.py
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]