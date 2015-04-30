<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <add>
            <xsl:apply-templates select="/ead/archdesc/dsc/c01"/>
        </add>
    </xsl:template>
    <!-- Template for c01 -->
    <xsl:template match="c01">
        
            <xsl:apply-templates select="c02"/>
        
    </xsl:template>
    
    <!-- Template of c02 -->
    <xsl:template match="c02">
        
            <xsl:if test="did/unittitle">
                <xsl:choose>
                    <xsl:when test="did/unittitle/geogname">                     
                        <field name="subject"><xsl:value-of select="did/unittitle"/></field>
                        <field name="geolocation"><xsl:value-of select="did/unittitle/geogname"/></field>
                        <xsl:if test="did/abstract"><field name="content"><xsl:value-of select="did/abstract"/></field></xsl:if>
                        <xsl:if test="did/container"><field name="container"><xsl:value-of select="did/container/@label"/>: <xsl:value-of select="did/container"/></field></xsl:if>
                        <xsl:if test="did/unitid"><field name="label"><xsl:value-of select="did/unitid"></xsl:value-of></field></xsl:if>
                        <xsl:if test="did/physloc"><field name="location"><xsl:value-of select="did/physloc"></xsl:value-of></field></xsl:if>
                        <xsl:if test="separatedmaterial"><field name="note"><xsl:value-of select="separatedmaterial/p"/></field></xsl:if>
                    </xsl:when>
                    <xsl:when test="@level='subseries'">
                        <xsl:apply-templates select="c03"/>
                        
                    </xsl:when>
                    <xsl:when test="not(did/unittitle/geogname) and not(@id)">
                        <doc>
                            <field name="subject"><xsl:value-of select="did/unittitle"/></field>
                            <xsl:if test="did/abstract"><field name="content"><xsl:value-of select="did/abstract"/></field></xsl:if>
                            <xsl:if test="did/container"><field name="container"><xsl:value-of select="did/container/@label"/>: <xsl:value-of select="did/container"/></field></xsl:if>
                            <xsl:if test="did/unitid"><field name="label"><xsl:value-of select="did/unitid"></xsl:value-of></field></xsl:if>
                            <xsl:if test="did/physloc"><field name="location"><xsl:value-of select="did/physloc"></xsl:value-of></field></xsl:if>
                            <xsl:if test="separatedmaterial"><field name="note"><xsl:value-of select="separatedmaterial/p"/></field></xsl:if>
                        </doc>
                    </xsl:when>
                </xsl:choose>
            </xsl:if>
            
        
    </xsl:template>
    <!-- Template for drawers A-E and 1-9 -->
    <xsl:template match="c03">
        
        <xsl:if test="(../@id='drawer1') or (../@id='drawer3') or (../@id='drawer4') or (../@id='drawer11' or (../@id='drawer12') or (../@id='drawer13') or (../@id='drawera') or (../@id='drawerb') or (../@id='drawerc') or (../@id='drawerd') or (../@id='drawere')) "> 
               <xsl:choose>
                <xsl:when test="did/unittitle/geogname">                     
                    <doc>
                        <xsl:if test="../../did/head">
                            <field name="subject"><xsl:value-of select="../../did/head"/> </field>
                        </xsl:if>
                        <xsl:if test="../did/unittitle/@label='Subject'">
                            <field name="subject"><xsl:text> </xsl:text><xsl:value-of select="../did/unittitle"/> </field>
                        </xsl:if>
                        <field name="subject"><xsl:text> </xsl:text><xsl:value-of select="did/unittitle"/></field>
                        <xsl:for-each select="did/unittitle/geogname">
                            <field name="geolocation"><xsl:value-of select="text()"/></field>    
                        </xsl:for-each>
                        
                        <xsl:if test="did/unitid"><field name="label"><xsl:value-of select="did/unitid"></xsl:value-of></field></xsl:if>
                        <xsl:if test="did/physloc"><field name="location"><xsl:value-of select="did/physloc"></xsl:value-of></field></xsl:if>
                        <xsl:if test="not(did/physloc)"><field name="location"><xsl:value-of select="../did/physloc"></xsl:value-of></field></xsl:if>
                        <xsl:if test="did/note"><field name="note"><xsl:value-of select="did/note/p"/></field></xsl:if>
                        <xsl:if test="did/dao"><field name="url"><xsl:value-of select="did/dao/@href"/></field></xsl:if>
                    </doc>
                </xsl:when>
                <xsl:when test="not(did/unittitle/geogname)">
                    <doc>
                        <xsl:if test="../../did/head">
                            <field name="subject"><xsl:value-of select="../../did/head"/></field>
                        </xsl:if>
                        <xsl:if test="../did/unittitle/@label='Subject'">
                            <field name="subject"><xsl:text> </xsl:text><xsl:value-of select="../did/unittitle"/></field>
                        </xsl:if>
                        <field name="subject"><xsl:text> </xsl:text><xsl:value-of select="did/unittitle"/></field>
                        <xsl:if test="did/abstract"><field name="content"><xsl:value-of select="did/abstract"/></field></xsl:if>
                        <xsl:if test="did/container"><field name="container"><xsl:value-of select="did/container/@label"/>: <xsl:value-of select="did/container"/></field></xsl:if>
                        <xsl:if test="did/unitid"><field name="label"><xsl:value-of select="did/unitid"></xsl:value-of></field></xsl:if>
                        <xsl:if test="did/physloc"><field name="location"><xsl:value-of select="did/physloc"></xsl:value-of></field></xsl:if>
                        <xsl:if test="not(did/physloc)"><field name="location"><xsl:value-of select="../did/physloc"></xsl:value-of></field></xsl:if>
                        <xsl:if test="did/note"><field name="note"><xsl:value-of select="did/note/p"/></field></xsl:if>
                        <xsl:if test="did/dao"><field name="url"><xsl:value-of select="did/dao/@href"/></field></xsl:if>
                    </doc>
                </xsl:when>
            </xsl:choose>
           </xsl:if>
        <xsl:if test="(../@id='drawer2') or (../@id='drawer5') or (../@id='drawer6') or (../@id='drawer7') or (../@id='drawer8') or (../@id='drawer9') or (../@id='drawer10')">
            <xsl:apply-templates select="c04"/>
        </xsl:if>
        
            
    </xsl:template>
    
    <xsl:template match="c04">
        <xsl:choose>
            <xsl:when test="did/unittitle/geogname">                     
                <doc>
                    <xsl:if test="../../../did/head">
                        <field name="subject"><xsl:value-of select="../../../did/head"/> </field>
                    </xsl:if>
                    <xsl:if test="../../did/unittitle/@label='Subject'">
                        <field name="subject"><xsl:text> </xsl:text><xsl:value-of select="../../did/unittitle"/></field>
                    </xsl:if>
                    <xsl:if test="../did/unittitle/@label='Subject'">
                        <field name="subject"><xsl:text> </xsl:text><xsl:value-of select="../did/unittitle"/> </field>
                    </xsl:if>
                    <field name="subject"><xsl:text> </xsl:text><xsl:value-of select="did/unittitle"/></field>
                    <xsl:for-each select="did/unittitle/geogname">
                        <field name="geolocation"><xsl:value-of select="text()"/></field>    
                    </xsl:for-each>
                    
                    <xsl:if test="did/unitid"><field name="label"><xsl:value-of select="did/unitid"></xsl:value-of></field></xsl:if>
                    <xsl:if test="did/physloc"><field name="location"><xsl:value-of select="did/physloc"></xsl:value-of></field></xsl:if>
                    <xsl:if test="not(did/physloc)"><field name="location"><xsl:value-of select="../../did/physloc"></xsl:value-of></field></xsl:if>
                    <xsl:if test="did/note"><field name="note"><xsl:value-of select="did/note/p"/></field></xsl:if>
                </doc>
            </xsl:when>
            <xsl:when test="not(did/unittitle/geogname)">
                <doc>
                    <xsl:if test="../../../did/head">
                        <field name="subject"><xsl:value-of select="../../../did/head"/></field>
                    </xsl:if>
                    <xsl:if test="../../did/unittitle/@label='Subject'">
                        <field name="subject"><xsl:text> </xsl:text><xsl:value-of select="../../did/unittitle"/></field>
                    </xsl:if>
                    <xsl:if test="../did/unittitle/@label='Subject'">
                        <field name="subject"><xsl:text> </xsl:text><xsl:value-of select="../did/unittitle"/></field>
                    </xsl:if>
                    <field name="subject"><xsl:text> </xsl:text><xsl:value-of select="did/unittitle"/></field>
                    <xsl:if test="did/abstract"><field name="content"><xsl:value-of select="did/abstract"/></field></xsl:if>
                    <xsl:if test="did/container"><field name="container"><xsl:value-of select="did/container/@label"/>: <xsl:value-of select="did/container"/></field></xsl:if>
                    <xsl:if test="did/unitid"><field name="label"><xsl:value-of select="did/unitid"></xsl:value-of></field></xsl:if>
                    <xsl:if test="did/physloc"><field name="location"><xsl:value-of select="did/physloc"></xsl:value-of></field></xsl:if>
                    <xsl:if test="not(did/physloc)"><field name="location"><xsl:value-of select="../../did/physloc"></xsl:value-of></field></xsl:if>
                    <xsl:if test="did/note"><field name="note"><xsl:value-of select="did/note/p"/></field></xsl:if>
                </doc>
            </xsl:when>
        </xsl:choose>
        
    </xsl:template>

</xsl:stylesheet>