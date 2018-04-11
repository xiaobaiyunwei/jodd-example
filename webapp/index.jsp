
<%@ taglib prefix="j" uri="/jodd" %>
<html>
<body>
<h1>Messages==</h1>
===getContextPath():=====<%=request.getContextPath()%><br>
===getLocalName():=====<%=request.getLocalName()%><br>
===getRequestURI():=====<%=request.getRequestURI()%><br>
===getRequestURL():=====<%=request.getRequestURL()%><br>
===getServletPath():=====<%=request.getServletPath()%><br>

<ul>
<j:iter items="${messages}" var="msg">
    <li>${msg.messageId} ${msg.text}
        <ul>
            <j:iter items="${msg.responses}" var="resp">
                <li>${resp.responseId} ${resp.text}</li>
            </j:iter>
        </ul>
    </li>
   
<j:switch value="${msg.messageId}">
		<j:case value="1">I am in case 1.</j:case>
		<j:case value="2">I am in case 2.</j:case>
		<j:case value="3">I am in case 3.</j:case>
</j:switch>
</j:iter>






</ul>


</body>
</html>
