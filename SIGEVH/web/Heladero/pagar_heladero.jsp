<%-- 
    Document   : pagar_heladero
    Created on : 01/07/2011, 04:30:04 AM
    Author     : Cesardl
--%>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@taglib prefix="rich" uri="http://richfaces.org/rich"%>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j"%>

<f:subview id="pagar_heladero">
    <rich:modalPanel id="mp_pagar_heladero" width="500"
                     autosized="true">
        <f:facet name="header">
            <h:outputText value="Pago de los heladeros" />
        </f:facet>
        <f:facet name="controls">
            <h:graphicImage value="../images/close.png" style="cursor: pointer;"
                            onclick="#{rich:component('mp_pagar_heladero')}.hide()" />
        </f:facet>
        <a4j:form id="formPago">
            <table style="width: 100%;">
                <tr style="text-align: right;">
                    <td colspan="2">
                        <a4j:commandButton value="Guardar" 
                                           actionListener="#{managerPago.realizarPago}"
                                           oncomplete="#{managerPago.oncomplete}"
                                           reRender="formHeladeros"/>
                    </td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="2">
                        <rich:separator width="100%" height="3px" />
                    </td>
                </tr>
                <tr>
                    <td class="td-label">Consecionario</td>
                    <td><h:outputText value="#{managerPago.nombre_consecionario}" /></td>
                </tr>
                <tr>
                    <td class="td-label">Heladero</td>
                    <td><h:outputText value="#{managerPago.nombres_heladero}"/></td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="2">
                        <rich:separator width="100%" height="3px" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <rich:datascroller id="scrollerHelados" align="right" for="tableHelados" 
                                           maxPages="10" style="width : 90%;"/>
                        <rich:spacer height="3px"/>
                        <rich:dataTable id="tableHelados" width="90%" rows="10"
                                        onRowMouseOver="this.style.backgroundColor='#F1F1F1'"
                                        onRowMouseOut="this.style.backgroundColor='#{a4jSkin.tableBackgroundColor}'"
                                        var="dh" value="#{managerPago.listaDetalleHelados}">

                            <rich:column>
                                <f:facet name="header">
                                    <h:outputText value="Nro" />
                                </f:facet>
                                <h:outputText value="#{dh.idDetalleHelado}"/>
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
                                    <h:outputText value="Devueltos" />
                                </f:facet>
                                <h:inputText value="#{dh.strCantDevuelta}" style="width: 20px;" />
                            </rich:column>
                        </rich:dataTable>
                    </td>
                </tr>
            </table>
        </a4j:form>
    </rich:modalPanel>
</f:subview>