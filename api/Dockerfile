FROM akshay090/face_recognition:latest

# Set the locale
ENV LANG=C.UTF-8  
ENV LC_ALL=C.UTF-8

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install -r requirements.txt

EXPOSE 80

COPY . /app

CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "80", "--reload"]
