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
    <rich:modalPanel  id="mp" minHeight="200" minWidth="450" 
                      height="200" width="500">
        <f:facet name="header">
            <h:outputText value="Modal Panel Title" />
        </f:facet>
        <f:facet name="controls">
            <h:graphicImage value="../images/close.png" style="cursor: pointer;"
                            onclick="#{rich:component('mp')}.hide()" />
        </f:facet>
        <p>Any JSF content might be inside the panel. In case of using 
            Facelets or JSF 1.2, it might be any mixed content.</p> 

        <p>The RichFaces modal panel is good with &lt;a4j:include&gt; to create
            a wizard like behavior.</p>
    </rich:modalPanel>
</f:subview>