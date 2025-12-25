<%--
  Created by IntelliJ IDEA.
  User: cesar
  Date: 12/25/2025
  Time: 12:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<%@taglib prefix="rich" uri="http://richfaces.org/rich" %>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j" %>

<f:subview id="modal_contract">
    <rich:modalPanel id="mp_contract" width="400" autosized="true">
        <f:facet name="header">
            <h:outputText value="Contracto"/>
        </f:facet>
        <f:facet name="controls">
            <h:graphicImage value="../images/close.png" style="cursor: pointer;"
                            onclick="Richfaces.hideModalPanel('mp_contract');"/>
        </f:facet>
        <a4j:form id="formContract">
            <table style="width: 100%;">
                <tr>
                    <td colspan="2">
                        <h:outputText value="El contrato est&aacute; expirado, debe renovar"
                                      rendered="#{!managerHeladero.contract.active}" escape="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="td-label">Tipo</td>
                    <td><h:outputText value="#{managerHeladero.contract.contract.contractType}"/></td>
                </tr>
                <tr>
                    <td class="td-label">Contenido</td>
                </tr>
                <tr>
                    <td colspan="2"><h:outputText value="#{managerHeladero.contract.contract.contenido}"/></td>
                </tr>
            </table>
        </a4j:form>
    </rich:modalPanel>
</f:subview>
