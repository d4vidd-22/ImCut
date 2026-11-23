<?xml version="1.0" encoding="UTF-8"?>
<!--
  ImCut toolbar: the application half of the UI (Programs64\Addons\ImCut\AppUI.xslt).

  CorelDRAW applies every .xslt of an add-on folder that has a CorelDrw.addon file (as its own add-on U2 does).
  The applicationInfo below, without userConfiguration, sends this one to the application's configuration, every
  time CorelDRAW starts. It adds:
    - the items: the title "ImCut" (plain bold text) and one check button per ImCut window;
    - the command bar: the toolbar "ImCut", as drawn on 2026-11-16:
      ImCut | Exportar Sangria Cores Doctor Nesting | Print Smart Mirror Smart Fit | gear (Print since 2026-11-17, Smart Mirror and
      the separator before Print since 2026-11-18, Smart Fit since 2026-11-20). The window buttons show their name under the icon, the gear
      only its icon. The grip is CorelDRAW's own, shown while the toolbars are not locked.
  The logo with its menu (2026-11-14) is gone: CorelDRAW draws bold text only in a static text, which opens nothing.
  A workspace keeps its own copy of the bar; UserUI2.xslt puts this layout there.
  The buttons bind to the data source "ImCutDS" that ImCut.cpg registers (DataSource.cpp). A workspace saved before
  Print came gets the new list from UserUI3.xslt, one saved before Smart Mirror from UserUI4.xslt, one saved before Smart Fit
  from UserUI5.xslt. The separators are
  CorelDRAW's own item (266435b4-...). Each part is added only when its guid is not there yet.
