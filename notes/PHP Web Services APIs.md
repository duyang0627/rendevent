# PHP Web Services APIs

## Chapter 1 HTTP

cURL: command line tool for URLs
```
curl http://requestb.in/example
```
send a POST request
```
curl -X POST http://requestb.in/example
```
verbose mode(display headers to STDERR) with POST key-value pairs, the body
of the message will be like `name=Lorna&email=lorna@example.com`:
```
curl -v -X POST http://requestb.in/example -d name="Lorna" -d
    email="lorna@example.com" -d message="this HTTP stuff is rather excellent"
```
Silence the progress bar(cURL shows a progress output bar if it realizes it is
not outputting to a terminal), "2>&1" means redirect STDERR to STDOUT. So header
information is also transferred to `less`.
```
curl -s -v http://requestb.in/example 2>&1 | less
```
Send data through a file:(data.txt: `name=Lorna&email=lorna@example.com`)
```
curl -X POST http://requestb.in/example -d @data.txt
```
Set the header:
```
curl -H "Accept: text/html" http://requestb.in/example
```
To receive and store cookies
```
curl -c cookiejar.txt http://requestb.in/example
```

To send cookies:
```
curl -b cookiejar.txt http://requestb.in/example
```
**Doing HTTP with PHP**

PHP's cURL extension, example:
```php
<?php
$url = "http://www.lornajane.net/";
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);//don't print return value to screen
$result = curl_exec($ch);
curl_close($ch);
?>
```
Post json data:
```php
<?php
$url = "http://requestb.in/example";
$data = ["name" => "Lorna", "email" => "lorna@example.com"];
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json'] );
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$result = curl_exec($ch);
curl_close($ch);
?>
```

Use PHP's stream file function:
```php
<?php
$url = "http://requestb.in/example";
$data = ["name" => "Lorna", "email" => "lorna@example.com"];
$context = stream_context_create([
    'http' => [
        'method' => 'POST',
        'header' => ['Accept: application/json', 'Content-Type: application/json'],
        'content' => json_encode($data)
    ]
    ]);
$result = file_get_contents($url, false, $context);
```

## HTTP Verbs

Make GET request with PHP:
```php
<?php
$url = 'http://localhost/book/get-form-page.php';
$data = ["category" => "technology", "rows" => 20];
$get_addr = $url . '?' . http_build_query($data);
$page = file_get_contents($get_addr);
echo $page;
?>
```
An example POST request header(notice Content-Length and Content-Type)
```
POST /book/post-form-page.php HTTP/1.1
Host: localhost
Content-Length: 48
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Content-Type: application/x-www-form-urlencoded
Accept-Encoding: gzip,deflate,sdch
Accept-Language: en-GB,en-US;q=0.8,en;q=0.6
Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3
email=lorna%40example.com&display_name=LornaJane
```
Make POST request:
```php
<?php
$url = 'http://localhost/book/post-form-page.php';
$data = ["email" => "lorna@example.com", "display_name" => "LornaJane"];
$options = ["http" =>
    [
        "method" => "POST",
        "header" => "Content-Type: application/x-www-form-urlencoded",
        "content" => http_build_query($data)
    ]
];
$page = file_get_contents($url, NULL, stream_context_create($options));
echo $page;
?>
```

Send a DELETE request using cURL extension:
```php
<?php
$url = 'http://localhost/book/example-delete.php';
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
curl_exec($ch);
```

Respond a PUT request:
```php
<?php
if($_SERVER['REQUEST_METHOD'] == "PUT") {
    $data = [];
    $incoming = file_get_contents("php://input");
    parse_str($incoming, $data);
    echo "New user email: " . filter_var($data["email"], FILTER_VALIDATE_EMAIL);
} else {
    echo "The request did not use a PUT method";
}
```

Issue a PUT request using Guzzle library:
```php
<?php
require "vendor/autoload.php";
$url = "http://localhost/book/put-form-page.php";
$data = ["email" => "lorna@example.com", "display_name" => "LornaJane"];
$client = new \GuzzleHttp\Client();
$result = $client->put($url, [
    "headers" => ["Content-Type" => "application/x-www-form-urlencoded"],
    "body" => http_build_query($data)
]);
echo $result->getBody();
```

