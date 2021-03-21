from PIL import Image
import DataExtractor

# images = DataExtractor.pdfToImage('fic7.pdf') <-- works if you have fitz
images = ["image1_1.png","image2_1.png"]

# initialize empty  text
text = ''

# Extract the text of all images in a pdf file and concat them
for image in images:
    text += DataExtractor.getText(image)
text = text.lower()

# Get and print date
o = DataExtractor.getDate(text)
text = text[o["endIndex"]:-1]
print(o['date'])

# get and print total of tests
o = DataExtractor.getTests(text)
print(o['numbers'])
text = text[o["endIndex"]:-1]

# get and print number of contact cases
o = DataExtractor.getCasContact(text)
print(o['number'])
text = text[o["endIndex"]:-1]

# get and print number of communautary cases
o = DataExtractor.getCasCom(text)
print(o['number'])
text = text[o["endIndex"]:-1]

# Truncate text to listing of cases per city
try:
    text = text[text.index("comme suit")+12:]
except:
    try:
        text = text[text.index(":")+1:-1]
    except:
        print('Unable to Gather More Information!')

# get and print array of location and there number of cases
print(DataExtractor.getCityCases(text))
