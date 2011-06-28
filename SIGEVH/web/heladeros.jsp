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
            <link type="text/css" href="style/default.css" rel="stylesheet" media="screen"/>
        </head>
        <body>
            <jsp:include page="menu.jsp"/>
            <rich:panel>
                <table width="100%">
                    <tr>
                        <td colspan="2">
                            <h:outputText value="Mantenimiento de heladeros"
                                          styleClass="title-label" />
                        </td>
                        <td align="right">
                            <h:panelGrid columns="2">
                                <a4j:commandButton value="Buscar" />
                                <a4j:commandButton value="Nuevo" />
                            </h:panelGrid>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <rich:separator width="100%" height="3px" />
                        </td>
                    </tr>
                    <tr>
                        <td class="td-label">Nombre</td>
                        <td><h:inputText /></td>
                    </tr>
                    <tr>
                        <td class="td-label">Apellido</td>
                        <td><h:inputText /></td>
                    </tr>
                </table>
            </rich:panel>
        </body>
    </html>
</f:view>