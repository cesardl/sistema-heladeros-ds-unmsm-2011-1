<%--
  Created by IntelliJ IDEA.
  User: Cesardl
  Date: 11/08/2019
  Time: 15:17
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<%@taglib prefix="rich" uri="http://richfaces.org/rich" %>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j" %>

<f:subview id="ice_cream">
    <rich:modalPanel id="mp_ice_cream" width="400" autosized="true">
        <f:facet name="header">
            <h:outputText value="Mantenimiento de helados"/>
        </f:facet>
        <f:facet name="controls">
            <h:graphicImage value="../images/close.png" style="cursor: pointer;"
                            onclick="Richfaces.hideModalPanel('mp_ice_cream');"/>
        </f:facet>
        <a4j:form id="formIceCream">
            <table style="width: 100%;">
                <tr>
                    <td style="text-align: right" colspan="2">
                        <a4j:commandButton value="Guardar"
                                           image="images/save.png"
                                           actionListener="#{managerIceCream.saveOrUpdate}"
                                           oncomplete="#{managerIceCream.oncomplete}"
                                           reRender="formIceCreams"/>
                    </td>
                </tr>
                <tr class="tr-separator">
                    <td colspan="2">
                        <rich:separator width="100%" height="3px"/>
                    </td>
                </tr>
                <tr>
                    <td class="td-label">Helado</td>
                    <td><h:inputText value="#{managerIceCream.editedIceCream.nombreHelado}"/></td>
                </tr>
                <tr>
                    <td class="td-label">Precio</td>
                    <td><h:inputText value="#{managerIceCream.editedIceCream.precio}"/></td>
                </tr>
                <tr>
                    <td class="td-label">Stock</td>
                    <td><h:inputText value="#{managerIceCream.editedIceCream.stockHelado.cantidad}"/></td>
                </tr>
                <tr>
                    <td class="td-label">Fecha caducidad</td>
                    <td><rich:calendar datePattern="yyyy-MM-dd" inputSize="10"
                                       value="#{managerIceCream.editedIceCream.stockHelado.fechaCaducidad}"/></td>
                </tr>
            </table>
        </a4j:form>
    </rich:modalPanel>
</f:subview>