## Chapter 3 Headers

Some header types:
- **Request Headers**: User-Agent , Accept , Authorization , and Cookie
- **Response Headers**: Set-Cookie
- **Entity Headers**: Content-Type and Content-Length

Check the request header:
```php
<?php
echo "This request made by: " .
    filter_var($_SERVER['HTTP_USER_AGENT'], FILTER_SANITIZE_STRING);
```

Header for content negotiation:
```
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,
*/*;q=0.8
```
q stands for how much a particular option is preferred.

See pg 31-33 for example on how to handle accepted content-type.

#### Authentication

**HTTP basic authentication:**
1. Arrange the username and password into the format username:password .
2. Base64 encode the result.
3. Send it in the header, like this: Authorization: Basic base64-encoded string .
4. Since tokens are sent in plain text, HTTPS should be used throughout.

Issue a basic authentication use PHP's cURL extension:
```php
<?php
$url = "http://localhost/book/basic-auth.php";
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC ) ;
curl_setopt($ch, CURLOPT_USERPWD, "user:pass");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
echo $response;
curl_close($ch);
```

HTTP Digest Authentication: an application of MD5 cryptographic hashing with
 usage of nonce values to prevent replay attacks.

**OAuth**: Should always be used with SSL.
- **consumer**: the app you are trying to sign-in
- **provider**: the service that you already have an account(eg. facebook)

The basic process looks something like this:
1. The user chooses to sign in with GitHub, or link their GitHub account to a third-
party client.
2. The client forwards the user to the provider’s page to sign in and give permission
for this client to access the user’s data.
3. The user does sign in and confirm, and arrives back in the app.
4. The client can then get an access token from the provider.

**Header Caching**: The client stores either an *ETag*(entity tag) or
a *Last-modified* as the key. So when it makes request, it can include this
key to indicate the current version of resource it has locally. Server
returns *304 Not Modified* if the value in client is current.

**Custom Header**: usually prepended with "X-", for example:
 `X-Github-Media-Type`.

## Chapter 4 Cookies

Cookies are sent in request and response. Stored locally as plain text.
Don't trust cookies.

Example of cookie:
```
curl -c cookies.txt http://www.amazon.com/
cat cookies.txt

.amazon.com TRUE / FALSE 1355305311 skin            noskin
.amazon.com TRUE / FALSE 2082787201 session-id-time 2082787201l
```
The format contains the following elements:
- Domain the cookie is valid for
- Whether it is valid for all machines on this domain (usually TRUE)
- Path within the domain that this cookie is valid for
- Whether this cookie is only to be sent over a secure connection
- When this cookie will expire
- Name of the cookie
- Value of the cookie

PHP as server: use `setcookie("key", value)` to set cookies; use `_COOKIE`
to check cookie values;

PHP as client:
```php
<?php
$url = "http://requestb.in/example";
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_COOKIE, "visited=true");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$result = curl_exec($ch);
curl_close($ch);
```

If expiry is not set for a cookie, it becomes a **session cookie**, which means
the cookie expires when user closes the browser.

Stateless design can easily *scale horizontally*: it doesn't matter which server
process the request, as long as each request contains enough information.

## Chapter 5 JSON

json, example:
```
{"message":{"en":"hello friend","es":"hola amigo"}}
{"list":["eggs","bread","milk","bananas","bacon","cheese"]}
```

Remember to set "Content-Type" in header correctly when dealing with json.

Json in PHP:
```php
<?php
echo json_encode(array("message" => "hello you"));//accept array or object

$data = json_decode('{"message":"hello you"}');//return an object
var_dump($data);

$data = json_decode('{"message":"hello you"}', true);//return an array
var_dump($data);
```

Implement interface JsonSerializable to change the behavior of *json_encode*
```php
<?php
class gardenObject implements JsonSerializable
{
    public function jsonSerialize() {
        unset($this->herbs);
        return $this;
    }
}

$garden = new gardenObject();
$garden->flowers = array("clematis", "geranium", "hydrangea");
$garden->herbs = array("mint", "sage", "chives", "rosemary");
$garden->fruit = array("apple", "rhubarb");

echo json_encode($garden);
// {"flowers":["clematis","geranium","hydrangea"],"fruit":["apple","rhubarb"]}
```

