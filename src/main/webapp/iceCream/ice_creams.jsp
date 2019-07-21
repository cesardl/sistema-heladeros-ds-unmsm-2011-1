<%--
  Created by IntelliJ IDEA.
  User: Cesardl
  Date: 21/07/2019
  Time: 0:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<%@taglib prefix="rich" uri="http://richfaces.org/rich" %>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j" %>

<f:view>
    <html>
    <head>
        <title>Ice Creams</title>
        <link type="text/css" href="../style/default.css" rel="stylesheet" media="screen">
    </head>
    <body>
    <jsp:include page="../menu.jsp"/>
    <rich:panel>
        <h:form id="formIceCreams">
            <table style="width: 100%">
                <tr>
                    <td>
                        <h:outputText value="Mantenimiento de helados"
                                      styleClass="title-label"/>
                    </td>
                    <td align="right">
                        <h:panelGrid columns="2">
                            <a4j:status>
                                <f:facet name="start">
                                    <h:graphicImage value="images/loading2.gif"/>
                                </f:facet>
                            </a4j:status>
                            <a4j:commandButton value="Nuevo"
                                               image="images/new.png"
                                               actionListener="#{managerIceCream.newIceCream}"
                            />
                        </h:panelGrid>
                    </td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="3">
                        <rich:separator width="100%" height="3px"/>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="3">
                        <rich:dataTable id="tableIceCreams" value="#{managerIceCream.iceCreamsList}" var="iceCream"
                                        rows="25" style="width : 90%;">

                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Nro"/>
                                </f:facet>
                                <h:outputText value="#{iceCream.idHelado}"/>
                            </rich:column>

                            <rich:column sortBy="#{iceCream.nombreHelado}">
                                <f:facet name="header">
                                    <h:outputText value="Nombre"/>
                                </f:facet>
                                <h:outputText value="#{iceCream.nombreHelado}"/>
                            </rich:column>

                            <rich:column sortBy="#{iceCream.stockHelado.cantidad}">
                                <f:facet name="header">
                                    <h:outputText value="Stock"/>
                                </f:facet>
                                <h:outputText
                                        value="#{iceCream.stockHelado == null ? 0 : iceCream.stockHelado.cantidad}"/>
                            </rich:column>

                            <f:facet name="footer">
                                <rich:datascroller id="scrollerIceCream" for="tableIceCreams" fastStep="3"/>
                            </f:facet>
                        </rich:dataTable>
                    </td>
                </tr>
            </table>
        </h:form>
    </rich:panel>
    </body>
    </html>
</f:view>
