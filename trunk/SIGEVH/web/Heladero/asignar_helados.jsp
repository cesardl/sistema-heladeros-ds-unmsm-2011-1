<%-- 
    Document   : asignar_helados
    Created on : 19/06/2011, 02:50:04 PM
    Author     : Cesardl
--%>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib prefix="rich" uri="http://richfaces.org/rich"%>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j"%>

<f:subview id="asignar_helados">
    <script type="text/javascript">
        function printObjectsSelected(sgcomponent,iIdHelado,iNombreHelado) {
            iIdHelado.value=sgcomponent.getSelectedItems().pluck('idHelado');
            iNombreHelado.innerHTML=sgcomponent.getSelectedItems().pluck('nombreHelado');
        }
    </script>
    <rich:modalPanel  id="mp_asignar_helados" minHeight="200" minWidth="450" 
                      height="200" width="500">
        <f:facet name="header">
            <h:outputText value="Asignacion de Helados" />
        </f:facet>
        <f:facet name="controls">
            <h:graphicImage value="../images/close.png" style="cursor: pointer;"
                            onclick="#{rich:component('mp_asignar_helados')}.hide()" />
        </f:facet>
        <h:form id="formAsignacion">
            <table>
                <tr align="right">
                    <td colspan="3">
                        <a4j:commandButton value="Guardar" 
                                           actionListener="#{managerHeladero.guardarAsignaciones}"
                                           oncomplete="#{managerHeladero.oncomplete}"
                                           reRender="formHeladeros" />
                    </td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="3">
                        <rich:separator width="100%" height="3px" />
                    </td>
                </tr>
                <tr>
                    <td class="td-label">Helado</td>
                    <td colspan="2">
                        <h:inputText id="iSugHelado" value="#{managerHeladero.sug_helado}" style="width:200px;" />
                        <rich:suggestionbox id="suggestionHelado"
                                            for="iSugHelado" nothingLabel="Helado no encontrado"
                                            suggestionAction="#{managerHeladero.autocomplete}" var="he"
                                            height="150" width="350" cellpadding="2"
                                            cellspacing="2" shadowOpacity="4" shadowDepth="4"
                                            minChars="3" rules="none" zindex="3500"
                                            usingSuggestObjects="true"
                                            onobjectchange="printObjectsSelected(#{rich:component('suggestionHelado')},#{rich:element('iIdHelado')},#{rich:element('iHelado')});"
                                            >
                            <h:column>
                                <h:outputText value="#{he.nombreHelado}" style="font-style:bold"/>
                            </h:column>
                        </rich:suggestionbox>
                        <h:inputHidden id="iIdHelado" value="#{managerHeladero.sug_id_helado}" />
                        <h:outputText id="iHelado" style="font-weight: bold;" />
                    </td>
                </tr>
                <tr>
                    <td class="td-label">Cantidad</td>
                    <td><h:inputText value="#{managerHeladero.cantidad}"/></td>
                    <td><a4j:commandButton image="../images/edit_add.png" reRender="formAsignacion"
                                       actionListener="#{managerHeladero.addHelado}" 
                                       oncomplete="#{managerHeladero.oncomplete}" /></td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="3">
                        <rich:separator width="100%" height="3px" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <rich:dataTable id="tableHelados" width="75%" rows="10"
                                        onRowMouseOver="this.style.backgroundColor='#F1F1F1'"
                                        onRowMouseOut="this.style.backgroundColor='#{a4jSkin.tableBackgroundColor}'"
                                        var="dh" value="#{managerHeladero.listaDetalleHelados}">

                            <f:param id="dh_pos" value="#{dh.posicion}" />
                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="Nro" />
                                </f:facet>
                                <h:outputText value="#{dh.posicion}"/>
                            </rich:column>

                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="Helado" />
                                </f:facet>
                                <h:outputText value="#{dh.helado.nombreHelado}"/>
                            </rich:column>

                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Entregados" />
                                </f:facet>
                                <h:outputText value="#{dh.cantEntregada}"/>
                            </rich:column>

                            <rich:column style="text-align: center;">
                                <f:facet name="header">
                                    <h:outputText value="Quitar" />
                                </f:facet>
                                <a4j:commandButton image="../images/edit_remove.png" reRender="tableHelados"
                                                   actionListener="#{managerHeladero.removeHelado}" />
                            </rich:column>
                        </rich:dataTable>
                    </td>
                </tr>
            </table>
        </h:form>
    </rich:modalPanel>
</f:subview>