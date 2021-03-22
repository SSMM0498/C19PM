import json

with open("decoupage-administratif.json", "r") as read_file:
    data = json.load(read_file)
    regions = []
    for obj in data:
        if (obj["REGION"] in regions):
            continue
        else:
            regions.append(obj["REGION"])
    print(regions)

    departements = []
    for region in regions:
        r = {
            "region": region,
            "departements": []
        }
        for obj in data:
            if ((obj["REGION"] == region) and (obj["DEPARTEMENTS"] not in r["departements"])):
                r["departements"].append(obj["DEPARTEMENTS"])
            else:
                continue
        departements.append(r)
    print(departements)
    communes = []
    for departement in departements:
        r = {
            "region": departement["region"],
            "departements": []
        }
        for dept in departement["departements"]:
            d = {
                "departement": dept,
                "communes": [],
                "arrondissements": [],
                "comard": [],

            }
            for obj in data:
                if ((obj["REGION"] == r["region"]) and (obj["DEPARTEMENTS"] == dept) and (obj["COMMUNES"] not in d["communes"])):
                    if(obj["COMMUNES"]!=''):
                        d["communes"].append(obj["COMMUNES"])
                    else:
                        continue
                else:
                    continue
            for obj in data:
                if ((obj["REGION"] == r["region"]) and (obj["DEPARTEMENTS"] == d["departement"]) and (obj["ARRONDISSEMENTS"] not in d["arrondissements"])):
                    if(obj["ARRONDISSEMENTS"]!=''):
                        d["arrondissements"].append(obj["ARRONDISSEMENTS"])
                    else:
                        continue
                else:
                    continue
            for obj in data:
                if ((obj["REGION"] == r["region"]) and (obj["DEPARTEMENTS"] == d["departement"]) and (obj["C0MMUNESARRDT"] not in d["comard"])):
                    if(obj["C0MMUNESARRDT"]!=''):
                        d["comard"].append(obj["C0MMUNESARRDT"])
                    else:
                        continue
                else:
                    continue
            r["departements"].append(d)
        communes.append(r)
    # print(communes)


    with open("dump.json", "w") as write_file:
        json.dump(communes, write_file,ensure_ascii=False)
        