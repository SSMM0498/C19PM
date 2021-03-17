import DataExtractor
images = DataExtractor.pdfToImage('fic7.pdf')
text = ''
for image in images:
    text += DataExtractor.getText(image)
text = text.lower()

# o = DataExtractor.getDate(text)
# text = text[o["endIndex"]:-1]
# print(o['date'])

o = DataExtractor.getTests(text)
print(o['numbers'])
text = text[o["endIndex"]:-1]

o = DataExtractor.getCasContact(text)
print(o['number'])
text = text[o["endIndex"]:-1]

o = DataExtractor.getCasCom(text)
print(o['number'])
text = text[o["endIndex"]:-1]
try:
    text = text[text.index("comme suit")+12:]
except:
    try:
        text = text[text.index(":")+1:-1]
    except:
        print('Unable to Gather More Information!')
print(text)
print(DataExtractor.getCityCases(text))

# print(text)
# fic = {
#     "Annee": 2020,
#     "Mois": "Mars",
#     "date1" = {
#         "NbTest" : 45,
#         "NbNouveauxCas" : 20,
#         "localites" : {
#             "localite1" : 2,
#         }
#     },
#     "date2" = {
#         "NbTest" : 45,
#         "NbNouveauxCas" : 20
#     }
# }