-->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:frmwrk="Corel Framework Data"
                exclude-result-prefixes="frmwrk">
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <frmwrk:uiconfig>
    <frmwrk:applicationInfo name="CorelDRAW" framework="CorelDRAW"/>
  </frmwrk:uiconfig>

  <!-- Copy everything -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- The items go into uiConfig/items. CorelDRAW 2026 runs this transform on DrawUI.xml, whose <items/> is empty,
       and not on DrawUI.items.xml (seen in CorelDRAW on 2026-11-14: the bars arrived, items put only in the items
       file did not, and the bar stayed empty). A configuration with no <items> gets one; a root <items> (the items
       file, should CorelDRAW ever feed it) gets them too. Each place adds them only once. -->
  <xsl:template match="/items | /uiConfig/items">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
      <xsl:call-template name="imcut-items"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/uiConfig[not(items)]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="node()"/>
      <items>
        <xsl:call-template name="imcut-items"/>
      </items>
    </xsl:copy>
  </xsl:template>

  <!-- The items, called with the <items> element as the context (or none) -->
  <xsl:template name="imcut-items">
      <xsl:if test="not(itemData[@guid='4f8115a4-7ce6-4ca8-bf85-3fa4484c7273'])">
        <!-- Title: "ImCut" in bold ("emphasized", as CorelDRAW's own bold labels). The guid is the old logo's, so a
             workspace that still lists it shows the title. -->
        <itemData guid="4f8115a4-7ce6-4ca8-bf85-3fa4484c7273" type="statusText" text="ImCut" caption="ImCut"
                  style="emphasized" appearance="tight" justification="center"/>
        <!-- Windows: checked while the window is open -->
        <itemData guid="f52c0b33-7bb3-480d-a2c2-3c068252746a" type="checkButton" caption="Exportar"
                  toolTip="*Bind(DataSource=ImCutDS;Path=CutTip)" icon="*Bind(DataSource=ImCutDS;Path=CutIcon)"
                  check="*Bind(DataSource=ImCutDS;Path=CutOpen;BindType=TwoWay)" enable="*Bind(DataSource=ImCutDS;Path=Ready)"/>
        <itemData guid="3f7de703-8b77-43b9-9b93-275b9b314326" type="checkButton" caption="Sangria"
                  toolTip="*Bind(DataSource=ImCutDS;Path=BleedTip)" icon="*Bind(DataSource=ImCutDS;Path=BleedIcon)"
                  check="*Bind(DataSource=ImCutDS;Path=BleedOpen;BindType=TwoWay)" enable="*Bind(DataSource=ImCutDS;Path=Ready)"/>
        <itemData guid="8aae2719-ca35-4bfe-9efa-0709684728f6" type="checkButton" caption="Cores"
                  toolTip="*Bind(DataSource=ImCutDS;Path=ColorTip)" icon="*Bind(DataSource=ImCutDS;Path=ColorIcon)"
                  check="*Bind(DataSource=ImCutDS;Path=ColorOpen;BindType=TwoWay)" enable="*Bind(DataSource=ImCutDS;Path=Ready)"/>
        <itemData guid="f137df47-cc01-427e-b78b-55c99fec939d" type="checkButton" caption="Doctor"
                  toolTip="*Bind(DataSource=ImCutDS;Path=DoctorTip)" icon="*Bind(DataSource=ImCutDS;Path=DoctorIcon)"
                  check="*Bind(DataSource=ImCutDS;Path=DoctorOpen;BindType=TwoWay)" enable="*Bind(DataSource=ImCutDS;Path=Ready)"/>
        <itemData guid="8c400b7e-bcc1-4512-b69d-5255c723b46a" type="checkButton" caption="Nesting"
                  toolTip="*Bind(DataSource=ImCutDS;Path=NestingTip)" icon="*Bind(DataSource=ImCutDS;Path=NestingIcon)"
                  check="*Bind(DataSource=ImCutDS;Path=NestingOpen;BindType=TwoWay)" enable="*Bind(DataSource=ImCutDS;Path=Ready)"/>
        <!-- Print (2026-11-17): the selection as an image on the clipboard; an action, not a window -->
        <itemData guid="c86eed93-65f1-49b3-b825-6638bb327404" type="button" caption="Print"
                  toolTip="*Bind(DataSource=ImCutDS;Path=CaptureTip)" icon="*Bind(DataSource=ImCutDS;Path=CaptureIcon)"
                  onInvoke="*Bind(DataSource=ImCutDS;Path=Capture)" enable="*Bind(DataSource=ImCutDS;Path=Ready)"/>
        <!-- Smart Mirror (2026-11-18): the selected piece's art, mirrored, into the piece clicked next; an action -->
        <itemData guid="6342e96f-b34e-4087-a4c3-580f149da621" type="button" caption="Smart Mirror"
                  toolTip="*Bind(DataSource=ImCutDS;Path=MirrorTip)" icon="*Bind(DataSource=ImCutDS;Path=MirrorIcon)"
                  onInvoke="*Bind(DataSource=ImCutDS;Path=Mirror)" enable="*Bind(DataSource=ImCutDS;Path=Ready)"/>
        <!-- Smart Fit (2026-11-20): the selected piece's art, fitted, into the piece of another template clicked next; an action -->
        <itemData guid="3ae43dbe-fa29-4dc8-9f4a-8f158fa33131" type="button" caption="Smart Fit"
                  toolTip="*Bind(DataSource=ImCutDS;Path=FitTip)" icon="*Bind(DataSource=ImCutDS;Path=FitIcon)"
                  onInvoke="*Bind(DataSource=ImCutDS;Path=Fit)" enable="*Bind(DataSource=ImCutDS;Path=Ready)"/>
        <itemData guid="819c0837-2b00-4680-ad78-9c2426380d3a" type="checkButton" caption="Configurações"
                  toolTip="*Bind(DataSource=ImCutDS;Path=SettingsTip)" icon="*Bind(DataSource=ImCutDS;Path=SettingsIcon)"
                  check="*Bind(DataSource=ImCutDS;Path=SettingsOpen;BindType=TwoWay)" enable="*Bind(DataSource=ImCutDS;Path=Ready)"/>
      </xsl:if>
  </xsl:template>

  <!-- The command bar. The same list is in UserUI2.xslt (the tests compare them). -->
  <xsl:template match="/uiConfig/commandBars">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
      <xsl:if test="not(commandBarData[@guid='42ddb45d-5583-4341-871e-f1a3984efeb5'])">
        <commandBarData guid="42ddb45d-5583-4341-871e-f1a3984efeb5" type="toolbar" nonLocalizableName="ImCut" userCaption="ImCut">
          <toolbar>
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
          </toolbar>
        </commandBarData>
      </xsl:if>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
