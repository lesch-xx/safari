# Transform Safari portal dashboard

<details>
  <summary>How to expand all itineraries</summary>

1. Go to Safari Dashboard.
> [!WARNING]
>
> Refresh the page if it has been open already.

2. Open Web Developer Tools in Firefox (Inspect)
3. Switch to Console tab
4. Execute the following command at the bottom input marked with >>
```
$x('//table/tbody//button[@data-action="click->stream-toggler#toggle"]').forEach((button) => button.click());
```
5. All country groups should be open after some time
6. Close Web Developer Tools
7. Save the page. See instructions below
</details>

<details>
  <summary>How to save web page</summary>

1. Click right button to open context menu
2. Select SingleFile - Save Page with SingleFile
3. Save page to project `data` folder as `Dashboard-Planning.html`
4. Open terminal to process saved page. See instructions below
</details>

<details>
  <summary>How to transform saved page</summary>

1. Open Terminal in project folder
```
cd /Users/<username>/Projects/safari
```
2. Execute the following command to transform saved page
```bash
xsltproc --html --huge --output docs/index.html itineraries-by-country.xslt data/Dashboard-Planning.html
```
3. Check transformation result in `docs` folder. DO NOT change `docs` folder name or location due to [GitHub Pages](https://docs.github.com/pages) limitation.
4. Close Terminal

> [!TIP]
>
> XPath functions reference available [here](https://developer.mozilla.org/en-US/docs/Web/XML/XPath/Reference/Functions).
>
> XSLT elements reference available [here](https://developer.mozilla.org/en-US/docs/Web/XML/XSLT/Reference/Element).

</details>

<details>
  <summary>How to update public page</summary>

1. TODO
</details>
