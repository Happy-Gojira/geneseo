<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        
        <html>
            <head>
                <link rel="stylesheet" media="screen" href="css/schmidt.css" />
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
                <script>
                    $(document).ready(function() {
                    $(".content .dropdown").click(function () {
                    $(this).next().slideToggle('slow');
                    });
                    });		
                </script>

            </head>
            <body id="index">
                <div id="wrap">
                    <header>
                        <div id="headerLeft">
                            <img src="images/Drawing64.jpg" alt="Front of the Vance House, 57 Second St., Geneseo, N.Y."/>
                        </div>
                        
                        <div id="headerRight">
                            <h1>Special Collections at Milne Library</h1>
                            <h2>The Carl Schmidt Collection in Historic Architecture</h2>                         
                        </div>
                        <span><h3><a href="index.html">Click Here to Search the Schmidt Collection</a></h3></span>
                    </header>
                    <aside class="left">
                        <xsl:call-template name="toc"/>
                    </aside>
                    <section>
                        <xsl:call-template name="cover"/>
                    </section>
                    <section class="archdesc_did">
                        <xsl:call-template name="archdesc-did"/>
                    </section>                                  
                    <section class="archdesc-scopecontent">
                        <xsl:call-template name="archdesc-scopecontent"/>
                    </section> 
                    <section class="dsc1">
                        <xsl:apply-templates select="/ead/archdesc/dsc/c01"/>
                    </section>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- Table of Contents -->
    <xsl:template name="toc">
        
        <h3><a class="dark" name="toc">TABLE OF CONTENTS</a></h3>
        <xsl:if test="ead/archdesc/did">
            <p>
                <a href="#{ead/archdesc/did/head}"><xsl:value-of select="ead/archdesc/did/head"/></a>
            </p>
        </xsl:if>
        <xsl:if test="/ead/archdesc/descgrp">
            <p>
                <a href="#{ead/archdesc/descgrp/head}"><xsl:value-of select="ead/archdesc/descgrp/head"/></a> 
            </p>
        </xsl:if>
        <xsl:if test="ead/archdesc/scopecontent">
            <p>
                <a href="#{ead/archdesc/scopecontent/head}"><xsl:value-of select="ead/archdesc/scopecontent/head"/></a>
            </p>
        </xsl:if>
        <xsl:if test="ead/archdesc/dsc">
      
            <xsl:for-each select="ead/archdesc/dsc/c01">
                <p>                                       
                    <a>
                        <xsl:attribute name="href"><xsl:text>#</xsl:text>                            
                            <xsl:value-of select="did/head"/>
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="did/unittitle/unitdate">
                                <xsl:for-each select="did/unittitle">
                                    <xsl:apply-templates select="." />
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="did/head" />
                                <xsl:text>
                                    
                                </xsl:text>
                                <xsl:apply-templates select="did/unitdate" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </a>                                        
                </p>
            </xsl:for-each>
            
        </xsl:if>
        
    </xsl:template>
    
    
    
    <!-- Template for Cover info -->
    
    <xsl:template name="cover">
        <xsl:for-each select="ead/frontmatter/titlepage">
            <xsl:if test="string-length(titleproper)">
                <h1><xsl:value-of select="titleproper"/></h1>       
            </xsl:if>
            <h2><xsl:value-of select="subtitle"/></h2>          
            <h3><xsl:value-of select="author"/></h3>
            
        </xsl:for-each>
        <xsl:for-each select="ead/frontmatter/titlepage/list/defitem">
            <h4><xsl:value-of select="label"/> <xsl:value-of select="item"/></h4>
        </xsl:for-each>
        <ul>
            <li>Contact Information: <a href="http://www.geneseo.edu/library/staff-directory">Special Collections Librarian</a></li>
            <li>Milne Library, SUNY Geneseo.</li>
            
        </ul>
        
        <hr></hr>
    </xsl:template>
    <!-- Template for archdes_did and descgrp-->
    <xsl:template name="archdesc-did">
        <xsl:for-each select="ead/archdesc/did">
            <h3><a name="{head}"><xsl:apply-templates select="head"/></a></h3>
            <ul>
                <li><xsl:value-of select="origination/@label"/>: <xsl:value-of select="origination"/></li>
                <li><xsl:value-of select="physdesc/@label"/>: <xsl:value-of select="physdesc"/></li>
                <li><xsl:value-of select="repository/@label"/>: <xsl:value-of select="repository"/></li>                    
                <li><xsl:value-of select="abstract/@label"/>: <xsl:value-of select="abstract"/></li>
            </ul>
        </xsl:for-each>
        <xsl:for-each select="ead/archdesc/descgrp">
            <h3><a name="{head}"><xsl:apply-templates select="head"/></a></h3>
            <ul class="singleLine">
                <li class="bold"><xsl:value-of select="accessrestrict/head"/>: </li>
                <li><xsl:value-of select="accessrestrict/p"/></li>
            </ul>
            <ul class="singleLine">
                <li class="bold"><xsl:value-of select="userestrict/head"/>: </li>
                <li><xsl:value-of select="userestrict/p"/></li>
            </ul>
            <ul class="singleLine">
                <li class="bold"><xsl:value-of select="prefercite/head"/>: </li>
                <li><xsl:value-of select="prefercite/p"/></li>
            </ul>
            <ul class="singleLine">
                <li class="bold"><xsl:value-of select="acqinfo/head"/>: </li>
                <li><xsl:value-of select="acqinfo/p"/></li>
            </ul>
            <ul class="singleLine">
                <li class="bold"><xsl:value-of select="processinfo/head"/>: </li>
                <li><xsl:value-of select="processinfo/p"/></li>
            </ul>
        </xsl:for-each>
        
    </xsl:template>
    
    <!--This template rule formats the scopecontent element.-->
    <xsl:template name="archdesc-scopecontent">
        <xsl:if test="ead/archdesc/scopecontent">
            <xsl:for-each select="ead/archdesc/scopecontent">
                <xsl:apply-templates/>
            </xsl:for-each>
            <p>
                <a href="#toc">Return to the Table of Contents</a>
            </p>
            <hr></hr>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="ead/archdesc/scopecontent/head">
        <h3><a name="{/ead/archdesc/scopecontent/head}"><xsl:apply-templates/></a></h3>
    </xsl:template>
    
    <xsl:template match="ead/archdesc/scopecontent/p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- Template for c01-->
    <xsl:template match="c01">
        <div><h3><a name="{did/head}"><xsl:value-of select="did/head"/><xsl:text> </xsl:text>  <xsl:value-of select="did/unitdate"/></a></h3>
        <xsl:if test="did/physdesc"><p><b>Physical Description: </b> <xsl:value-of select="did/physdesc"/></p></xsl:if>
        <xsl:if test="did/physloc"><p><b>Location: </b> <xsl:value-of select="did/physloc"/></p></xsl:if>
        <xsl:if test="scopecontent"><p><b>Scope and Content: </b> <xsl:value-of select="scopecontent"/></p></xsl:if>
        <xsl:if test="did/note"><p><b>Note: </b> <xsl:value-of select="did/note"/></p></xsl:if>    
        <xsl:if test="bioghist"><p><b>History: </b> <xsl:value-of select="bioghist"/></p></xsl:if>        
        <xsl:if test="note">
            <xsl:for-each select="note">
                <xsl:apply-templates/>
            </xsl:for-each>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="c02/did/container/@type='box'">
                <div class="content">
                    <h4><xsl:text>Box Inventory</xsl:text></h4>
                    <input type="button" class="dropdown" value="Click to show/hide box inventory"/>
                    <div class="hide"><xsl:apply-templates select="c02"/></div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="c02"/>
                
            </xsl:otherwise>
        </xsl:choose>    
        
        <p>
            <a href="#toc">Return to the Table of Contents</a>
        </p>
        <hr></hr></div>
    </xsl:template>
    
    <!-- Template for c02-->
    <xsl:template match="c02">
       <!-- For Boxes --> 
        <xsl:choose>            
           <xsl:when test="did/container/@type='box'">  
               <div class="item"> 
               <xsl:if test="did/container"><p class="indentc02"><xsl:value-of select="did/container/@label"/>: <xsl:value-of select="did/container"/></p></xsl:if>
                <xsl:if test="did/unittitle"><p class="indentc03"><xsl:value-of select="did/unittitle/@label"/>: <xsl:value-of select="did/unittitle"/></p></xsl:if>
                <xsl:if test="did/abstract"><p class="indentc03"><xsl:value-of select="did/abstract/@label"/>: <xsl:value-of select="did/abstract"/></p></xsl:if>
                <xsl:if test="scopecontent"><p class="indentc03">Scope and Content: <xsl:value-of select="scopecontent"/></p></xsl:if>
                <xsl:if test="bioghist"><p class="indentc03">History: <xsl:value-of select="bioghist"/></p></xsl:if>        
               </div>
               <xsl:apply-templates select="c03"/>
           </xsl:when>
        </xsl:choose>
        <!-- For Drawers A-E -->        
        <xsl:choose>
            
            <xsl:when test="@id='drawera'">
                <xsl:if test="did/unittitle"><p class="indentc02 bold"><xsl:value-of select="did/unittitle"/></p></xsl:if>
               <div class="content">
                   <input type="button" class="dropdown" value="Click to show/hide items"/>
                   <div class="hide"> <xsl:apply-templates select="c03"/></div>
               </div>
            </xsl:when>
            <xsl:when test="@id='drawerb'">
                <xsl:if test="did/unittitle"><p class="indentc02 bold"><xsl:value-of select="did/unittitle"/></p></xsl:if>
                <div class="content">
                    <input type="button" class="dropdown" value="Click to show/hide items"/>
                    <div class="hide"> <xsl:apply-templates select="c03"/></div>
                </div>
            </xsl:when>
            <xsl:when test="@id='drawerc'">
                <xsl:if test="did/unittitle"><p class="indentc02 bold"><xsl:value-of select="did/unittitle"/></p></xsl:if>
                <div class="content">
                    <input type="button" class="dropdown" value="Click to show/hide items"/>
                    <div class="hide"> <xsl:apply-templates select="c03"/></div>
                </div>
            </xsl:when>
            <xsl:when test="@id='drawerd'">
                <xsl:if test="did/unittitle"><p class="indentc02 bold"><xsl:value-of select="did/unittitle"/></p></xsl:if>
                <div class="content">
                    <input type="button" class="dropdown" value="Click to show/hide items"/>
                    <div class="hide"> <xsl:apply-templates select="c03"/></div>
                </div>
            </xsl:when>
            <xsl:when test="@id='drawere'">
                <xsl:if test="did/unittitle"><p class="indentc02 bold"><xsl:value-of select="did/unittitle"/></p></xsl:if>
                <div class="content">
                    <input type="button" class="dropdown" value="Click to show/hide items"/>
                    <div class="hide"> <xsl:apply-templates select="c03"/></div>
                </div>
            </xsl:when>
        </xsl:choose>
        
        <!-- For drawers 1-10 -->
        <xsl:choose>
            <xsl:when test="@id='drawer1'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div class="content">
                    <input type="button" class="dropdown" value="Click to show/hide items"/>
                <div class="hide"><xsl:apply-templates select="c03"/></div>
                </div>
            </xsl:when>
            <xsl:when test="@id='drawer2'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div><xsl:apply-templates select="c03"/></div>
            </xsl:when>
            <xsl:when test="@id='drawer3'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div class="content">
                    <input type="button" class="dropdown" value="Click to show/hide items"/>
                    <div class="hide"><xsl:apply-templates select="c03"/></div>
                </div>
            </xsl:when>
            <xsl:when test="@id='drawer4'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div class="content">
                    <input type="button" class="dropdown" value="Click to show/hide items"/>
                    <div class="hide"><xsl:apply-templates select="c03"/></div>
                </div>
            </xsl:when>
            <xsl:when test="@id='drawer5'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div><xsl:apply-templates select="c03"/></div>
            </xsl:when>
            <xsl:when test="@id='drawer6'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div><xsl:apply-templates select="c03"/></div>
            </xsl:when> 
            <xsl:when test="@id='drawer7'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div><xsl:apply-templates select="c03"/></div>
            </xsl:when>
            <xsl:when test="@id='drawer8'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div><xsl:apply-templates select="c03"/></div>
            </xsl:when>
            <xsl:when test="@id='drawer9'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div><xsl:apply-templates select="c03"/></div>
            </xsl:when>
            <xsl:when test="@id='drawer10'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div><xsl:apply-templates select="c03"/></div>
            </xsl:when>
            <xsl:when test="@id='drawer11'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div class="content">
                    <input type="button" class="dropdown" value="Click to show/hide items"/>
                    <div class="hide"><xsl:apply-templates select="c03"/></div>
                </div>
            </xsl:when>
            <xsl:when test="@id='drawer12'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div class="content">
                    <input type="button" class="dropdown" value="Click to show/hide items"/>
                    <div class="hide"><xsl:apply-templates select="c03"/></div>
                </div>
            </xsl:when>
            <xsl:when test="@id='drawer13'">
                <h4><xsl:value-of select="did/physloc"/>: <xsl:value-of select="did/unittitle"/></h4>
                <div class="content">
                    <input type="button" class="dropdown" value="Click to show/hide items"/>
                    <div class="hide"><xsl:apply-templates select="c03"/></div>
                </div>
            </xsl:when>
            
        </xsl:choose>
        
    </xsl:template>
    
    <!-- Template for c03-->
    <xsl:template match="c03">
        <div class="item indentc03">
            <xsl:if test="did/unittitle"><h4>Subject: <xsl:value-of select="did/unittitle"/> <xsl:value-of select="did/unitdate"/></h4></xsl:if>
            <xsl:if test="did/unitid"><p><xsl:value-of select="did/unitid/@label"/>: <xsl:value-of select="did/unitid"/> </p></xsl:if>
            <xsl:if test="did/physloc"><p><xsl:value-of select="did/physloc/@label"/>: <xsl:value-of select="did/physloc"/></p></xsl:if>
            <xsl:if test="did/container"><p><xsl:value-of select="did/container/@label"/>: <xsl:value-of select="did/container"/></p></xsl:if>
            <xsl:if test="did/physdesc"><p>Description: <xsl:value-of select="did/physdesc"/></p></xsl:if>    
            <xsl:if test="scopecontent"><p>Scope and Content: <xsl:value-of select="scopecontent"/></p></xsl:if>
            <xsl:if test="did/note">
                <xsl:for-each select="did/note">
                    <p><xsl:apply-templates/></p>
                </xsl:for-each>
            </xsl:if>
        </div>
        <xsl:if test="c04">
            <div class="content">
                <input type="button" class="dropdown" value="Click to show/hide items"/>
                <div class="hide"><xsl:apply-templates select="c04"/></div>
            </div>
        </xsl:if>
        
    </xsl:template>
    
    <!-- Template for c04 -->
    <xsl:template match="c04">
        <div class="item indentc04">
            <xsl:if test="did/unittitle"><h4>Subject: <xsl:value-of select="did/unittitle"/> <xsl:value-of select="did/unitdate"/></h4></xsl:if>
            <xsl:if test="did/unitid"><p><xsl:value-of select="did/unitid/@label"/>: <xsl:value-of select="did/unitid"/> </p></xsl:if>
            <xsl:if test="did/physdesc"><p>Description: <xsl:value-of select="did/physdesc"/></p></xsl:if>
            <xsl:if test="did/physloc"><p><xsl:value-of select="did/physloc/@label"/>: <xsl:value-of select="did/physloc"/></p></xsl:if>
            <xsl:if test="did/container"><p><xsl:value-of select="did/container/@label"/>: <xsl:value-of select="did/container"/></p></xsl:if>
            <xsl:if test="scopecontent"><p>Scope and Content: <xsl:value-of select="scopecontent"/></p></xsl:if>
            <xsl:if test="did/note">
                <xsl:for-each select="did/note">
                    <p>Note: <xsl:apply-templates/></p>
                </xsl:for-each>
            </xsl:if>
  
        </div>
        
    </xsl:template>
    
</xsl:stylesheet>