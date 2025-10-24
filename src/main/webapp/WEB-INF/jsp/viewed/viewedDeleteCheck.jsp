<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String title = (String) request.getAttribute("title");
    int id = (Integer) request.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 削除確認</title>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
	
    <%
  		request.setAttribute("pageName", "viewed");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
		
    <h2>「<%= title %>」を本当に削除しますか？</h2>

    <form action="${pageContext.request.contextPath}/ViewedDeleteServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="submit" value="削除" class="nav_btn">
    </form>

    <form action="${pageContext.request.contextPath}/ViewedEditServlet" method="get">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="submit" value="戻る" class="nav_btn">
    </form>
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>