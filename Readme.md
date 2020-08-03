## [Face Recognition](https://github.com/ageitgey/face_recognition): GPU image with demo api

## Base Image
Pull
```
docker pull akshay090/face_recognition:latest
```

## API Image

Run 
```
docker run --gpus all -it -v ~/akshay/face_recognition:/app -p 80:80 akshay090/face_recognition:gpu-api
```

Test API
```
curl --location t POST 'http://127.0.0.1:80/recognize/' --form 'file=@/home/elon3.jpg'
```
