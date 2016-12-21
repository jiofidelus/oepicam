<!DOCTYPE html>
<%@page import="java.util.List"%>
<html >
<head>
	<title>O-EPICAM</title>
	<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">	
	 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/w3.css" />
	<style type="text/css">
		a:HOVER {
			background-color: yellow;			
		}
	</style>

</head>


	<body>
	
<!-- ***********************************************  -->
<!-- 		The header		 						  -->
<!-- ************************************************ -->
		<header class="w3-container w3-light-blue">
			<h1 class="w3-text-shadow-black w3-opacity w3-text-black w3-xxxlarge w3-center">O-EPICAM</h1>
			<h2 class="w3-center">Doctor data</h2>
		</header>
		
<!-- ***********************************************  -->
<!-- 		The profile button 						  -->
<!-- ************************************************ -->
		<section class="w3-container w3-section">
<!-- 			Openning profile form container -->
			<section class="container">
				<button class="w3-btn w3-blue w3-text-shadow" 
				onclick="document.getElementById('loginForm').style.display='block'">Change your profile</button>
			</section>
			
<!-- ***********************************************  -->
<!-- 		The search form 						  -->
<!-- ************************************************ -->
			<section class="w3-panel w3-section ">
				<input class="w3-input" id="searchInput" type="search" placeholder="Keywords to filter your results">
			</section>
			<br>
			
			
<!-- ***********************************************  -->
<!-- 		Inference results						  -->
<!-- ************************************************ -->
			
			<section class="w3-container" id="data">
				<%List<String> listData = (List<String>)request.getAttribute("user"); %>
<%-- 				<p id="userData" style="visibility: hidden;"> <%=user%></p><br> --%>
			</section>
		
		<section class="w3-container">
			<ul class="w3-ul w3-small">
				<li><% int i=1; for (String data : listData) {%>
					<%=i %>
					<p style="margin: 8px;"><%=data %></p>
					<%i++; %>
					</li>
				<%} %>
			</ul>
		</section>

		
<!-- ***********************************************  -->
<!-- 		The profile form 						  -->
<!-- ************************************************ -->
		</section>
<!-- 			Profile form -->
			<section id="loginForm" class="w3-modal">
				<section class="w3-modal-content w3-animate-left w3-card">
					<header class="w3-container w3-teal">
						<span onclick="document.getElementById('loginForm').style.display='none'"
						class="w3-closebtn">&times;</span>
						<h6>Your login and password</h6>
					</header>
					
					<form action="HomeController" method="get" class="w3-panel">
						<input class="w3-input w3-panel" type="text" placeholder="Enter your login">
						<input class="w3-input w3-panel" type="password" placeholder="Enter your password">
						<button class="w3-panel w3-text-shadow-black w3-center">Change Profile</button>
					</form>
				</section>
			</section>
			
<!-- 			Paginating results to optimize filtering -->
		
		<section class="w3-container w3-center">
			<ul class="w3-ul w3-pagination">
				<li><a href="#">&laquo</a>
				<li><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">&raquo;</a>
			</ul>
		</section>
		
		
<!-- 		Footer of the app -->
		
<!-- 		<footer class="w3-container w3-display-bottommiddle w3-light-blue"> -->
		<footer class="w3-container w3-light-blue">
			<p>&copy; 2016 UMMISCO. All Rights Reserved. </p>
		</footer>
		

	
	</body>

	
</html>

