# Inspirational Quote API 💬

The Inspirational Quote API is a microservice that provides a collection of
inspirational quotes to its callers.

In order to **REQUEST an inspirational quote** from this API, make an HTTP GET 
request this endpoint: 

- `/randomQuote`: Get a random inspirational quote

In order to **ADD an inspirational quote** from this API, make an HTTP POST 
request this endpoint: 

- `/quote`: Add a inspirational quote

In order to **GET ALL inspirational quotes** from this API, make an HTTP GET 
request this endpoint: 

- `/quotes`: Gets ALL random inspirational quotes

In order to **UPDATE an inspirational quote** from this API, make an HTTP PUT 
request this endpoint: 

- `/quote/<int:id>`: Update a inspirational quote


To **RECEIVE an inspirational quote** from this API, parse the response as a 
JSON object. Your data will look like this:

```json
"id": 1,
"text": "An example inspirational quote."
"author": "Example"
```
Access the inspirational quote object's text content as you normally would for a 
JSON object. For example, in a Flutter app: 

```dart
...
onPressed: () async {
    var response = await _dio.get("http://10.0.2.2:5000/randomQuote");
    responseData = jsonDecode(response.toString());
    String inspiringQuote = responseData["text"];
}
```

## UML Sequence Diagram for the Inspirational Quote Miccroservice

<img src="https://i.imgur.com/gUbTrOQ.png"
    alt="UML Sequence Diagram for Inspirational Quote Microservice"
    style="float: left; margin-right: 10px;" />

**Note regarding `localhost`**:
[Read here for more info](
https://medium.com/@podcoder/connecting-flutter-application-to-localhost-a1022df63130
)

Be sure that this app has started prior to making requests to it from the device
running your Flutter app.

When running as `localhost`, you must make note to change the base request URL
path for whatever device or emulator (or simulator for iOS) you are running. The
path must match the current device you are on and each path is different whether
you're on Android, iOS, or on a physical device.

The URLs are as follows when making a request to this API:

- Android Emulators: `http://10.0.2.2:5000/`
- iOS Emulators: `http://127.0.0.1/`
