# Transform Safari portal dashboard

### How to expand all itineraries
1. Open Web Developer Tools in Firefox
2.
```
$x('//table/tbody//button[@data-action="click->stream-toggler#toggle"]').forEach((button) => button.click());
```

### How to save web page
1.

### How to transform saved page
1. Open Terminal
2. 
```bash
$ xsltproc --html --huge --output itineraries-by-country.html itineraries-by-country.xslt Dashboard-Planning.html
```
