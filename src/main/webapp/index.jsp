<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- リンク -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<!-- FontAwesomeリンク -->
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<title>WatchNote TOPページ</title>
</head>
<body>
	<header>
		<nav>
			<ul>
				<li class="brand">WatchNote</li>
				<li>
					<a href="index.jsp">
						<i class="fa-solid fa-video icon-large"></i>
					</a>
				</li>
			</ul>
		</nav>
	</header>

	<main>
	<div class="work">
		<ul>
			<li><a class="nav_btn" href="ViewedListServlet">観た作品一覧</a></li>
			<li><a class="nav_btn" href="WishListServlet">観たい作品一覧</a></li>	
		</ul>
		
		
	</div>
	</main>
	<jsp:include page="/WEB-INF/jsp/inc/footer.jsp" />
</body>
</html>