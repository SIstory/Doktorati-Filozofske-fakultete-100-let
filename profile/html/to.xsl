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
   <xsl:param name="homeURL">https://sistory.github.io/Doktorati-Filozofske-fakultete-100-let/index-sl.html</xsl:param>

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
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc> NASLOVNA STRAN </xsldoc:desc>
      <param name="thisLanguage"/>
   </xsldoc:doc>
   <xsl:template match="tei:titlePage">
      <!-- avtor -->
      <!--<p  class="naslovnicaAvtor">
         <xsl:for-each select="tei:docAuthor">
            <xsl:choose>
               <xsl:when test="tei:forename or tei:surname">
                  <xsl:for-each select="tei:forename">
                     <xsl:value-of select="."/>
                     <xsl:if test="position() ne last()">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
                  <xsl:if test="tei:surname">
                     <xsl:text> </xsl:text>
                  </xsl:if>
                  <xsl:for-each select="tei:surname">
                     <xsl:value-of select="."/>
                     <xsl:if test="position() ne last()">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="position() ne last()">
               <br/>
            </xsl:if>
         </xsl:for-each>
      </p>
      <br/>-->
      <!-- naslov: spremenjeno procesiranje naslovov -->      
      <!--<xsl:for-each select="tei:docTitle/tei:titlePart[@xml:lang='en']">
         <h1 class="text-center"><xsl:value-of select="."/></h1>
      </xsl:for-each>
      <hr/>
      <xsl:for-each select="tei:docTitle/tei:titlePart[@xml:lang='sl']">
         <h1 class="text-center"><xsl:value-of select="."/></h1>
      </xsl:for-each>
      <br/>-->
      <xsl:for-each select="tei:docTitle/tei:titlePart[@type='main']">
         <h1 class="text-center"><xsl:value-of select="."/></h1>
         <xsl:for-each select="following-sibling::tei:titlePart[@type='sub']">
            <h1 class="subheader podnaslov"><xsl:value-of select="."/></h1>
         </xsl:for-each>
      </xsl:for-each><!--
      <xsl:if test="tei:figure">
         <div class="text-center">
            <p>
               <img src="{tei:figure/tei:graphic/@url}" alt="naslovna slika"/>
            </p>
         </div>
      </xsl:if>-->
      <xsl:if test="tei:graphic[1]">
         <div class="text-center">
            <p>
               <img src="{tei:graphic[1]/@url}" alt="naslovna slika" style="max-height: 500px;"/>
            </p>
         </div>
      </xsl:if>
      <xsl:if test="tei:graphic[2]">
         <div class="text-center">
            <p>
               <img src="{tei:graphic[2]/@url}" alt="naslovna slika" style="max-height: 400px;"/>
            </p>
         </div>
         <div class="row">
            <div class="callout secondary" data-closable="">
               <p style="text-align:justify">Nastanek slovenske univerze je bil prvenstveno produkt nacionalnih teženj, ki so potekala vse od sredine 19. stoletja;  »prva vidna trdnjava«, »najvišja slovenska kulturna ustanova, ki si jo je narodna država postavila na triglavsko ozemlje proti sosedom«, kot je ob njeni desetletnici leta 1929 zapisal rektor Milan Vidmar, tedaj v svetu najbolj priznan slovenski elektrotehnik in šahist. Univerzitetni svet pa je tedaj ugotovil, da je »ljubljanska univerza severni branik naše zemlje«. No, treba je dodati, da je bil Vidmar, tako kot še nekateri drugi profesorji tedanjega časa, hkrati tudi goreč zagovornik univerzalne znanosti. 
               </p><p style="text-align:justify">Konec prve svetovne vojne je Slovencem kot delu poražene države v nasprotju z velikimi pričakovanji o narodni združitvi prinesel razkosanje. Z razpadom Avstro-Ogrske monarhije leta 1918 so bili po volji velikih sil razdeljeni med štiri države. Časi po vojni in združitvi v centralistično urejeno Kraljevino Srbov Hrvatov in Slovencev 1. decembra 1918 ustanovitvi univerze sprva niso bili naklonjeni. Tudi slovenski politiki so dvomili, da bi jo bilo mogoče ustanoviti in so pobude sprva zavračali. Univerza se jim v turbulentnem prehodnem času, ob bojih za nacionalne meje, rastočih socialnih nemirih, ki so grozili z revolucijo, ter ob deset tisočih vojakov raznih nacionalnosti, ki so po razpadu soške fronte ostali na slovenskem ozemlju, ni zdela prioritetno vprašanje. V Beogradu je vladalo prepričanje, da je ena univerza v novonastali državi z morebitnimi odseki v Zagrebu in Ljubljani dovolj. Poleg ideje o univerzi v Trstu je obstajal celo predlog, da bi jugoslovanska vojska za potrebe bodoče slovenske univerze zasedla Gradec. Vojaška zasedba drugega največjega avstrijskega mesta zato, da bi Slovenci dobili svojo univerzo, bi bil brez dvoma zelo sočen in unikaten zgodovinski dogodek. Če bi se uresničil, bi se danes srečali v Gradcu, Slovenija, bi bila precej večja, poštna znamka, ki jo predstavljamo, pa seveda drugačna. 
               </p><p style="text-align:justify">Pri Slovencih je tedaj in še nekaj časa vladala dilema, ali ima sploh smisel ohranjati svoj jezik in kulturo ali pa bi bilo bolje, da postanejo del enovitega jugoslovanskega naroda s srbohrvaškim jezikom. Na koncu je bilo v novi državi sprejeto načelo kompromisnega unitarizma, to je definicija, da so Jugoslovani en narod s tremi plemeni: Srbi, Hrvati in Slovenci. 
               </p><p style="text-align:justify">Prehodno obdobje iz ene v drugo državo pa se je zaradi svoje protislovnosti in številnih neznank za univerzo izkazalo za zelo ugodno. Če ne bi nastala točno v tistem obdobju, bi jo verjetno dočakali šele po drugi svetovni vojni. Odločilen čas je bil torej med novembrom 1918 in majem 1919. Če bi se uresničilo stališče beograjskih oblasti, da se vprašanje univerze preloži na čas po pariški mirovni konferenci, ki se je začela januarja 1919 in je trajala leto dni, potem pa še na čas, ko bi Jugoslavija in Italija rešili vprašanje italijansko-jugoslovanske meje, torej do podpisa rapalske pogodbe leta 1920, bi bilo prehodno obdobje z začasnim narodnim predstavništvom in vlado, v kateri je bil podpredsednik dr. Anton Korošec, mimo. Vprašanje univerze bi preglasile ustavne razprave in najverjetneje bi se uresničil koncept z eno, beograjsko univerzo, ki bi imela podružnice v Zagrebu in Ljubljani, pri čemer bi bila Ljubljana verjetno podrejena tudi Zagrebu, ki je že imel svojo univerzo. 
               </p><p style="text-align:justify">Nastanek univerze lahko razdelimo v tri faze: od konca prve svetovne vojne do januarja 1919, ko je potekalo oblikovanje začasnih stolic za zagrebško univerzo, ki bi jih nato prenesli v Ljubljano; od februarja 1919 do julija 1919, ko je sledilo ustanavljanje univerze v Ljubljani, in od sprejetja zakona o univerzi v Ljubljani v začasni skupščini v Beogradu 16. julija 1919 do nastanka univerzitetnega sveta, ki je bil med imenovanimi novimi profesorji izbran v Ljubljani 18. septembra 1919.
               </p><p style="text-align:justify">Še preden je predlog za ustanovitev nove univerze v slovenski in jugoslovanski politiki dobil kolikor toliko oprijemljivo podlago, so se začeli oblikovati prvi predlogi za kadrovsko zasedbo predvidenih petih fakultet. V ospredje je vstopilo vprašanje habilitacij. Razvnel se je spopad med »narodnjaškim« delom, ki je v ospredje postavljal nacionalne cilje pri ustanavljanju univerze in »znanstvenim« delom, ki se je želel strogo držati habilitacijskih kriterijev najbolj znanih evropskih univerz. Sicer zelo sočne podrobnosti z aktualnimi analogijami boste lahko prebrali v moji knjigi o zgodovini univerze, ki nosi naslov Svoboda duha. 
               </p><p style="text-align:justify">Polemike so bile tudi, ker je del profesorjev, vključno s prvim rektorjem, matematikom Plemljem, v slovenščini videl zgolj enega od jugoslovanskih dialektov. Tovrstne debate o jeziku in univerzi so postale javne. Po časopisih so potekale polemike za in proti slovenski univerzi, razprave s sej univerzitetnega sveta pa so bile prej pri novinarjih kot v zapisnikih, ti pa so jih seveda z užitkom uporabljali za medstrankarske boje. Tej razpravi se seveda niso izognili tudi pri potrjevanju zakona o univerzi.
               </p><p style="text-align:justify">Ko se je v maju 1919 v strankarsko nacionalno in politično raznorodni Začasni narodni skupščini postavilo vprašanje potrjevanje proračuna, je bila priložnost prava, saj je vlada potrebovala vsak glas. V proračunskih kupčkanjih je nenadoma v predlog prišla tudi postavka za slovensko univerzo v zameno, da bodo slovenski poslanci glasovali za proračun. Regent Aleksander je zakon podpisal 23. julija, v uradnem listu je zaradi vmesne vladne krize izšel mesec dni kasneje, 23. avgusta 1919. Univerza je torej točno ob pravem času postala predmet političnega barantanja, kasneje bi njena vrednost na jugoslovanski politični borzi precej padla.
               </p><p style="text-align:justify">Ustanovitev univerze je imela konstitutiven pomen za slovensko znanost in je postopoma združila profesorje, prej raztresene po raznih avstrijskih univerzah. Kljub turbulentnim razmeram je med obema vojnama uspela zadržati vse fakultete in tudi okrepila je študij na njih – tudi na medicinski fakulteti, ki je sicer ostala nepopolna, a je pred drugo svetovno vojno že dosegla študij v šestih semestrih. Postala je ena ključnih nacionalnih in kulturnih institucij, ki so svojo pot začele med obema vojnama in se z republiško državnostjo po drugi vojni vzpostavile in profesionalizirale do te mere, da je njihov prehod v samostojno državo potekal brez dramatičnih rezov. To je ljubljanski univerzi tudi omogočilo, da je danes med nekaj sto najboljšimi univerzami na svetu. Žal je veliko naporov univerzitetnih znanstvenikov šlo v nič. V tranzicijskem procesu je bil zapravljen, razprodan ali uničen velik del intelektualne dediščine: od številnih izumov, tehnoloških inovacij in svetovno priznanih proizvodov do arhitekture in dizajna, ki so ga ustvarili diplomanti in doktorandi univerze in se je udejanilo v slovenskih podjetjih. 
               </p><p style="text-align:justify">Primerjava položaja univerze ob ustanovitvi in danes kljub zelo različnim razmeram kaže precej podobnih dileme, med katerimi so najpomembnejše: 
                  <ul><li style="text-align:justify">razpon med ohranjanjem nacionalne samobitnosti in univerzalnostjo, ki je zaradi globalizacije še večji, kot je bil tedaj; zlasti gre tu za vprašanje obstoja jezika in vloge univerze pri njegovem ohranjanju, še posebej na znanstvenem področju;
                  </li><li style="text-align:justify">s tem povezan konflikt med »narodnjaško«, kot so jo tedaj imenovali in univerzalno znanostjo; torej danes med humanistiko in družboslovjem na eni in naravoslovjem in tehniko na drugi strani , kar se najbolj kaže pri vprašanju habilitacijskih meril. Po drugi strani pa gre v vsebinskem smislu za mnogo pomembnejše vprašanje, kako humanistiko in naravoslovje povezati in doseči sinergijo, saj brez tega ne bo ne slovenske, ne planetarne prihodnosti.
                  </li><li style="text-align:justify">vprašanje smisla in dejavnosti univerze: nekoč vprašanje, ali naj zgolj šola uradnike in učitelje – od tod tudi izraz vseučilišče, pa dijak in ne študent, učilnica in ne predavalnica, pouk in ne predavanja; danes naj bi bila univerza prilagojena gospodarstvu, koristna pa toliko, kolikor opravlja vlogo njegovega servisa;  
                  </li><li style="text-align:justify">večno vprašanje avtonomije univerze oziroma odnosa med univerzo in politiko ter javnostjo; tudi danes je tu seveda ključno vprašanje denarja, so pa – kljub ustavno zagotovljeni vlogi svobodi raziskovanja in izražanja – tudi razne ideološke in politične oblike pritiska na neljube oziroma družbeno angažirane profesorje, od poslanskih vprašanj do grobih osebnih napadov, ki jih omogočajo moderni spletni mediji;
                  </li><li style="text-align:justify">vprašanje razpršitve ali centralizacije univerzitetnega znanja. Tedaj je šlo za vprašanje, ali naj bi bila kar za vso novoustanovljeno jugoslovansko državo dovolj ena, že obstoječa univerza; pri Slovencih pa vprašanje, ali naj bo univerza v Zagrebu, Trstu ali Ljubljani. Po osamosvojitvi Slovenije je politika ugotovila, da bi pravzaprav vsaka slovenska vas potrebovala, če že ne svojo univerzo, pa saj fakulteto, po možnosti zasebno, a z državnim denarjem.
                  </li></ul>
               </p><p style="text-align:justify">Z nastankom univerze, ki je zbrala najpomembnejše slovenske znanstvenike, raztresene po tujih univerzah in inštitutih, se je prvič v zgodovini začela razvijati tudi slovenska znanost. Njena osnova so bili seveda doktorati. Način pridobitve doktorata po fakultetah je bil različen. Za naslov doktorja filozofije se je zahtevala doktorska disertacija (sicer sprva precej skromna, nekako na ravni med današnjo diplomo in magisterijem). Poleg tega so doktorandi opravljali rigoroz (t. i. strogi izpit). Sprva sta bila celo dva: glavni in stranski. Vprašanja so bila v glavnem povezana z vsebino disertacije. Podoben princip zagovora z rigorozom so imeli tudi na tehniki in teologiji. Na pravni fakulteti pa ni bilo pisne disertacije, doktorat so kandidati dosegli s tremi rigorozi, disertacijo pa so uvedli šele med drugo svetovno vojno. 
               </p><p style="text-align:justify">Prva doktorska promocija z disertacijo je bila julija 1920. Tipkopis je obsegal 33 strani. Doktorat je bil tedaj nekakšen zaključek študija, naravoslovje in humanistika pa prepletena, zato je bil prvi doktorat iz kemije ubranjen na Filozofski fakulteti. Prva doktorandka je bila Anka Mayer, kasneje poročena Kansky, kar pa je splet naključij, ker ni bila edina tisti dan, torej ni šlo za emancipacijske težnje tedaj še izrazito moške univerze. Doktorirala je iz kemije, tema disertacije je bila učinkovanje formalina na škrob. Promovirana je bila 15. julija 1920. Bila naj bi 72. ženska na svetu, ki je do leta 1920 prejela naziv doktorice znanosti, verjetno pa prva ženska, ki je bila hkrati tudi prvi doktorand kakšne univerze. Anka Mayer ni ostala na univerzi, zato je prva (privatna) docentka postala filozofinja Alma Sodnik, ki je po drugi svetovni vojni v petdesetih letih postala tudi prva dekanja Filozofske fakultete. Emancipacija se je v zgodovini univerze in v pretežno konservativnem slovenskem okolju uveljavljala počasi in je zagon dobila šele po drugi svetovni. Ta trend se je – z izjemo nekaj fakultet – od takrat krepko preusmeril v feminizacije univerze. V več kot stotih letih po nastanku univerze je bilo samo na Filozofski fakulteti do 31. marca 2024 ubranjenih 2305 doktoratov.
               </p><byline><p style="text-align:right">Božo Repe</p>
               </byline>
            </div>
         </div>         
      </xsl:if>
      <!--<br/>
      <p class="text-center">
         <!-\- založnik -\->
         <xsl:for-each select="tei:docImprint/tei:publisher">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
         <!-\- kraj izdaje -\->
         <xsl:for-each select="tei:docImprint/tei:pubPlace">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
         <!-\- leto izdaje -\->
         <xsl:for-each select="tei:docImprint/tei:docDate">
            <xsl:value-of select="."/>
            <br/>
         </xsl:for-each>
      </p>-->
   </xsl:template>
   
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc> Dodaten link v kolofonu takoj za naslovom </xsldoc:desc>  
   </xsldoc:doc>
   <xsl:template match="tei:titleStmt" mode="kolofon">
      <!-- avtor -->
      <p>
         <xsl:for-each select="tei:author">
            <span itemprop="author">
               <xsl:choose>
                  <xsl:when test="tei:forename or tei:surname">
                     <xsl:for-each select="tei:forename">
                        <xsl:value-of select="."/>
                        <xsl:if test="position() ne last()">
                           <xsl:text> </xsl:text>
                        </xsl:if>
                     </xsl:for-each>
                     <xsl:if test="tei:surname">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                     <xsl:for-each select="tei:surname">
                        <xsl:value-of select="."/>
                        <xsl:if test="position() ne last()">
                           <xsl:text> </xsl:text>
                        </xsl:if>
                     </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="."/>
                  </xsl:otherwise>
               </xsl:choose>
            </span>
            <xsl:if test="position() != last()">
               <br/>
            </xsl:if>
         </xsl:for-each>
      </p>
      <!-- Naslov mora vedno biti, zato ne preverjam, če obstaja. -->
      <p>
         <img src="logo_doktorati.png" alt="kolofon slika" style="max-height: 150px;"></img>
         <img src="UL_FF.png" alt="kolofon slika" style="max-height: 200px;"></img>
         <img src="SZ_logo.png" alt="kolofon slika" style="max-height: 220px;"></img>
      </p>
      <p itemprop="name">
         <xsl:for-each select="tei:title[1]">
            <b><xsl:value-of select="."/></b>
            <xsl:if test="following-sibling::tei:title">
               <xsl:text> : </xsl:text>
            </xsl:if>
            <xsl:for-each select="following-sibling::tei:title">
               <xsl:value-of select="."/>
               <xsl:if test="position() != last()">
                  <xsl:text>, </xsl:text>
               </xsl:if>
            </xsl:for-each>
         </xsl:for-each>
      </p>
      <br/>
      <p>
         <a href="https://www.facebook.com/DoktoratiFilozofskeFakultete100let">Facebook</a>
      </p>
      <br/>
      <xsl:apply-templates select="tei:respStmt" mode="kolofon"/>
      <br/>
      <xsl:if test="tei:funder">
         <xsl:for-each select="tei:funder">
            <p itemprop="funder">
               <xsl:value-of select="."/>
            </p>
         </xsl:for-each>
      </xsl:if>
      <br/>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
      <param name="thisChapter-id"></param>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="html-header">
      <xsl:param name="thisChapter-id"/>
      <xsl:param name="thisLanguage"/>
      <header>
         <div class="hide-for-large">
            <xsl:if test="$title-bar-sticky = 'true'">
               <xsl:attribute name="data-sticky-container"/>
            </xsl:if>
            <div id="header-bar">
               <xsl:if test="$title-bar-sticky = 'true'">
                  <xsl:attribute name="data-sticky"/>
                  <xsl:attribute name="data-sticky-on">small</xsl:attribute>
                  <xsl:attribute name="data-options">marginTop:0;</xsl:attribute>
                  <xsl:attribute name="style">width:100%</xsl:attribute>
                  <xsl:attribute name="data-top-anchor">1</xsl:attribute>
               </xsl:if>
               <div class="title-bar" data-responsive-toggle="publication-menu" data-hide-for="large">
                  <button class="menu-icon" type="button" data-toggle=""></button>
                  <div class="title-bar-title">
                     <xsl:choose>
                        <xsl:when test="$languages-locale='true'">
                           <xsl:call-template name="myi18n-lang">
                              <xsl:with-param name="word">Menu</xsl:with-param>
                              <xsl:with-param name="thisLanguage" select="$thisLanguage"/>
                           </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:sequence select="tei:i18n('Menu')"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </div>
                  <div class="title-bar-right">
                     <a class="title-bar-title" href="{$homeURL}">
                        <i class="fi-home" style="color:white;"></i>
                     </a>
                  </div>
                  <div id="publication-menu" class="hide-for-large">
                     <ul class="vertical menu" data-drilldown="" data-options="backButton: &lt;li class=&quot;js-drilldown-back&quot;&gt;&lt;a tabindex=&quot;0&quot;&gt;{tei:i18n('Nazaj')}&lt;/a&gt;&lt;/li&gt;;">
                        <xsl:call-template name="title-bar-list-of-contents">
                           <xsl:with-param name="title-bar-type">vertical</xsl:with-param>
                           <xsl:with-param name="thisChapter-id" select="$thisChapter-id"/>
                           <xsl:with-param name="thisLanguage" select="$thisLanguage"/>
                        </xsl:call-template>
                     </ul>
                  </div>
               </div>
            </div>
         </div>
         
         <div class="show-for-large">
            <xsl:if test="$title-bar-sticky = 'true'">
               <xsl:attribute name="data-sticky-container"/>
            </xsl:if>
            <nav class="title-bar">
               <xsl:if test="$title-bar-sticky = 'true'">
                  <xsl:attribute name="data-sticky"/>
                  <xsl:attribute name="data-options">marginTop:0;</xsl:attribute>
                  <xsl:attribute name="style">width:100%</xsl:attribute>
                  <xsl:attribute name="data-top-anchor">1</xsl:attribute>
               </xsl:if>
               <div class="title-bar-left">
                  <a class="title-bar-title" href="{$homeURL}">
                     <i class="fi-home" style="color:white;"></i>
                     <xsl:text> </xsl:text>
                     <span>
                        <xsl:value-of select="$homeLabel"/>
                     </span>
                  </a>
               </div>
               <div class="title-bar-right">
                  <ul class="dropdown menu" data-dropdown-menu="">
                     <xsl:call-template name="title-bar-list-of-contents">
                        <xsl:with-param name="title-bar-type">dropdown</xsl:with-param>
                        <xsl:with-param name="thisChapter-id" select="$thisChapter-id"/>
                        <xsl:with-param name="thisLanguage" select="$thisLanguage"/>
                     </xsl:call-template>
                  </ul>
               </div>
            </nav>
         </div>
         
         <!-- iskalnik -->
         <xsl:if test="ancestor-or-self::tei:TEI/tei:text/tei:front/tei:divGen[@type='search']">
            <xsl:choose>
               <xsl:when test="$languages-locale='true'">
                  <xsl:variable name="sistoryPath-search">
                     <xsl:if test="$chapterAsSIstoryPublications='true'">
                        <xsl:call-template name="sistoryPath">
                           <xsl:with-param name="chapterID" select="ancestor-or-self::tei:TEI/tei:text/tei:front/tei:divGen[@type='search'][@xml:lang=$thisLanguage]/@xml:id"/>
                        </xsl:call-template>
                     </xsl:if>
                  </xsl:variable>
                  <form action="{concat($sistoryPath-search,ancestor-or-self::tei:TEI/tei:text/tei:front/tei:divGen[@type='search'][@xml:lang=$thisLanguage]/@xml:id,'.html')}">
                     <div class="row collapse">
                        <div class="small-10 large-11 columns">
                           <input type="text" name="q" id="tipue_search_input">
                              <xsl:attribute name="placeholder">
                                 <xsl:call-template name="myi18n-lang">
                                    <xsl:with-param name="word">Search placeholder</xsl:with-param>
                                    <xsl:with-param name="thisLanguage" select="$thisLanguage"/>
                                 </xsl:call-template>
                              </xsl:attribute>
                           </input>
                        </div>
                        <div class="small-2 large-1 columns">
                           <img type="button" class="tipue_search_button"/>
                        </div>
                     </div>
                  </form>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:variable name="sistoryPath-search">
                     <xsl:if test="$chapterAsSIstoryPublications='true'">
                        <xsl:call-template name="sistoryPath">
                           <xsl:with-param name="chapterID" select="ancestor-or-self::tei:TEI/tei:text/tei:front/tei:divGen[@type='search']/@xml:id"/>
                        </xsl:call-template>
                     </xsl:if>
                  </xsl:variable>
                  <form action="{concat($sistoryPath-search,ancestor-or-self::tei:TEI/tei:text/tei:front/tei:divGen[@type='search']/@xml:id,'.html')}">
                     <div class="row collapse">
                        <div class="small-10 large-11 columns">
                           <input type="text" name="q" id="tipue_search_input" placeholder="{tei:i18n('Search placeholder')}"/>
                        </div>
                        <div class="small-2 large-1 columns">
                           <img type="button" class="tipue_search_button"/>
                        </div>
                     </div>
                  </form>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:if>
         <p style="text-align:center;"><img src="logo_doktorati.png" width="50%"></img></p>
      </header>
   </xsl:template>

</xsl:stylesheet>
