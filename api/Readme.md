Build
```
docker build -t recog_face .
```


Run 
```
docker run --gpus all -it -v ~/akshay/face_recognition:/app --name face_recog-gpu-api -p 80:80 akshay090/face_recognition:gpu-api
```

Pull 
```
docker pull akshay090/face_recognition:gpu-api
```