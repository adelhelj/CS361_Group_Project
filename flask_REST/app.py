from flask import Flask, request, jsonify
from random import randint
# Imports necessary libraries for Flask and random numbers


# Initializesa the Flask app
app = Flask(__name__)

# Stores a list of quotes with the id, text and author of the quote
QUOTES = [
    {
        "id": 1,
        "text": "Genius is one percent inspiration and ninety-nine percent perspiration.",
        "author": "Thomas Edison"
    },
    {
        "id": 2,
        "text": "You can observe a lot just by watching.",
        "author": "Yogi Berra"
    },
    {
        "id": 3,
        "text": "A house divided against itself cannot stand.",
        "author": "Abraham Lincoln"
    },
    {
        "id": 4,
        "text": "Difficulties increase the nearer we get to the goal.",
        "author": "Johann Wolfgang von Goethe"
    },
    {
        "id": 5,
        "text": "Fate is in your hands and no one elses",
        "author": "Byron Pulsifer"
    },
    {
        "id": 6,
        "text": "Be the chief but never the lord.",
        "author": "Lao Tzu"
    },
    {
        "id": 7,
        "text": "Nothing happens unless first we dream.",
        "author": "Carl Sandburg"
    },
    {
        "id": 8,
        "text": "Well begun is half done.",
        "author": "Aristotle"
    },
    {
        "id": 9,
        "text": "It's not the load that breaks you down, it's the way you carry it.",
        "author": "Lou Holtz"
    },
    {
        "id": 10,
        "text": "It is during our darkest moments that we must focus to see the light.",
        "author": "Aristotle"
    },
    {
        "id": 11,
        "text": "Be yourself; everyone else is already taken.",
        "author": "Oscar Wilde"
    },
    {
        "id": 12,
        "text": "No one can make you feel inferior without your consent.",
        "author": "Eleanor Roosevelt"
    },
    {
        "id": 13,
        "text": "The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.",
        "author": "Helen Keller"
    },
    {
        "id": 14,
        "text": "The only way to do great work is to love what you do.",
        "author": "Steve Jobs"
    },
    {
        "id": 15,
        "text": "Start where you are. Use what you have. Do what you can.",
        "author": "Arthur Ashe"
    },
    {
        "id": 16,
        "text": "Yesterday is history, tomorrow is a mystery, but today is a gift. That is why it is called the present.",
        "author": "Master Oogway"
    },
    {
        "id": 17,
        "text": "Life is not about finding yourself. Life is about creating yourself.",
        "author": "George Bernard Shaw"
    },
    {
        "id": 18,
        "text": "Success is not final, failure is not fatal: it is the courage to continue that counts.",
        "author": "Winston Churchill"
    },
    {
        "id": 19,
        "text": "Life is what we make it, always has been, always will be.",
        "author": "Grandma Moses"
    },
    {
        "id": 20,
        "text": "It does not matter how slowly you go as long as you do not stop.",
        "author": "Confucius"
    },
{
        "id": 21,
        "text": "Life is not a problem to be solved, but a reality to be experienced.",
        "author": "Soren Kierkegaard"
    },
    {
        "id": 22,
        "text": "Success is not final, failure is not fatal: it is the courage to continue that counts.",
        "author": "Winston Churchill"
    },
    {
        "id": 23,
        "text": "Life is 10% what happens to you and 90% how you react to it.",
        "author": "Charles R. Swindoll"
    },
    {
        "id": 24,
        "text": "If you look at what you have in life, you'll always have more.",
        "author": "Oprah Winfrey"
    },
    {
        "id": 25,
        "text": "If you want to lift yourself up, lift up someone else.",
        "author": "Booker T. Washington"
    },
    {
        "id": 26,
        "text": "The biggest adventure you can take is to live the life of your dreams.",
        "author": "Oprah Winfrey"
    },
    {
        "id": 27,
        "text": "If opportunity doesn't knock, build a door.",
        "author": "Milton Berle"
    },
    {
        "id": 28,
        "text": "Happiness is not something readymade. It comes from your own actions.",
        "author": "Dalai Lama"
    },
    {
        "id": 29,
        "text": "I can't change the direction of the wind, but I can adjust my sails to always reach my destination.",
        "author": "Jimmy Dean"
    },
    {
        "id": 30,
        "text": "Always do your best. What you plant now, you will harvest later.",
        "author": "Og Mandino"
    },
]


# def _find_next_id():
#     return max(quote["id"] for quote in QUOTES) + 1

# Get all quotes
@app.get("/quotes")
def get_quotes():
    return jsonify(QUOTES)

# Get a random quote
@app.get("/randomQuote")
def get_random_quote():
    choice = randint(0, len(QUOTES) - 1)
    return jsonify(QUOTES[choice])
    
# Add a new quote
@app.post("/quote")
def add_quote():
    new_quote = request.json
    new_quote["id"] = _find_next_id()
    QUOTES.append(new_quote)
    return jsonify(QUOTES)

# Update an existing quote
@app.put("/quote/<int:id>")
def update_quote(id):
    quote = next((q for q in QUOTES if q["id"] == id), None)
    if quote is None:
        return jsonify({"message": "Quote not found"}), 404

    quote.update(request.json)
    return jsonify(QUOTES)


# Main entry point of the API
@app.route('/')
def welcome():
    return 'Welcome to the Inspirational Quote API'

# Start the Flask server
if __name__ == '__main__':
    app.run()
