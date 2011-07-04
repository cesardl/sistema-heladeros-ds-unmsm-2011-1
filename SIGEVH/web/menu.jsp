<%-- 
    Document   : menu
    Created on : 19/06/2011, 02:50:04 PM
    Author     : Cesardl
--%>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib prefix="rich" uri="http://richfaces.org/rich"%>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j"%>

<f:subview id="menu">
    <h:form>
        <rich:toolBar>
            <rich:dropDownMenu>
                <f:facet name="label"> 
                    <h:panelGroup>
                        <h:outputText value="Reportes"/>
                    </h:panelGroup> 
                </f:facet>

                <rich:menuItem submitMode="ajax" value="Reporte de ventas por fecha" />

                <rich:menuItem submitMode="ajax" value="Reporte de ventas por heladero" />
            </rich:dropDownMenu>

            <rich:dropDownMenu>
                <f:facet name="label"> 
                    <h:panelGroup>
                        <h:outputText value="Sistema / usuarios"/>
                    </h:panelGroup>
                </f:facet>

                <rich:menuItem submitMode="ajax" value="Heladeros" action="TO_HELADEROS" />

                <rich:menuItem submitMode="ajax" value="Usuarios" />
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
