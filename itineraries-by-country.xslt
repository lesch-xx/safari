<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" doctype-system="about:legacy-compat" encoding="utf-8" indent="yes" />
  <xsl:strip-space elements="*" />

  <xsl:template match="/">
    <html>
      <head>
        <link rel="stylesheet" href="./styles.css" />
        <title>Safari Itineraries by Country</title>
      </head>
      <body>
        <h2>Safari itineraries by country</h2>
        <xsl:apply-templates />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="head">
    <!-- Ignore input HEAD -->
  </xsl:template>

  <xsl:template match="body">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="nav">
    <!-- Ignore input NAV -->
  </xsl:template>

  <xsl:template match="div[starts-with(@*,'cky-')]">
    <!-- Ignore input Cookie Banner -->
  </xsl:template>

  <xsl:template match="main/turbo-frame[@id='dashboard']">
    <xsl:for-each select="//table/tbody[contains(@data-url, '/proposals')]">
      <table class="itineraries">
        <caption>
          <xsl:value-of select="normalize-space(tr[1]//button[@data-action='click->stream-toggler#toggle']/@title)" />
        </caption>
        <tbody>
          <xsl:call-template name="itineraryRow" />
        </tbody>
      </table>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="itineraryRow">
    <xsl:for-each select="tr[2]//table/tbody/tr">
      <xsl:if test="contains(td[3]//p/text(), '[Generic]')">
        <tr>
          <xsl:call-template name="modifyDateCell" />
          <xsl:call-template name="nameCell" />
          <xsl:call-template name="notesCell" />
          <xsl:call-template name="linkCell" />
        </tr>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="modifyDateCell">
    <td class="modify-date">
      <xsl:value-of select="normalize-space(td[2]/text())" />
    </td>
  </xsl:template>

  <xsl:template name="nameCell">
    <td class="name">
      <xsl:element name="div">
        <xsl:attribute name="title">
            <xsl:value-of select="normalize-space(td[1]//p/text())" />
        </xsl:attribute>
        <xsl:value-of select="normalize-space(td[1]//p/text())" />
      </xsl:element>
    </td>
  </xsl:template>

  <xsl:template name="notesCell">
    <td class="notes">
      <xsl:element name="div">
        <xsl:attribute name="title">
            <xsl:value-of select="normalize-space(td[3]//p/text())" />
        </xsl:attribute>
        <xsl:value-of select="normalize-space(td[3]//p/text())" />
      </xsl:element>
    </td>
  </xsl:template>

  <xsl:template name="linkCell">
    <!-- TODO: missing & < -->
    <!-- NB: $symbolsToReplace and $replaceWithSymbols variable length must match because XPath translate replaces characters at the same index. -->
    <xsl:variable name="symbolsToReplace">~!?@#$%^*_|>–+=()[]{}'`‘"«»:;,.\→</xsl:variable>
    <xsl:variable name="replaceWithSymbols">                                              </xsl:variable>
    <td class="link">
      <xsl:element name="a">
        <xsl:attribute name="alt">Link icon</xsl:attribute>
        <xsl:attribute
          name="href">https://itineraries.htconcierge.co.uk/<xsl:value-of
          select="translate(normalize-space(translate(translate(td[1]//p/text(), '-/’', '   '), $symbolsToReplace, $replaceWithSymbols)), ' ', '-')"
          disable-output-escaping="no" />/<xsl:value-of
          select="substring-after(@id, '_')"
          disable-output-escaping="no"
        /></xsl:attribute>
        <xsl:attribute name="target">_blank</xsl:attribute>
        <xsl:element name="img">
          <xsl:attribute name="src">./images/icon-link.svg</xsl:attribute>
        </xsl:element>
        <span>Link</span>
      </xsl:element>
    </td>
  </xsl:template>

</xsl:stylesheet>
