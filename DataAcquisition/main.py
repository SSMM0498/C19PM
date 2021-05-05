from PIL import Image
import DataExtractor
#  export TESSDATA_PREFIX=/Users/bemax/Documents/DIC2/SEM1/Sgbd/tessdata
# images = DataExtractor.pdfToImage('fic7.pdf') <-- works if you have fitz
# images = ["./env/image1_1.png","./env/image2_1.png"]
# images = ["./env/image3_1.jpeg","./env/image4_1.jpeg"]
# images = ["./env/1.jpeg","./env/2.jpeg"]
# images = ["./env/3.jpeg"]
# images = ["./assets/2021-05-1.jpg"]
# images = ["./assets/2021-04-17.jpg","./assets/2021-04-17(suite 01).jpg"]
images = ["./assets/2021-05-01.jpg","./assets/2021-05-01(suite 01).jpg"]

DataExtractor.extract(images)