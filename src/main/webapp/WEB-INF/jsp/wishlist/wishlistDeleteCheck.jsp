<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 削除確認</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
    
	<%
  		request.setAttribute("pageName", "wish");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
	<div class="work">
    <p>「<%= request.getAttribute("title") %>」<br>を削除してもよろしいですか？</p>
	</div>
	<div class="btn-group">
	
	<form action="${pageContext.request.contextPath}/WishlistEditServlet" method="get">
        <input type="hidden" name="id" value="<%= request.getAttribute("id") %>">
        <input type="submit" value="戻る" class="btn">
    </form>
	
    <form action="${pageContext.request.contextPath}/WishlistDeleteServlet" method="post">
        <input type="hidden" name="id" value="<%= request.getAttribute("id") %>">
        <input type="hidden" name="title" value="<%= request.getAttribute("title") %>">      
        <input type="submit" value="削除" class="btn" >
    </form>

   
	</div>
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>