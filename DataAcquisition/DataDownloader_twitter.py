import twint
import sys

def isvalidDate(date_string):
    isvalid = False
    date_list = date_string.split(sep="-")
    isvalid = (len(date_list) == 3 and len(date_list[0]) == 4 and  len(date_list[1]) == 2 and  len(date_list[2]) == 2)
    return isvalid

def getLimit(limit_string):
    limit = False
    if(limit_string == '-l' or limit_string == '-L' or limit_string == '--limit_string' or limit_string == '--limit'):
        limit = True
    return limit

def getCommunique(date, interval= False):
    print('Récupération des tweets ...')
    try:
        config = twint.Config()
        config.Username = "MinisteredelaS1"
        config.Search = "Communiqué"
        config.Since = date
        config.Media = True
        config.Output = "result.json"
        config.Store_json = True
        if(interval):
            config.Limit = 1
        twint.run.Search(config)
        print(config.Limit)
        print('Tweets récupérer avec succés')
    except:
        print("Erreur lors de la récupération de tweets")



def Main():
    if(len(sys.argv) == 2):
        if(isvalidDate(sys.argv[1])):
            getCommunique(sys.argv[1])
        else:
            print("Le format de la date est incorrect. Réessayer avec  ce format: YYYY-MM-DD")

    if(len(sys.argv) == 3):
        if(isvalidDate(sys.argv[1]) and getLimit(sys.argv[2])):
            getCommunique(sys.argv[1], getLimit(sys.argv[2]))
        else:
            print("Le format de la date est incorrect. Réessayer avec  ce format: YYYY-MM-DD")
            print("Ou bien le format de la limite")

Main()