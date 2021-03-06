<%--
    Document   : asignar_helados
    Created on : 19/06/2011, 02:50:04 PM
    Author     : Cesardl
--%>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<%@taglib prefix="rich" uri="http://richfaces.org/rich" %>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j" %>

<f:subview id="asignar_helados">
    <script type="text/javascript">
        function printObjectsSelected(sgcomponent, iIdHelado, iNombreHelado) {
            iIdHelado.value = sgcomponent.getSelectedItems().pluck('idHelado');
            iNombreHelado.innerHTML = sgcomponent.getSelectedItems().pluck('nombreHelado');
        }
    </script>
    <rich:modalPanel id="mp_asignar_helados" width="550" autosized="true">
        <f:facet name="header">
            <h:outputText value="Asignacion de Helados"/>
        </f:facet>
        <f:facet name="controls">
            <h:graphicImage value="../images/close.png" style="cursor: pointer;"
                            onclick="Richfaces.hideModalPanel('mp_asignar_helados');"/>
        </f:facet>
        <a4j:form id="formAsignacion">
            <table style="width: 100%;">
                <tr style="text-align: right;">
                    <td colspan="3">
                        <a4j:commandButton value="Guardar"
                                           image="images/save.png"
                                           actionListener="#{managerAsignacion.saveAssignations}"
                                           oncomplete="#{managerAsignacion.oncomplete}"
                                           reRender="mp_ice_cream_without_stock, formHeladeros"/>
                    </td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="3">
                        <rich:separator width="100%" height="3px"/>
                    </td>
                </tr>
                <tr>
                    <td class="td-label">Consecionario</td>
                    <td><h:outputText value="#{managerAsignacion.paramConcessionaireName}"/></td>
                </tr>
                <tr>
                    <td class="td-label">Heladero</td>
                    <td><h:outputText value="#{managerAsignacion.paramIceCreamManNames}"/></td>
                </tr>
                <tr>
                    <td class="td-label">Helado</td>
                    <td colspan="2">
                        <h:inputText id="iSugHelado" value="#{managerAsignacion.suggestedIceCream}"
                                     style="width:200px;"/>
                        <rich:suggestionbox id="suggestionHelado"
                                            for="iSugHelado" nothingLabel="Helado no encontrado"
                                            suggestionAction="#{managerAsignacion.autocomplete}" var="he"
                                            height="150" width="350" cellpadding="2"
                                            cellspacing="2" shadowOpacity="4" shadowDepth="4"
                                            minChars="2" zindex="3500"
                                            usingSuggestObjects="true"
                                            onobjectchange="printObjectsSelected(#{rich:component('suggestionHelado')},#{rich:element('iIdHelado')},#{rich:element('iHelado')});">
                            <h:column>
                                <h:outputText value="#{he.nombreHelado}" style="font-style:bold"/>
                            </h:column>
                        </rich:suggestionbox>
                        <h:inputHidden id="iIdHelado" value="#{managerAsignacion.suggestedIceCreamId}"/>
                        <h:outputText id="iHelado" style="font-weight: bold; font-style: italic;"/>
                    </td>
                </tr>
                <tr>
                    <td class="td-label">Cantidad</td>
                    <td><h:inputText value="#{managerAsignacion.quantity}"/></td>
                    <td><a4j:commandButton image="../images/edit_add.png" reRender="formAsignacion"
                                           actionListener="#{managerAsignacion.addIceCream}"
                                           oncomplete="#{managerAsignacion.oncomplete}"/></td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="3">
                        <rich:separator width="100%" height="3px"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <rich:datascroller id="scrollerHelados" align="right" for="tableHelados"
                                           maxPages="10" style="width : 75%;"/>
                        <rich:spacer height="3px"/>
                        <rich:dataTable id="tableHelados" width="75%" rows="10"
                                        onRowMouseOver="this.style.backgroundColor='#F1F1F1'"
                                        onRowMouseOut="this.style.backgroundColor='#{a4jSkin.tableBackgroundColor}'"
                                        var="dh" value="#{managerAsignacion.iceCreamDetailsList}">

                            <f:param id="dh_pos" value="#{dh.position}"/>
                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="Nro"/>
                                </f:facet>
                                <h:outputText value="#{dh.position}"/>
                            </rich:column>

                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="Helado"/>
                                </f:facet>
                                <h:outputText value="#{dh.helado.nombreHelado}"/>
                            </rich:column>

                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Entregados"/>
                                </f:facet>
                                <h:outputText value="#{dh.cantEntregada}"/>
                            </rich:column>

                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Quitar"/>
                                </f:facet>
                                <a4j:commandButton image="../images/edit_remove.png" reRender="tableHelados"
                                                   actionListener="#{managerAsignacion.removeIceCream}"/>
                            </rich:column>
                        </rich:dataTable>
                    </td>
                </tr>
            </table>
        </a4j:form>
    </rich:modalPanel>

    <rich:modalPanel id="mp_ice_cream_without_stock" width="300" autosized="true">
        <f:facet name="header">
            <h:outputText value="Ice cream without stocks"/>
        </f:facet>
        <h:form>
            <rich:dataList value="#{managerAsignacion.iceCreamWithoutStock}" var="iceCream">
                <h:outputText value="#{iceCream.helado.nombreHelado}" styleClass="td-label"/>
            </rich:dataList>
            <div style="text-align: right;">
                <a4j:commandButton value="OK"
                                   onclick="Richfaces.hideModalPanel('mp_ice_cream_without_stock');"/>
            </div>
        </h:form>
    </rich:modalPanel>
</f:subview>
