<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    <xsl:output method="html" indent="yes" />
    <xsl:template match="/">
        <html lang="es">
            <head>
                <meta charset="UTF-8" />
                <title>Participantes</title>
                <link rel="stylesheet" href="estilos.css" />
            </head>
            <body>
                <div class="header">
                    <h1>Información del concurso</h1>
                </div>

                <main>
                    <h2>Listado de Participantes</h2>
                    <ol class="participantes">
                        <xsl:for-each select="//participante">
                            <xsl:sort select="apellidos" order="ascending"></xsl:sort>
                            <!-- Lista de participantes-->
                            <li>
                                <xsl:value-of select="apellidos" />
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="nombre" />
                                <xsl:text>, (</xsl:text>
                                <xsl:value-of select="@codigo" />
                                <xsl:text>) - </xsl:text>
                                <xsl:value-of select="puntos" />
                                <xsl:text> puntos</xsl:text>
                            </li>
                        </xsl:for-each>
                    </ol>
                    <!--tabla-->
                    <h2>5 - Mejores participantes con más de 20 puntos</h2>
                    <table class="participantes-t ancho">
                        <thead>
                            <tr>
                                <th>Posición</th>
                                <th>Participante</th>
                                <th>Puntos</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Tabla de participantes-->
                            <xsl:for-each select="//participante[puntos>=20]">
                            <xsl:sort select="puntos" order="descending"/>
                            <xsl:if test="position()&lt;=5">
                                <tr>
                                    <td>
                                        <xsl:value-of select="position()"></xsl:value-of>
                                    </td>
                                    <td>
                                        <xsl:value-of select="apellidos" />
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="nombre" />
                                    </td>
                                    <td>
                                        <xsl:value-of select="puntos" />
                                    </td>
                                </tr>
                            </xsl:if>
                            </xsl:for-each>
                        </tbody>
                    </table>
                    <!--Estadisticas-->
                    <div class="estad">
                        <h2>Estadísticas</h2>
                        <xsl:variable name="v_num_part" select="count(//participante)"/>
                        <xsl:variable name="v_num_part18_35" select="count(//participante[edad&gt;=18 and edad&lt;=35])"/>
                        <xsl:variable name="v_num_part36_55" select="count(//participante[edad&gt;=36 and edad&lt;=55])"/>
                        <xsl:variable name="v_num_part_55" select="count(//participante[edad&gt;55])"/>
                        <ul>
                            <li><span>Número total de participantes:</span> <span class="stats"><xsl:value-of select="count(//participante)"/></span></li>
                            <li><span>Puntuación media:</span> <span class="stats"><xsl:value-of select="round(sum(//participante/puntos) div count(//participante)*10) div 10 "/></span></li>
                            <li><span>Participantes de 18 a 35 años:</span> <span class="stats"><xsl:value-of select="v_num_part18_35"/>(<xsl:value-of select="format-number($v_num_part18_35 div $v_num_part, '0.00%')"/>)</span></li>
                            <li><span>Participantes de 36 a 55 años:</span> <span class="stats"><xsl:value-of select="$v_num_part36_55"/>(<xsl:value-of select="format-number($v_num_part36_55 div $v_num_part, '0.00%')"/>)</span></li>
                            <li><span>Participantes de más de 55 años:</span> <span class="stats"><xsl:value-of select="$v_num_part_55"/> (<xsl:value-of select="format-number($v_num_part_55 div $v_num_part, '0.00%')"/>)</span></li>
                        </ul>
                        <!-- FINAL-->
                        <table class="participantes-t">
                            <thead>
                                <tr>
                                    <th>Provincia</th>
                                    <th>Nº Participantes</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="//participante[not(provincia=preceding::provincia)]">
                                <xsl:sort select="provincia"/>
                                <xsl:variable name="v_prov" select="provincia"/>
                                    <tr>
                                        <td><xsl:value-of select="provincia"/></td>
                                        <td><xsl:value-of select="count(//participante[provincia=$v_prov])"/></td>
                                    </tr>
                                </xsl:for-each>
                                <!-- Tabla de participantes por provincia -->
                            </tbody>
                        </table>
                    </div>
                </main>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>