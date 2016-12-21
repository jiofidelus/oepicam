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

<button class="w3-panel w3-text-shadow-black w3-center" style="margin: 10px;" onclick="exploratorySearch();">Recherchez d'avantage</button>
<!-- Data section -->
	<section class="w3-responsive w3-container" id="dataSection">
 		<h2>Quelques statistiques sur les données </h2>
	    <%
// 	    String rdvManque = (String) session.getAttribute("rdvManque");
// 	    String rdvHonore = (String) session.getAttribute("rdvHonore");
	    String nbRDV = (String) session.getAttribute("nbRDV");
	    String nbRDVManque = (String) session.getAttribute("nbRDVManque");
	    String nbRDVHonore = (String) session.getAttribute("nbRDVHonore");
	    String tauxRespectRDV = (String) session.getAttribute("tauxRespectRDV"); 
		%>
  			<div class="w3-panel w3-red">
  				<h3>Danger!</h3>
  				<p>Nombre de rendez-vous manqué : <%=nbRDVManque %></p>
  			</div>
  			
  			<div class="w3-panel w3-yellow">
  				<h3>Warning!</h3>
  				<p>Taux de respect des rendez-vous trop bas : <%=tauxRespectRDV %>%</p>
  			</div>

  			<div class="w3-panel w3-green">
  				<h3>Success!</h3>
  				<p>Nombre de rendez-vous honorés : <%=nbRDVHonore %></p>
  			</div>
			<div class="w3-panel w3-blue">
				<h3>Info!</h3>
				<p>Le nombre de rendez-vous donné aux patient est de : <%=nbRDV %>. Soit 3 
				rendez-vous par patients pour le trimestre.				
				</p>
			</div>
		</div>
  		
  		
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
		<footer class="w3-container w3-light-blue ">
			<p>&copy; 2016 UMMISCO. All Rights Reserved. </p>
		</footer>
		
	<script type="text/javascript">
		var token = 0;
		function exploratorySearch(){
			<%
		 	    String rdvManque = (String) session.getAttribute("rdvManque");
		 	    String rdvHonore = (String) session.getAttribute("rdvHonore");
	 	    %>
		 	var rdvManque = '<%= session.getAttribute("rdvManque") %>';
		 	var rdvHonore = '<%= session.getAttribute("rdvHonore") %>';
			var partRDVManque=rdvManque.split(";");
			var partRDVHonore=rdvHonore.split(";");
			var i = 0;
			var tobeshow="<h2>Rendez-vous manqués par dates</h2>";
			tobeshow+= "<table class='w3-table w3-striped w3-bordered w3-hoverable w3-small'>";
			var len ;
			if(token==0){
				tobeshow+= "<tr><th>Date RDV</th><th>Nombre de rendez-vous manqués</th></tr>";
				len = partRDVManque.length;
				i=0;
				token=1;
				var token1=0;

				if(token1<len){
					i=token1;
					token1=token1+5;
			for (; i < len; ) {
				var dataPart=partRDVManque[i].split(",");
				tobeshow +="<tr>";
				tobeshow +="<td>"+ dataPart[1] + "</td>";
				tobeshow +="<td>"+ dataPart[0] + "</td>";
				tobeshow +="</tr>"
			    i++;
			}
				}
			}
			else{
				tobeshow+= "<tr><th>Date RDV</th><th>Nombre de rendez-vous honorés</th></tr>";
				len = partRDVHonore.length;
				i=0;
				token=0;
				var token2=0;

				if(token2<len){
					i=token2;
					token2=token2+5;
			for (; i < len; ) {
				var dataPart=partRDVHonore[i].split(",");
				tobeshow +="<tr>";
				tobeshow +="<td>"+ dataPart[1] + "</td>";
				tobeshow +="<td>"+ dataPart[0] + "</td>";
				tobeshow +="</tr>"
			    i++;
			}}
			}
			tobeshow += "</table>";
			
			document.getElementById("dataSection").innerHTML = tobeshow;
		}
	</script>
	
	
	</body>

	
</html>

