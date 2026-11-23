<?xml version="1.0" encoding="UTF-8"?>
<!--
  ImCut toolbar: the user half of the UI (Programs64\Addons\ImCut\UserUI.xslt).

  userConfiguration="true" sends this one to the user's workspace. CorelDRAW applies it once per workspace and
  remembers it there (<Addons><new_element installFile="...UserUI.xslt"/></Addons>), so the bar can be moved or
  hidden afterwards. It docks the toolbar "ImCut" at the top, on its own row right under the Standard toolbar
  (c2b44f69-...), unless the layout has it already. When the layout has no Standard toolbar, nothing is placed and
  ImCut.cpg shows the bar once (Plugin.cpp, ShowBarOnce).
-->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:frmwrk="Corel Framework Data"
                exclude-result-prefixes="frmwrk">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <frmwrk:uiconfig>
    <frmwrk:applicationInfo name="CorelDRAW" framework="CorelDRAW" userConfiguration="true"/>
  </frmwrk:uiconfig>

  <!-- Copy everything -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- The dock host that holds the Standard toolbar, when the ImCut bar is nowhere in the layout yet -->
  <xsl:template match="dockHost[toolbar[@guidRef='c2b44f69-6dec-444e-a37e-5dbf7ff43dae']]
                               [not(ancestor::layout//toolbar[@guidRef='42ddb45d-5583-4341-871e-f1a3984efeb5'])]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:for-each select="node()">
        <xsl:apply-templates select="."/>
        <xsl:if test="self::toolbar[@guidRef='c2b44f69-6dec-444e-a37e-5dbf7ff43dae']">
          <toolbar guidRef="42ddb45d-5583-4341-871e-f1a3984efeb5" dock="top"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
