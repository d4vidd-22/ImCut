<?xml version="1.0" encoding="UTF-8"?>
<!--
  ImCut toolbar, the layout of 2026-11-20 (a separator after Nesting, then Print, Smart Mirror and Smart Fit), in the
  user's workspace (Programs64\Addons\ImCut\UserUI5.xslt).
  CorelDRAW applies each user transform of an add-on once per workspace and remembers it by the file's path, so a
  workspace that already took UserUI4.xslt would keep the bar without Smart Fit; this file, the same transform under a
  new path, brings the new list. UserUI2.xslt, UserUI3.xslt and UserUI4.xslt hold the same list, so the order they are
  applied in does not matter.
  It:
    - puts the bar of AppUI.xslt in the workspace's copy, keeping that copy's own attributes (dock, itemFace);
    - takes the logo's old menu (262e326c-...) and its place in the workspace out.
  A workspace without a copy of the bar is left as it is: the bar comes from AppUI.xslt.
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

  <!-- The bar: the list of AppUI.xslt -->
  <xsl:template match="commandBarData[@guid='42ddb45d-5583-4341-871e-f1a3984efeb5']/toolbar">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <item guidRef="4f8115a4-7ce6-4ca8-bf85-3fa4484c7273"/>
      <item guidRef="266435b4-6e53-460f-9fa7-f45be187d400"/>
      <item guidRef="f52c0b33-7bb3-480d-a2c2-3c068252746a" itemFace="textBelowImage"/>
      <item guidRef="3f7de703-8b77-43b9-9b93-275b9b314326" itemFace="textBelowImage"/>
      <item guidRef="8aae2719-ca35-4bfe-9efa-0709684728f6" itemFace="textBelowImage"/>
      <item guidRef="f137df47-cc01-427e-b78b-55c99fec939d" itemFace="textBelowImage"/>
      <item guidRef="8c400b7e-bcc1-4512-b69d-5255c723b46a" itemFace="textBelowImage"/>
      <item guidRef="266435b4-6e53-460f-9fa7-f45be187d400"/>
      <item guidRef="c86eed93-65f1-49b3-b825-6638bb327404" itemFace="textBelowImage"/>
      <item guidRef="6342e96f-b34e-4087-a4c3-580f149da621" itemFace="textBelowImage"/>
      <item guidRef="3ae43dbe-fa29-4dc8-9f4a-8f158fa33131" itemFace="textBelowImage"/>
      <item guidRef="266435b4-6e53-460f-9fa7-f45be187d400"/>
      <item guidRef="819c0837-2b00-4680-ad78-9c2426380d3a" itemFace="imageOnly"/>
    </xsl:copy>
  </xsl:template>

  <!-- The logo's old menu, and where the workspace kept its state -->
  <xsl:template match="commandBarData[@guid='262e326c-46e9-40e3-8455-b7ecbd7f9a4e'] | container[@guidRef='262e326c-46e9-40e3-8455-b7ecbd7f9a4e']"/>
</xsl:stylesheet>
