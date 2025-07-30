<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" doctype-system="about:legacy-compat" encoding="utf-8" indent="yes" />

  <xsl:template match="/">
    <html>
      <head>
        <link rel="stylesheet" href="../styles.css" />
        <title>Safari Itineraries by country</title>
      </head>
      <body>
        <h2>Safari itineraries by country</h2>
        <xsl:for-each select="//body//turbo-frame[@id='dashboard']//table/tbody[contains(@data-url, '/proposals')]">
          <table class="itineraries">
            <caption>
              <xsl:value-of select="tr[1]//button[@data-action='click->stream-toggler#toggle']/@title" />
            </caption>
            <tbody>
              <xsl:for-each select="tr[2]//table/tbody/tr">
                <tr>
                  <td class="modify-date">
                    <xsl:value-of select="td[2]/text()" />
                  </td>
                  <td class="name">
                    <xsl:element name="div">
                      <xsl:attribute name="title">
                          <xsl:value-of select="td[1]//p/text()" />
                      </xsl:attribute>
                      <xsl:value-of select="td[1]//p/text()" />
                    </xsl:element>
                  </td>
                  <td class="notes">
                    <xsl:element name="div">
                      <xsl:attribute name="title">
                          <xsl:value-of select="td[3]//p/text()" />
                      </xsl:attribute>
                      <xsl:value-of select="td[3]//p/text()" />
                    </xsl:element>
                  </td>
                  <td class="link">
                    <xsl:element name="a">
                      <xsl:attribute name="alt">Link icon</xsl:attribute>
                      <xsl:attribute name="href">https://itineraries.htconcierge.co.uk/<xsl:value-of select="td[1]//p/text()" />/<xsl:value-of select="@id" /></xsl:attribute>
                      <xsl:element name="img">
                        <xsl:attribute name="src">../images/icon-link.svg</xsl:attribute>
                      </xsl:element>
                      Link
                    </xsl:element>
                  </td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
