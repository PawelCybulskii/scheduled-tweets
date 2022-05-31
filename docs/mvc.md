# The Model View Controller (MVC) Pattern

GET /about HTTP/1.1
Host: 127.0.0.1

## Routes
Matchers for the URL that is respected

GET for "/about"

I see you requested "/about", we'll give that to the About controller to handle

## Models
Database wrapper

User
  query for recods
  wrap individual records (np. username musi mieć minimum 3 znaki)
  

## Views
Your response body content
HTML
CSV
XML
PDF
This is what get back to the browser and display

## Controllers
Decide ho to process a request and define a response (np. hasło było za krótkie)
