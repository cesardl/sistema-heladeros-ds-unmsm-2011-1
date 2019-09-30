<%--
    Document   : usuarios
    Created on : 27-jun-2011, 22:34:55
    Author     : cesardl
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

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
        <title>Usuarios</title>
        <link type="text/css" href="../style/default.css" rel="stylesheet" media="screen">
    </head>
    <body>
    <jsp:include page="../menu.jsp"/>
    <rich:panel>
        <h:form id="formUsuarios">
            <table width="100%">
                <tr>
                    <td colspan="2">
                        <h:outputText value="Mantenimiento de usuarios"
                                      styleClass="title-label"/>
                    </td>
                    <td align="right">
                        <h:panelGrid columns="2">
                            <a4j:commandButton value="Nuevo"
                                               image="images/new.png"/>
                        </h:panelGrid>
                    </td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="3">
                        <rich:separator width="100%" height="3px"/>
                    </td>
                </tr>
                <tr>
                    <td class="td-label">Concesionario</td>
                    <td>
                        <h:selectOneMenu value="#{managerUsuario.concessionaireId}">
                            <f:selectItems value="#{managerUsuario.concessionaires}"/>
                            <a4j:support event="onchange" actionListener="#{managerUsuario.findByConcessionaire}"
                                         reRender="tableUsuarios"/>
                        </h:selectOneMenu>
                    </td>
                    <td></td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="3">
                        <rich:separator width="100%" height="3px"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <rich:spacer height="3px"/>
                        <rich:dataTable id="tableUsuarios" width="90%" rows="10"
                                        onRowMouseOver="this.style.backgroundColor='#F1F1F1'"
                                        onRowMouseOut="this.style.backgroundColor='#{a4jSkin.tableBackgroundColor}'"
                                        value="#{managerUsuario.listaUsuarios}" var="user">

                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Nro"/>
                                </f:facet>
                                <h:outputText value="#{user.idUsuario}"/>
                            </rich:column>

                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="User"/>
                                </f:facet>
                                <h:outputText value="#{user.nombreUsuario}"/>
                            </rich:column>

                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="Owner"/>
                                </f:facet>
                                <h:outputText value="#{user.concesionario.propietario}"/>
                            </rich:column>

                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="Position"/>
                                </f:facet>
                                <h:outputText value="#{user.cargo}"/>
                            </rich:column>

                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="Concessionaire"/>
                                </f:facet>
                                <h:outputText value="#{user.concesionario.nombreConces}"/>
                            </rich:column>

                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="District"/>
                                </f:facet>
                                <h:outputText value="#{user.concesionario.distrito}"/>
                            </rich:column>

                            <f:facet name="footer">
                                <h:outputText id="lengthHeladeros"
                                              value="Total rows: #{fn:length(managerUsuario.listaUsuarios)}"/>
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
