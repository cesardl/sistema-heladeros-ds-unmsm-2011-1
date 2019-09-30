<%--
    Document   : menu
    Created on : 19/06/2011, 02:50:04 PM
    Author     : Cesardl
--%>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<%@taglib prefix="rich" uri="http://richfaces.org/rich" %>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j" %>

<f:subview id="menu">
    <div style="font-weight: bold; font-size: 13px;">
        <%@ page import="pe.lamborgini.domain.mapping.Usuario" %>
        <%
            Usuario u = (Usuario) session.getAttribute("usuario");
            if (u == null) {
                out.print("Logueese por favor");
            } else {
                out.println("Bienvenido " + u.getNombreUsuario() + " - "
                        + "Concesionario " + u.getConcesionario().getNombreConces());
            }
        %>
    </div>
    <rich:separator width="100%" height="3px"/>
    <h:form>
        <rich:toolBar>
            <rich:dropDownMenu>
                <f:facet name="label">
                    <h:panelGroup>
                        <h:outputText value="Reportes"/>
                    </h:panelGroup>
                </f:facet>

                <rich:menuItem submitMode="ajax" value="Reporte de ventas por fecha"/>

                <rich:menuItem submitMode="ajax" value="Reporte de ventas por heladero"/>
            </rich:dropDownMenu>

            <rich:dropDownMenu>
                <f:facet name="label">
                    <h:panelGroup>
                        <h:outputText value="Sistema"/>
                    </h:panelGroup>
                </f:facet>

                <rich:menuItem submitMode="ajax" value="Helados" action="TO_ICE_CREAMS"/>

                <rich:menuItem submitMode="ajax" value="Heladeros" action="TO_HELADEROS"/>

                <%
                    if (pe.lamborgini.domain.mapping.RoleType.ADMIN.equals(u.getRoleType())) {
                %>
                <rich:menuItem submitMode="ajax" value="Usuarios" action="TO_USUARIOS"/>
                <%
                    }
                %>
            </rich:dropDownMenu>

            <rich:dropDownMenu>
                <f:facet name="label">
                    <h:panelGroup>
                        <h:outputText value="Ayuda"/>
                    </h:panelGroup>
                </f:facet>

                <rich:menuItem submitMode="ajax" value="Salir"
                               action="#{managerUsuario.salir}"/>
            </rich:dropDownMenu>
        </rich:toolBar>
    </h:form>
</f:subview>
