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
        <img class="logo" src="./images/logo.png" />
        <h2>Safari itineraries by country</h2>
        <xsl:apply-templates />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="body">
    <xsl:apply-templates />
  </xsl:template>

  <!-- DO NOT process the following nodes: HEAD, NAV, Cookie Banner, etc. -->
  <xsl:template match="head" />
  <xsl:template match="nav" />
  <xsl:template match="div[starts-with(@*,'cky-')]" />

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
      <xsl:variable name="notesText" select="normalize-space(td[3]//p/text())" />
      <xsl:if test="contains($notesText, '[Generic]')">
        <tr>
          <xsl:call-template name="textCell">
            <xsl:with-param name="cssClass">modify-date</xsl:with-param>
            <xsl:with-param name="text" select="normalize-space(td[2]/text())" />
          </xsl:call-template>
          <xsl:call-template name="textCell">
            <xsl:with-param name="cssClass">name</xsl:with-param>
            <xsl:with-param name="text" select="normalize-space(td[1]//p/text())" />
          </xsl:call-template>
          <xsl:call-template name="textCell">
            <xsl:with-param name="cssClass">notes</xsl:with-param>
            <xsl:with-param name="text" select="$notesText" />
          </xsl:call-template>
          <xsl:call-template name="linkCell">
            <xsl:with-param name="notesText" select="$notesText" />
          </xsl:call-template>
        </tr>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!-- Generic text cell template. Used for date, name, notes, etc. -->
  <xsl:template name="textCell">
    <xsl:param name="cssClass" />
    <xsl:param name="text" />
    <xsl:element name="td">
      <xsl:attribute name="class">
        <xsl:value-of select="$cssClass" />
      </xsl:attribute>
      <xsl:element name="span">
        <xsl:attribute name="title">
            <xsl:value-of select="$text" />
        </xsl:attribute>
        <xsl:value-of select="$text" />
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- Specific link cell template -->
  <xsl:template name="linkCell">
    <xsl:param name="notesText" />
    <!-- TODO: missing '&' and '<' chars -->
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
        /><xsl:if test="contains($notesText, '[Lookbook]')">?type=lookbook</xsl:if></xsl:attribute>
        <xsl:attribute name="target">_blank</xsl:attribute>
        <img src="./images/icon-link.svg" />
        <span>Link</span>
      </xsl:element>
    </td>
  </xsl:template>

</xsl:stylesheet>