A good example: creating a gist on Github gist:(notice that the authentication
type used in header is ***token***, which is used by Github API for OAuth2)
```php
<?php
// grab the access token from an external file to avoid oversharing
require("github-creds.php");

$data = json_encode([
    'description' => 'Gist created by API',
    'public' => 'true',
    'files' => [
        'text.txt' => [ 'content' => 'Some riveting text' ]
    ]
]);

$url = "https://api.github.com/gists";
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
curl_setopt($ch, CURLOPT_HTTPHEADER,
    ['Content-Type: application/javascript',
    'Authorization: token ' . $access_token,
    'User-Agent: php-curl']
);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

$result = curl_exec($ch);
curl_close($ch);

$gist = json_decode($result, true);
if($gist) {
    echo "Your gist is at " . $gist['html_url'];
}
```

## Chapter 6 XML

To create an xml like this:
```xml
<?xml version="1.0"?>
<list>
    <item>eggs</item>
    <item>bread</item>
    <item>milk</item>
    <item>bananas</item>
    <item>bacon</item>
    <item>cheese</item>
</list>
```
The PHP code will be:
```php
<?php
$list = array("eggs", "bread", "milk", "bananas", "bacon", "cheese");
$xml = new SimpleXMLElement("<list />");
foreach($list as $item) {
    $xml->addChild("item", $item);
}

// for nice output
$dom = dom_import_simplexml($xml)->ownerDocument;
$dom->formatOutput = true;
echo $dom->saveXML();
```
Instead, `$xml.asXML() ` will return an XML string, which is in **one** line.

`DOM` has better support for XML namespace than `SimpleXML`.

#### XML in PHP

Three different ways to handle XML in PHP:
1. SimpleXML
2. DOM: more features than SimpleXML
3. XMLReader, XMLWriter, XMLParser: stream based, handle large data

**Creating XML**:
```xml
<?xml version="1.0" ?>
<hotels>
    <hotel name="Queens Hotel">
        <rooms>17</rooms>
        <price>150</price>
    </hotel>
    <hotel name="Kings Hotel">
        <rooms>12</rooms>
        <price>150</price>
    </hotel>
    <hotel name="Grand Hotel">
        <rooms>27</rooms>
        <price>100</price>
    </hotel>
</hotels>
```
Using *SimpleXML*:
```php
<?php
$document = new SimpleXMLElement("<hotels />");

$kings = $document->addChild("hotel");
$kings->addAttribute("name", "Kings Hotel");
$kings->addChild("rooms", 12);
$kings->addChild("price", 150);

...
```
Using *DOM*:
```php
<?php
$document = new DOMDocument();
$hotels = $document->createElement('hotels');
$document->appendChild($hotels);

$kings = $document->createElement("hotel");
$name = $document->createAttribute('name');
$name->value = "Kings Hotel";
$kings->appendChild($name);
$rooms = $document->createElement("rooms", 12);
$kings->appendChild($rooms);
$price = $document->createElement("price", 150);
$kings->appendChild($price);
$hotels->appendChild($kings);

...
```
To convert between *DOM* and *SimpleXML*, use `dom_import_simplexml()` and
`simplexml_import_dom()`.

**Parsing XML**:
```php
<?php
$xml = new SimpleXMLElement(file_get_contents("sample.xml"));
echo("List of Hotels:\n");
foreach($xml->children() as $hotel) {
    echo $hotel['name'];
    echo " has " . $hotel->rooms . " rooms";
    echo " and costs " . $hotel->price. " EUR per night";
    echo "\n";//rooms, price are of type SimpleXMLElement, should cast if return
}
```

## Chapter 7 RPC and SOAP Services

RPC: Remote Procedural Call
- Usually has only one endpoint, all requests are made to the same URL

One example: `http://api.flickr.com/services/rest/?method=flickr.photos.search&tags=
kitten&format=xmlrpc`

`http_response_code(400)` responds code 400 to client.

**SOAP**: simple object access protocol. Defines a formal XML based communication.














<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
```
- REST == Representation State Transfer
- Resource-based
- Representations

6 constraints
1. Uniform Interface
2. Stateless
3. Client-server
4. Cacheable
5. Layered System
6. Code on demand
