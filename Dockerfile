FROM ruby:2.3.1

# VOLUME /app
ADD . /app

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
