import requests
from bs4 import BeautifulSoup
import os 

headers = {'User-Agent': 'Mozilla/5.0 (X11; U; Linux i686; fr; rv:1.9.1.1) Gecko/20090715 Firefox/3.5.1'}

def crawl_link(link, tag, class_name):
    response = requests.get(link, headers=headers)
    if response.ok:
        soup = BeautifulSoup(response.text, "html.parser")
        element_list = soup.find_all(tag, {"class": class_name})
    return element_list


def flatten_list(list):
    flatten_list = []
    for sublist in list:
        for item in sublist:
            flatten_list.append(item)
    return flatten_list

def get_links_tag(list):
    link_tag_list = []
    for card_title in list:
        children = card_title.findChildren("a" ,href=True)
        link_tag_list.append(children)
    return link_tag_list

def get_href_attr(tag_list):
    links_with_text = []
    for a in tag_list: 
        if a.text:
            links_with_text.append(a['href'])
    return links_with_text

def get_links(element_list):
    link_tag_list = get_links_tag(element_list)
    link_tag_list = flatten_list(link_tag_list)
    links = get_href_attr(link_tag_list)
    return links

def pdf_download(url, file_name):
    dir_path = os.path.dirname(os.path.realpath(__file__))
    file_path = dir_path+'\\assets\\'+file_name+'.pdf'
    response=requests.get(url, headers=headers)
    expdf=response.content
    egpdf=open(file_path,'wb')
    egpdf.write(expdf)
    egpdf.close()


def download_ressources(communique_list):
    print('Downloading ressources ...')
    for communique in communique_list:
        end = len(communique['title']) - 4
        file_name = communique['title'][0:end]
        if (len(communique['links'])  > 0):
            for index, url in enumerate(communique['links']):
                if(index > 0):
                    file_name = file_name+' (suite 0'+str(index)+')'
                print()
                print('Telechargement du '+file_name+' ...')
                print()
                # pdf_download(url, file_name)
    print('Download finished !!!')
    


print('Scrapping http://www.sante.gouv.sn/actualites ...')
url = 'http://www.sante.gouv.sn/actualites'
card_title_list = crawl_link(url, "h4", "card-title")
links = get_links(card_title_list)
file_span_list = []
url = 'http://www.sante.gouv.sn/'
for link in links:
    file_span = crawl_link(url+link, "span", "file")
    file_span_list.append(file_span)

list_communique = []
for file_span in file_span_list:
    communique = {
        'title': '',
        'links': []
    }
    if (len(file_span) > 0):
        communique['title'] = file_span[0].text
        communique['links'] = get_links(file_span)
    list_communique.append(communique)

download_ressources(list_communique)
print()
print('Il faut décommenter la ligne 64 pour télécharger les pdf')
