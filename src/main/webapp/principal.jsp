<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%@taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<%@taglib prefix="rich" uri="http://richfaces.org/rich" %>
<%@taglib prefix="a4j" uri="http://richfaces.org/a4j" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<f:view>
    <html>
    <head>
        <title>Heladeros Lamborgini</title>
        <link rel="shortcut icon" href="images/favicon.ico">
        <link rel="icon" href="images/favicon.ico" type="image/x-icon">
        <link type="text/css" href="style/default.css" rel="stylesheet" media="screen">
    </head>
    <body>
    <jsp:include page="menu.jsp"/>
    <rich:panel style="text-align: center;">
        <img src="images/lamborgini.jpg" alt="lamborgini">
    </rich:panel>
    </body>
    </html>
</f:view>