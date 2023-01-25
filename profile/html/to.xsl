<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs" version="2.0">

   <xsl:import href="../sistory/html5-foundation6/to.xsl"/>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6
            http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed: 1. Distributed under a Creative Commons
            Attribution-ShareAlike 3.0 Unported License
            http://creativecommons.org/licenses/by-sa/3.0/ 2.
            http://www.opensource.org/licenses/BSD-2-Clause Redistribution and use in source and
            binary forms, with or without modification, are permitted provided that the following
            conditions are met: * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer. * Redistributions in
            binary form must reproduce the above copyright notice, this list of conditions and the
            following disclaimer in the documentation and/or other materials provided with the
            distribution. This software is provided by the copyright holders and contributors "as
            is" and any express or implied warranties, including, but not limited to, the implied
            warranties of merchantability and fitness for a particular purpose are disclaimed. In no
            event shall the copyright holder or contributors be liable for any direct, indirect,
            incidental, special, exemplary, or consequential damages (including, but not limited to,
            procurement of substitute goods or services; loss of use, data, or profits; or business
            interruption) however caused and on any theory of liability, whether in contract, strict
            liability, or tort (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage. </p>
         <p>Andrej Pančur, Institute for Contemporary History</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>

   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   <!-- https://www2.sistory.si/publikacije/ -->
   <!-- ../../../  -->


   <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>

   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/to.xsl -->
   <xsl:param name="outputDir">docs/</xsl:param>

   <xsl:param name="homeLabel">Domov</xsl:param>
   <xsl:param name="homeURL">https://sistory.github.io/Doktorati-Filozofske-fakultete-100-let/</xsl:param>

   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/my-html_param.xsl -->
   <xsl:param name="title-bar-sticky">false</xsl:param>

   <xsl:param name="chapterAsSIstoryPublications">false</xsl:param>

   <xsl:param name="documentationLanguage">en</xsl:param>

   <xsl:param name="languages-locale">true</xsl:param>
   <xsl:param name="languages-locale-primary">en</xsl:param>

   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description">Razstava Doktorati : 100 let. Oster in potreben inštrument družbe </xsl:param>
   <xsl:param name="keywords">Razstava, doktorati, obletnice</xsl:param>
   <xsl:param name="title">Doktorati : 100 let. Oster in potreben inštrument družbe </xsl:param>

   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>V css in javascript Hook dodam imageViewer</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="cssHook">
      <xsl:if test="$title-bar-sticky = 'true'">
         <xsl:value-of
            select="concat($path-general, 'themes/css/foundation/6/sistory-sticky_title_bar.css')"/>
      </xsl:if>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css"
         rel="stylesheet" type="text/css"/>
      <link
         href="{concat($path-general,'themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}"
         rel="stylesheet" type="text/css"/>
      <link href="{concat($path-general,'themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}"
         rel="stylesheet" type="text/css"/>
      <!-- dodan imageViewer -->
      <link href="{concat($path-general,'themes/plugin/ImageViewer/1.1.3/imageviewer.css')}"
         rel="stylesheet" type="text/css"/>
      <!-- dodam projektno specifičen css, ki se nahaja v istem direktoriju kot ostali HTML dokumenti -->
      <link href="project.css" rel="stylesheet" type="text/css"/>      
   </xsl:template>
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>[html] Hook where extra Javascript functions can be defined</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="javascriptHook">
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/jquery.js')}"/>
      <!-- za highcharts -->
      <xsl:if
         test="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']]">
         <xsl:variable name="jsfile"
            select="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']][1]/tei:graphic[@mimeType = 'application/javascript']/@url"/>
         <xsl:variable name="chart-jsfile" select="document($jsfile)/html/body/script[1]/@src"/>
         <script src="{$chart-jsfile[1]}"/>
      </xsl:if>
      <!-- za back-to-top in highcharts je drugače potrebno dati jquery, vendar sedaj ne rabim dodajati jquery kodo,
         ker je že vsebovana zgoraj -->
      <!-- dodan imageViewer -->
      <script src="{concat($path-general,'themes/plugin/ImageViewer/1.1.3/imageviewer.js')}"/>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Slike, ki imajo vključeno možnost povečanja slike z imageviewer</desc>
   </doc>
   <xsl:template match="tei:figure[@rend = 'imageviewer']">
      <figure id="{@xml:id}">
         <img class="imageviewer" style="max-height: 600px;"
            src="{tei:graphic[contains(@url,'normal')]/@url}"
            data-high-res-src="{tei:graphic[1]/@url}" alt="{normalize-space(tei:head)}"/>
         <figcaption style="font-size:10pt">
            <br/>
            <i><xsl:value-of select="tei:head"/></i>
         </figcaption>
      </figure>
      <br/>
   </xsl:template>

   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>Dodam zaključni javascript za ImageViewer</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="bodyEndHook">
      <script type="text/javascript">
        $(function () {
            var viewer = ImageViewer();
            $('.imageviewer').click(function () {
                var imgSrc = this.src,
                highResolutionImage = $(this).data('high-res-src');
                viewer.show(imgSrc, highResolutionImage);
            });
        });</script>
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/what-input.js')}"/>
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/foundation.min.js')}"/>
      <script src="{concat($path-general,'themes/foundation/6/js/app.js')}"/>
      <!-- back-to-top -->
      <script src="{concat($path-general,'themes/js/plugin/back-to-top/back-to-top.js')}"/>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>video prikaz</desc>
   </doc>
   <xsl:template match="tei:graphic[@mimeType = 'video/mp4']">
      <video width="420" height="345" controls="">
         <source src="{@url}" type="video/mp4"/> Your browser does not support the video tag.
      </video>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>V kazalih slik pri naslovih slik prikažem le besedilo naslova, brez besedila
         opombe</desc>
   </doc>
   <xsl:template match="tei:head" mode="slika">
      <xsl:apply-templates mode="slika"/>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Dodatno za kolofon: procesiranje idno</desc>
   </doc>
   <xsl:template match="tei:publicationStmt" mode="kolofon">
      <xsl:apply-templates select="tei:publisher" mode="kolofon"/>
      <xsl:apply-templates select="tei:date" mode="kolofon"/>
      <xsl:apply-templates select="tei:pubPlace" mode="kolofon"/>
      <xsl:apply-templates select="tei:availability" mode="kolofon"/>
      <xsl:apply-templates select="tei:idno" mode="kolofon"/>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc/>
   </doc>
   <xsl:template match="tei:idno" mode="kolofon">
      <p>
         <xsl:choose>
            <xsl:when test="matches(., 'https?://')">
               <a href="{.}">
                  <xsl:value-of select="."/>
               </a>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat(@type, ' ', .)"/>
            </xsl:otherwise>
         </xsl:choose>
      </p>
   </xsl:template>

   <!-- odstranim pri spodnjih param true -->
   <xsl:param name="numberFigures"/>
   <xsl:param name="numberFrontTables"/>
   <xsl:param name="numberHeadings"/>
   <xsl:param name="numberParagraphs"/>
   <xsl:param name="numberTables"/>


   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za glavno vsebino (glavna navigacija)</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="nav-body-head">
      <xsl:param name="thisLanguage"/>
      <xsl:choose>
         <xsl:when test="$thisLanguage = 'en'">Exhibition</xsl:when>
         <xsl:otherwise>Razstava</xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Ne procesiram štetja besed v kolofonu</desc>
   </doc>
   <xsl:template name="countWords"/>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za izpis naziva priloge (video) na gornji navigaciji</desc>
      <param name="thisLanguage"/>
   </doc>
   <xsl:template name="nav-appendix-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Video</xsl:text>
      <!--
      <link>https://www.youtube.com/playlist?list=PLRtNtrQJTHOx3ARCzrQDesA7HzI2VAZvD</link>-->
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Vključi youtube kodo</desc>
   </doc>
   <xsl:template match="tei:media[@mimeType = 'video/youtube' or @mimeType = 'video/x-youtube']">
      <div class="responsive-embed">
         <iframe width="560" height="315"
            src="https://www.youtube.com/embed/{tokenize(@url,'/')[last()]}" frameborder="0"
            allowfullscreen=""/>
      </div>
   </xsl:template>


   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Procesiranje specifilnih vsebinskih sklopov</desc>
   </doc>
   <xsl:template match="tei:figure[@xml:id = 'boxxx']">
      <div id="{@xml:id}" class="grid-container">
         <div class="row medium-up-5">
            <div class="column">
               <div class="card">
                  <div class="card-section"> 
                     <img src="17_1-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Barbara in Matija Bulatović,
                        vnukinja in vnuk
                        Anke Mayer Kansky.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_2-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Ženja Kansky Rožman s hčerko Niko pred sliko babice Anke Mayer Kansky, ki
                        jo je naslikal Rihard Jakopič.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_3-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Izr. prof. dr. Franc Perdih, profesor na Fakulteti za kemijo in kemijsko
                        tehnologijo, se je med drugim tudi posvetil raziskovanju dela in življenja
                        Anke Mayer Kansky. Avtor: Kornelija Ajlec.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_4-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Red. prof. dr. Jurij Svete, dekan Fakultete za kemijo in kemijsko
                        tehnologijo, med intervjujem.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_5-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Zasl. prof. dr. Stane Pejovnik, nekdanji rektor Univerze v Ljubljani,
                        dekan Fakultete za kemijo in kemijsko tehnologijo in direktor Kemijskega
                        inštituta po intervjuju.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_6-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Doc. dr. Peter Mikša se raziskovalno ukvarja z zgodovino alpinizma in
                        simbolnim pomenom gora.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_7a-normal.jpg"/></div><div class="card-section">
                        <img src="17_7b-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Nana Žargi s hčerko Luno pod oknom, ob katerem se je slikala njuna pra oz.
                        praprateta Alma Sodnik s svojim sinom Santom okoli leta 1918.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_8-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Zasl. prof. dr. Lev Kreft s knjigo Alme Sodnik Zgodovinski razvoj
                        estetskih problemov.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_9-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Zasl. prof. dr. Valentin Kalan raziskuje filozofsko misel in življenje
                        Alme Sodnik.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_10-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Otroci Frana Zwittra, astrofizik red. prof. dr. Tomaž Zwitter,
                        bibliotekarka in arheologinja dr. Anja Dular, onkolog prof. dr. Matjaž
                        Zwitter.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_11-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Dva izmed osmih vnukov Frana Zwittra: doc. dr. Žiga Zwitter, ki je geograf
                        in zgodovinar, in red. prof. dr. Matevž Dular, ki poučuje in raziskuje na
                        Fakulteti za strojništvo.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_12-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Sin Valentina Logarja in nečak Ceneta Logarja, Tine Logar je dolgoletni
                        urednik Cankarjeve založbe. Na fotografijah, ki ju drži, je družina Logar z
                        očetom Valentinom in mamo Boženo Sernec Logar. Božena Sernec je bila med
                        petimi zdravniki, ki so maja 1941 organizirali prvo zdravniško celico
                        Osvobodilne fronte in v ljubljanski bolnici skrivaj zdravili ranjence. Druga
                        fotografija prikazuje brata Logar v partizanih.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_13-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Jadranka Šumi je bila dolgoletna sodelavka Znanstvenega inštituta
                        Filozofske fakultete in življenjska sopotnica Naceta Šumija. Med intervjujem
                        z Božom Repetom.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_14-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Zasl. prof. dr. Dušan Nečak v svojem kabinetu. V času dekanovanja Naceta
                        Šumija je bil njegov prodekan in ga na dekanskem mestu kasneje tudi
                        nasledil. Prav tako je Šumija nasledil na mestu vodje Znanstvenega inštituta
                        Filozofske fakultete.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_15-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Alenka Božič je bila dolgoletna lektorica Mladinske knjige. Kot študentka
                        se je redno udeleževala predavanj Dušana Pirjevca.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_16-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Hčerka Dušana Pirjevca, Alenka, v svojem domačem lutkarskem
                        ateljeju.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_17-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Red. prof. dr. Matjaž Jager je sodelavec Renate Salecl na Inštitutu za
                        kriminologijo pri Pravni fakulteti. Vir: spletna stran Inštituta za
                        kriminologijo.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_18-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Dr. Spomenka Hribar in red. prof. dr. Tine Hribar sta bila osebna
                        prijatelja Dušana Pirjevca. Med intervjujem z Božom Repetom in Kornelijo
                        Ajlec.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_19-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Izr. prof. dr. Aleš Završnik, sodelavec Renate Salecl na Inštitutu za
                        kriminologijo pri pravni fakulteti. Vir: spletna stran Inštituta za
                        kriminilogijo.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_20-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Zasl. prof. dr. Zdenko Roter je z Dušanom Pirjevcem sodeloval tudi izven
                        akademskega okolja.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_21-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Red. prof. dr. Ibrahim Gashi, nekdanji rektor Univerze v Prištini, in
                        Jusuf Osmani z Božom Repetom in Božidarjem Flajšmanom pred Filozofsko
                        fakulteto v Prištini.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_22-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Red. prof. dr. Cvetka Hedžet Tóth je bila študentka Dušana
                        Pirjevca.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_23-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Red. prof. dr. Bujar Dugolli, dekan Filozofske fakultete v Prištini in
                        zgodovinar, med intervjujem.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card"><div class="card-section">
                  <img src="17_24-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Zasl. prof. dr. Božidar Debenjak je bil doktorski mentor tako Slavoju
                        Žižku kot Mladenu Dolarju.</p>
                  </div>
               </div>
            </div>
            <div class="column">
               <div class="card">
                  <div class="card-section">
                     <img src="17_25-normal.jpg"/>
                  </div>
                  <div class="card-section">
                     <p align="justify">Red. prof. dr. Tine Germ je študent in dolgoletni sodelavec Nataše Golob.
                        Avtor: Matjaž Rebolj.</p>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </xsl:template>


   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Procesiranje specifilnih vsebinskih sklopov - callout</desc>
   </doc>
   <xsl:template match="tei:p[@rend='box']">
      <div id="{@xml:id}" class="callout alert">
         <p align="justify"><strong><em><xsl:apply-templates/></em></strong></p>
      </div>
   </xsl:template>
   
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Hočem zbrisati oklepaja pri bibl</desc>
   </doc>
   <xsl:template match="tei:bibl">
      <xsl:choose>
         <xsl:when test="parent::tei:cit[tei:match(@rend,'display')] or
            (parent::tei:cit and tei:p) or  parent::tei:q[tei:isInline(.)]">
            <xsl:call-template name="makeInline">
               <xsl:with-param name="style">citbibl</xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="parent::tei:q/parent::tei:head or parent::tei:q[tei:match(@rend,'inline')]">
            <xsl:call-template name="makeBlock">
               <xsl:with-param name="style">citbibl</xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="not(tei:isInline(.))">
            <xsl:call-template name="makeBlock">
               <xsl:with-param name="style">biblfree</xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="makeInline">
               <xsl:with-param name="style">
                  <xsl:text>bibl</xsl:text>
               </xsl:with-param>
               <xsl:with-param name="before">
                  <xsl:if test="parent::tei:cit">
                     <xsl:text></xsl:text>
                  </xsl:if>
               </xsl:with-param>
               <xsl:with-param name="after">
                  <xsl:if test="parent::tei:cit">
                     <xsl:text>:</xsl:text>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
