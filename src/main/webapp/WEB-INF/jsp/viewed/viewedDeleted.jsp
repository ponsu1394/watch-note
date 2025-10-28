<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String title = (String) request.getAttribute("title");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WatchNote 削除完了</title>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/inc/header.jsp" />
	
    <%
  		request.setAttribute("pageName", "viewed");
	%>
	<jsp:include page="/WEB-INF/jsp/inc/tab.jsp" />
		
    <h2>「<%= title %>」を</h2>
    <h2>削除しました。</h2>
    
    <div class="btn-group">
    <form action="${pageContext.request.contextPath}/ViewedListServlet" method="get">
        <input type="submit" value="観た作品一覧へ" class="nav_btn">
    </form>
    </div>
    <jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>