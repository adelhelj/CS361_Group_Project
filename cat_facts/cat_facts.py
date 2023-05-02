import time
import requests
from random import randint


CAT_FACTS_ENDPOINT = "https://cat-fact.herokuapp.com/facts/"
CAT_PARAMS = {
    "animal_type": "cat",
    "amount": 10
}
COMMUNICATION_FILE = "comms.txt"


def get_fact():
    response = requests.get(CAT_FACTS_ENDPOINT, params=CAT_PARAMS)
    n = len(response.json())
    return response.json()[randint(0, n)]["text"]


if __name__ == "__main__":
    while True:
        time.sleep(3)
        with open("comms.txt") as file:
            msg = file.readline()
        if not msg:
            continue
        elif msg != "fact":
            continue

        cat_fact = get_fact()
        print(cat_fact)

        with open("comms.txt", "w") as file:
            file.write(cat_fact)