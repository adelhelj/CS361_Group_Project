# Cat Fact Microservice 🐱🖹💻

The Random Cat Fact microservice is a microservice that returns one random cat
fact upon a consumer's request. This microservice was designed to be consumed by
James Adelhelm's project, Cat Eats.

This microservice uses the text file, `comms.txt` as the communication pipe.
The aforementioned text file is located within the cat_facts project directory.

In order to **REQUEST a random cat fact** from it, consumers must:
- write `fact` in the `comms.txt` file,
- wait *3* seconds

An example REQUEST from my partner's Python app to this microservice. Assuming
that my partner's project is nested two directories within the `project_teamwork`
root directory.

```python
...
COMMUNICATION_PATH = "../../cat_facts/comms.txt"

with open(COMMUNICATION_PATH, "w") as comms_file: 
    comms_file.write("fact")
    time.sleep(3)
    
    ...    
```

In order to **RECEIVE a random cat fact** from this microservice, you must 
perform the above-stated actions and then:

- read the line from the aforementioned text file to get the random cat fact

Below is an example of receiving a random cat fact from this microservice
in a python app:

```python
...
with open(COMMUNICATION_PATH) as comms_file:
    cat_fact_msg = comms_file.readline()
if not cat_fact_msg:
    continue

# do work to show cat fact to Cat Eats User 
```

[//]: # (NEED UML Sequence diagram showing how requesting and receiving data work)

## UML Sequence Diagram for the Cat Fact Microservice

<img src="https://i.imgur.com/SMUR8v2.png"
    alt="UML Sequence Diagram for Cat Fact Microservice"
    style="float: left; margin-right: 10px;" />
