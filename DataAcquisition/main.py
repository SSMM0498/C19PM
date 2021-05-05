import os
import DataExtractor

def search_next(filename):
    filename = filename.replace(".jpg", "")
    filename += "(suite 01).jpg"
    for file in os.listdir("./assets"):
        if (file == filename):
            return filename
    return "null"


images = []
for filename in sorted(os.listdir("./assets"),reverse=True):
    if ("(suite 01)" in filename):
        continue
    else:
        images.append("./assets/"+filename)
        restfilename = search_next(filename)
        if(restfilename != "null"):
            images.append("./assets/" + restfilename)
        print("Extracting " + filename + "...")
        DataExtractor.extract(images)
        images = []