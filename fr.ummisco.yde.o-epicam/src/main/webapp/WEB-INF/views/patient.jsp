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
			<form action="search" method="get" class="w3-panel">
				<input class="w3-input" id="searchInput" type="search" style="margin-bottom: 10px;" 
				placeholder="Keywords to filter your results">
				<button class="w3-panel w3-text-shadow-black w3-center">Search</button>
			</form>
			</section>
			<br>
			
			
		
<!-- ***********************************************  -->
<!-- 		The profile form 						  -->
<!-- ************************************************ -->
		</section>

<!-- Data section -->

	    <%
			String data = (String)session.getAttribute("data");
		%>
	  <section class="w3-container">
		  <h2>Dates des prochains rendez-vous</h2>
		  <%     	
	    	if(data!=null && data.length()>0){
			String[] parts = data.split(",");
			for (int i = 0; i < parts.length; i++) {
				%>
		   <a href="#"><%=parts[i] %></a><br><hr>
		<%
			}
		}
		%>
	</section>
  

		
<!-- 			Profile form -->
			<section id="loginForm" class="w3-modal">
				<section class="w3-modal-content w3-animate-left w3-card">
					<header class="w3-container w3-teal">
						<span onclick="document.getElementById('loginForm').style.display='none'"
						class="w3-closebtn">&times;</span>
						<h6>Your login and password</h6>
					</header>
					
					<form action="authenticate" method="post" class="w3-panel">
						<input class="w3-input w3-panel" type="text" name="login" placeholder="Enter your login">
						<input class="w3-input w3-panel" type="password" name="passwd" placeholder="Enter your password">
						<button class="w3-panel w3-text-shadow-black w3-center">Change Profile</button>
					</form>
				</section>
			</section>
			
			
		
<!-- 		Footer of the app -->
		
<!-- 		<footer class="w3-container w3-display-bottommiddle w3-light-blue"> -->
		<footer class="w3-container w3-light-blue w3-display-bottommiddle">
			<p>&copy; 2016 UMMISCO. All Rights Reserved. </p>
		</footer>
		
	</body>

<!-- 	This script is executed when a user is making an exploratory search -->
	

</html>

