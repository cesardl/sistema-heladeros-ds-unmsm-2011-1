<%-- 
    Document   : heladeros
    Created on : 27-jun-2011, 22:34:55
    Author     : cesardl
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib prefix="rich" uri="http://richfaces.org/rich"%>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <html>
        <head>
            <title>Heladeros</title>
            <link type="text/css" href="style/default.css" rel="stylesheet" media="screen">
        </head>
        <body>
            <jsp:include page="../menu.jsp"/>
            <rich:panel>
                <h:form id="formHeladeros">
                    <table width="100%">
                        <tr>
                            <td colspan="2">
                                <h:outputText value="Mantenimiento de heladeros"
                                              styleClass="title-label" />
                            </td>
                            <td align="right">
                                <h:panelGrid columns="2">
                                    <a4j:commandButton value="Buscar" reRender="scrollerHeladeros, tableHeladeros" 
                                                       actionListener="#{managerHeladero.buscarHeladero}"/>
                                    <a4j:commandButton value="Nuevo" />
                                </h:panelGrid>
                            </td>
                        </tr>
                        <tr class="tr-separator">
                            <td colspan="3">
                                <rich:separator width="100%" height="3px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label">Nombre</td>
                            <td><h:inputText value="#{managerHeladero.nombre}"/></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="td-label">Apellido</td>
                            <td><h:inputText value="#{managerHeladero.apellido}" /></td>
                            <td></td>
                        </tr>
                        <tr class="tr-separator">
                            <td colspan="3">
                                <rich:separator width="100%" height="3px" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <rich:datascroller id="scrollerHeladeros" align="right" for="tableHeladeros" 
                                                   maxPages="10" style="width : 75%;"/>
                                <rich:spacer height="3px"/>
                                <rich:dataTable id="tableHeladeros" width="75%" rows="10"
                                                onRowMouseOver="this.style.backgroundColor='#F1F1F1'"
                                                onRowMouseOut="this.style.backgroundColor='#{a4jSkin.tableBackgroundColor}'"
                                                value="#{managerHeladero.listaHeladeros}" var="heladero">

                                    <f:param id="p_id_heladero" value="#{heladero.idHeladero}" />
                                    <rich:column style="text-align: center;">
                                        <f:facet name="header">
                                            <h:outputText value="Nro" />
                                        </f:facet>
                                        <h:outputText value="#{heladero.idHeladero}"/>
                                    </rich:column>

                                    <rich:column>
                                        <f:facet name="header">
                                            <h:outputText value="Nombre y apellido" />
                                        </f:facet>
                                        <h:outputText value="#{heladero.nombres} #{heladero.apellidos}"/>
                                    </rich:column>

                                    <rich:column>
                                        <f:facet name="header">
                                            <h:outputText value="Concesionario" />
                                        </f:facet>
                                        <h:outputText value="#{heladero.concesionario.nombreConces}"/>
                                    </rich:column>

                                    <rich:column style="text-align: center;">
                                        <f:facet name="header">
                                            <h:outputText value="Asignar" />
                                        </f:facet>
                                        <a4j:commandButton value="Asignar" reRender="mp_asignar_helados"
                                                           actionListener="#{managerAsignacion.asignarHelado}"
                                                           oncomplete="#{rich:component('mp_asignar_helados')}.show()" />
                                    </rich:column>

                                    <rich:column style="text-align: center;">
                                        <f:facet name="header">
                                            <h:outputText value="Pagas" />
                                        </f:facet>
                                        <a4j:commandButton value="Pagar" />
                                    </rich:column>
                                </rich:dataTable>
                            </td>
                        </tr>
                    </table>
                </h:form>
            </rich:panel>
        </body>
    </html>
    <jsp:include page="asignar_helados.jsp" />
    <jsp:include page="pagar_heladero.jsp" />
</f:view>