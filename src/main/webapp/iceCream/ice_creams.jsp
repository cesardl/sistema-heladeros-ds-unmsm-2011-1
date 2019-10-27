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
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="rich" uri="http://richfaces.org/rich" %>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <html>
    <head>
        <title>Ice Creams</title>
    </head>
    <body>
    <jsp:include page="../menu.jsp"/>
    <rich:panel>
        <h:form id="formIceCreams">
            <table style="width: 100%">
                <tr>
                    <td>
                        <h:outputText value="Mantenimiento de helados" styleClass="title-label"/>
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
                                               reRender="mp_ice_cream"
                                               actionListener="#{managerIceCream.newIceCream}"
                                               oncomplete="Richfaces.showModalPanel('mp_ice_cream');"/>
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
                        <rich:datascroller id="scrollerIceCream" align="right" for="tableIceCreams"
                                           style="width : 90%;"/>
                        <rich:spacer height="3px"/>
                        <rich:dataTable id="tableIceCreams" width="90%" rows="20" rowClasses="odd-row, even-row"
                                        value="#{managerIceCream.iceCreamsList}" var="iceCream">

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

                            <rich:column sortBy="#{iceCream.precio}">
                                <f:facet name="header">
                                    <h:outputText value="Precio"/>
                                </f:facet>
                                <h:outputText
                                        value="#{iceCream.precio}"/>
                            </rich:column>

                            <rich:column sortBy="#{iceCream.stockHelado.cantidad}">
                                <f:facet name="header">
                                    <h:outputText value="Stock"/>
                                </f:facet>
                                <h:outputText
                                        value="#{iceCream.stockHelado == null ? 0 : iceCream.stockHelado.cantidad}"/>
                            </rich:column>

                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Editar"/>
                                </f:facet>
                                <a4j:commandButton image="images/edit.gif"
                                                   reRender="mp_ice_cream"
                                                   oncomplete="Richfaces.showModalPanel('mp_ice_cream');">
                                    <f:setPropertyActionListener target="#{managerIceCream.editedIceCream}"
                                                                 value="#{iceCream}"/>
                                </a4j:commandButton>
                            </rich:column>

                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Eliminar"/>
                                </f:facet>
                                <a4j:commandButton image="images/delete.gif"
                                                   reRender="mp_ice_cream_deletion_confirm"
                                                   oncomplete="Richfaces.showModalPanel('mp_ice_cream_deletion_confirm')">
                                    <f:setPropertyActionListener target="#{managerIceCream.editedIceCream}"
                                                                 value="#{iceCream}"/>
                                </a4j:commandButton>
                            </rich:column>

                            <f:facet name="footer">
                                <h:outputText id="lengthHeladeros"
                                              value="Total rows: #{fn:length(managerIceCream.iceCreamsList)}"/>
                            </f:facet>
                        </rich:dataTable>
                    </td>
                </tr>
            </table>
        </h:form>
    </rich:panel>
    </body>
    </html>

    <jsp:include page="model_ice_cream.jsp"/>

    <rich:modalPanel id="mp_ice_cream_deletion_confirm" width="300" autosized="true">
        <f:facet name="header">
            <h:outputText value="Ice cream deletion"/>
        </f:facet>
        <h:outputText value="Está seguro de eliminar el helado #{managerIceCream.editedIceCream.nombreHelado}?"/>
        <h:form id="deletionIceCream">
            <div style="text-align: right;padding-top: 10px;">
                <a4j:commandButton value="Delete" actionListener="#{managerIceCream.delete}"
                                   oncomplete="#{managerIceCream.oncomplete}"
                                   reRender="formIceCreams"/>
                <a4j:commandButton value="Cancel"
                                   onclick="Richfaces.hideModalPanel('mp_ice_cream_deletion_confirm');"/>
            </div>
        </h:form>
    </rich:modalPanel>
</f:view>
