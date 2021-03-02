
import Extraction
text = Extraction.getText()
print(Extraction.getDate(text))
print(Extraction.getTests(text))
print(Extraction.getCasContact(text))
print(Extraction.getCasCom(text))
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
