<%--
    Document   : heladeros
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
        <title>Heladeros</title>
        <link type="text/css" href="../style/default.css" rel="stylesheet" media="screen">
    </head>
    <body>
    <jsp:include page="../menu.jsp"/>
    <rich:panel>
        <h:form id="formHeladeros">
            <table width="100%">
                <tr>
                    <td colspan="2">
                        <h:outputText value="Mantenimiento de heladeros"
                                      styleClass="title-label"/>
                    </td>
                    <td align="right">
                        <h:panelGrid columns="3">
                            <a4j:status>
                                <f:facet name="start">
                                    <h:graphicImage value="images/loading2.gif"/>
                                </f:facet>
                            </a4j:status>
                            <a4j:commandButton value="Buscar"
                                               image="images/view.png"
                                               reRender="scrollerHeladeros, tableHeladeros, lengthHeladeros"
                                               actionListener="#{managerHeladero.buscarHeladero}"/>
                            <a4j:commandButton value="Nuevo"
                                               image="images/new.png"
                                               reRender="mp_ice_cream_man"
                                               actionListener="#{managerHeladero.newIceCreamMan}"
                                               oncomplete="Richfaces.showModalPanel('mp_ice_cream_man');"/>
                        </h:panelGrid>
                    </td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="3">
                        <rich:separator width="100%" height="3px"/>
                    </td>
                </tr>
                <tr>
                    <td class="td-label">Nombre</td>
                    <td><h:inputText value="#{managerHeladero.nombre}"/></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="td-label">Apellido</td>
                    <td><h:inputText value="#{managerHeladero.apellido}"/></td>
                    <td></td>
                </tr>
                <%@ page import="pe.lamborgini.domain.mapping.Usuario" %>
                <%
                    Usuario u = (Usuario) session.getAttribute("usuario");
                    if (pe.lamborgini.domain.mapping.RoleType.ADMIN.equals(u.getRoleType())) {
                %>
                <tr>
                    <td class="td-label">Concesionario</td>
                    <td>
                        <h:selectOneMenu value="#{managerHeladero.concessionaireId}">
                            <f:selectItems value="#{managerHeladero.concessionaires}"/>
                        </h:selectOneMenu>
                    </td>
                    <td></td>
                </tr>
                <%
                    }
                %>
                <tr class="tr-separator">
                    <td colspan="3">
                        <rich:separator width="100%" height="3px"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <rich:datascroller id="scrollerHeladeros" align="right" for="tableHeladeros"
                                           maxPages="10" style="width : 90%;"/>
                        <rich:spacer height="3px"/>
                        <rich:dataTable id="tableHeladeros" width="90%" rows="10"
                                        onRowMouseOver="this.style.backgroundColor='#F1F1F1'"
                                        onRowMouseOut="this.style.backgroundColor='#{a4jSkin.tableBackgroundColor}'"
                                        value="#{managerHeladero.listaHeladeros}" var="heladero">

                            <f:param id="p_id_heladero" value="#{heladero.idHeladero}"/>
                            <f:param id="p_nombres_heladero" value="#{heladero.lastName} #{heladero.nombres}"/>
                            <f:param id="p_nombre_consecionario" value="#{heladero.concesionario.nombreConces}"/>
                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Nro"/>
                                </f:facet>
                                <h:outputText value="#{heladero.idHeladero}"/>
                            </rich:column>

                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="Apellido y nombre"/>
                                </f:facet>
                                <h:outputText value="#{heladero.lastName} #{heladero.nombres}"/>
                            </rich:column>

                            <%
                                if (pe.lamborgini.domain.mapping.RoleType.ADMIN.equals(u.getRoleType())) {
                            %>
                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="Concesionario"/>
                                </f:facet>
                                <h:outputText value="#{heladero.concesionario.nombreConces}"/>
                            </rich:column>
                            <%
                                }
                            %>

                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Editar"/>
                                </f:facet>
                                <a4j:commandButton image="images/edit.gif"
                                                   reRender="mp_ice_cream_man"
                                                   oncomplete="Richfaces.showModalPanel('mp_ice_cream_man');">
                                    <f:setPropertyActionListener target="#{managerHeladero.editedIceCreamMan}"
                                                                 value="#{heladero}"/>
                                </a4j:commandButton>
                            </rich:column>

                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Asignar"/>
                                </f:facet>
                                <a4j:commandButton
                                        image="#{heladero.heladosEntregadoRecibidos.size() == 0 ? 'images/assignation.png' : 'images/assignation_gray.png'}"
                                        reRender="mp_asignar_helados"
                                        actionListener="#{managerAsignacion.asignarHelado}"
                                        oncomplete="#{managerAsignacion.oncomplete}"/>
                            </rich:column>

                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Pagar"/>
                                </f:facet>
                                <a4j:commandButton
                                        image="#{heladero.heladosEntregadoRecibidos.size() == 0 ? 'images/payment_gray.png' : 'images/payment.png'}"
                                        reRender="mp_pagar_heladero"
                                        actionListener="#{managerPago.pagarHeladero}"
                                        oncomplete="#{managerPago.oncomplete}"/>
                            </rich:column>

                            <f:facet name="footer">
                                <h:outputText id="lengthHeladeros"
                                              value="Total rows: #{fn:length(managerHeladero.listaHeladeros)}"/>
                            </f:facet>
                        </rich:dataTable>
                    </td>
                </tr>
            </table>
        </h:form>
    </rich:panel>
    </body>
    </html>
    <jsp:include page="model_ice_cream_man.jsp"/>
    <jsp:include page="asignar_helados.jsp"/>
    <jsp:include page="pagar_heladero.jsp"/>
</f:view>
