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
    <rich:modalPanel  id="mp_pagar_heladero" minHeight="200" minWidth="450" 
                      height="200" width="500">
        <f:facet name="header">
            <h:outputText value="Pago de los heladeros" />
        </f:facet>
        <f:facet name="controls">
            <h:graphicImage value="../images/close.png" style="cursor: pointer;"
                            onclick="#{rich:component('mp_pagar_heladero')}.hide()" />
        </f:facet>
        <a4j:form id="formPago">
            <table>
                <tr align="right">
                    <td colspan="3">
                        <a4j:commandButton value="Guardar" />
                    </td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="3">
                        <rich:separator width="100%" height="3px" />
                    </td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="3">
                        <rich:separator width="100%" height="3px" />
                    </td>
                </tr>
            </table>
        </a4j:form>
    </rich:modalPanel>
</f:subview>