FROM python:3

ENV APP /app
RUN mkdir $APP
WORKDIR $APP

EXPOSE 5002
COPY . .
RUN apt-get clean \
    && apt-get -y update
RUN apt-get -y install nginx \
    && apt-get -y install python3-dev \
    && apt-get -y install build-essential

RUN pip install flask
RUN pip install pillow

RUN pip install -r requirements.txt

# COPY nginx.conf /etc/nginx
# RUN chmod +x ./start.sh
# CMD ["./start.sh"]
CMD [ "uwsgi", "--ini", "app.ini" ]