import face_recognition
from fastapi import FastAPI, File, UploadFile
import glob
import os

app = FastAPI()

def getFileName(path):
    file_name = os.path.splitext(os.path.basename(path))[0]
    return file_name

faces_path = glob.glob("face-dataset/known_faces/*")

names = [getFileName(path) for path in faces_path]

# Load the jpg files into numpy arrays
known_faces = [face_recognition.load_image_file(image) for image in faces_path]

# Get the face encodings for each face in each image file
# Since there could be more than one face in each image, it returns a list of encodings.
# But since I know each image only has one face, I only care about the first encoding in each image, so I grab index 0.
try:
    face_encodings = [ face_recognition.face_encodings(face)[0] for face in known_faces]
except IndexError:
    print("I wasn't able to locate any faces in at least one of the images. Check the image files. Aborting...")
    quit()

@app.post("/recognize/")
def create_upload_file(file: UploadFile = File(...)):
    fileName = file.filename

    unknown_image = face_recognition.load_image_file(file.file)

    try:
        unknown_face_encoding = face_recognition.face_encodings(unknown_image)[0]
    except IndexError:
        print('no face detected in the image')
        return 'NO FACE IN IMAGE'

    # results is an array of True/False telling if the unknown face matched anyone in the known_faces array
    results = face_recognition.compare_faces(face_encodings, unknown_face_encoding)
    matches = [names[index] for index, val in enumerate(results) if val]
    return matches
