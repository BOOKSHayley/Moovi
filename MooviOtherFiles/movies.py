from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from urllib.parse import urljoin, urlparse
import time
from random import randint
import re


class Movie:
    def __init__(self, title, image, mpaaRate, genres, runtime, rating, synopsis, year):
        self.title = title.replace("\n", "")
        self.img = image.replace("\n", "")
        self.mpaa = mpaaRate.replace("\n", "")
        self.genres = genres.replace("\n", "")
        self.runtime = runtime.replace("\n", "")
        self.rating = rating.replace("\n", "")
        self.synposis = synopsis.replace("\n", "")
        self.year = year.replace("\n", "")
        self.streamingService = "Netflix"

    def print(self):
        return self.title + ";" + self.img + ";" + self.mpaa + ";" + self.rating + ";" + self.runtime + ";" + self.genres + ";" + self.synposis + ";" + self.year + ";" + self.streamingService + "\n"


# Methods

# method consolidating navigating to url and getting the html soup
def selNavTo(driver, url):
    driver.get(url)
    html = driver.page_source
    time.sleep(2)
    return BeautifulSoup(html, 'html.parser')


# Method for random sleeps
def randSleep():
    time.sleep(randint(1, 10))

def getImg(driver, current_url, href):
    new_url = urljoin(current_url, href)
    imageSoup = selNavTo(driver, new_url)

    try:
        next_url = urljoin(new_url, imageSoup.find("a", class_= "ipc-lockup-overlay ipc-focusable").get("href"))
    except:
        return "N/A"
    
    newer_url = urljoin(new_url, next_url)
    secondImageSoup = selNavTo(driver, newer_url)

    try:
        img = secondImageSoup.find("img", "MediaViewerImagestyles__PortraitImage-sc-1qk433p-0").get("src")
    except:
        img = "N/A"

    imageSoup.decompose()
    secondImageSoup.decompose()
    
    return img


# Selenium set up with driver and driver options
options = webdriver.ChromeOptions()
options.add_argument("--ignore-certificate-errors")  # Ignore harmless errors
options.add_argument("-=ignore-ssl-errors")  # Ignore harmless errors
browser = webdriver.Chrome(chrome_options=options,
                           executable_path="C:/Program Files/chromedriver_win32/chromedriver.exe")

# Full list of movies (no repeats)
# title, img, mpaa rating, rating, runtime, genres, synposis
queue = open("queue.txt", "at", encoding="utf-8")
queue.truncate(0)

# Opening the url and getting the html
url = "https://www.imdb.com/search/title/?companies=co0144901"
soup = selNavTo(browser, url)

flag = True

while flag:

    randSleep()
    movies = soup.find("div", id="main").find("div", class_="lister list detail sub-list").find_all("div",class_="lister-item mode-advanced")

    for m in movies:
        mpaa = m.find("span", class_="certificate")
        if mpaa is None or mpaa is not None and "TV" in mpaa.text:
            continue
        randSleep()

        mpaaRate = mpaa.text

        if m.find("h3", class_="lister-item-header").find("a") is not None:
            h3 = m.find("h3", class_="lister-item-header")
            name = h3.find("a").text.strip("\n")
            imgUrl1 = h3.find("a").get("href")
            img = getImg(browser, url, imgUrl1)
            year = h3.find("span", class_= "lister-item-year").text.strip("\n")
        else:
            continue  # Need to continue to next one if there is no movie name

        if m.find("span", class_="genre") is not None:
            genres = m.find("span", class_="genre").text.strip("\n")
        else:
            genres = ""

        if m.find("span", class_="runtime") is not None:
            runtime = m.find("span", class_="runtime").text.strip("\n")
        else:
            runtime = "Not Available"

        if m.find("div", class_="inline-block ratings-imdb-rating") != None:
            rating = m.find("div", class_="inline-block ratings-imdb-rating")['data-value']
        else:
            rating = "Not Available"

        if m.select("p:nth-of-type(2)")[0] is not None:
            synopsis = m.select("p:nth-of-type(2)")[0].text
        else:
            synopsis = "Not Available"
        finished_movie = Movie(name, img, mpaaRate, genres, runtime, rating, synopsis, year)
        queue.write(finished_movie.print())
        # whichFiles(finished_movie) #write to files based on genre

    new_url = soup.find("div", id="main").find("div", class_="desc").find("a", text=re.compile(r'Next'))
    if new_url is not None:  # Scrape the next page
        print("new page")
        new_url = urljoin(url, new_url["href"])
        soup.decompose()
        soup = selNavTo(browser, new_url)
    else:  # No more pages to scrape
        print("No more!")
        flag = False

queue.close()
soup.decompose()
browser.close()