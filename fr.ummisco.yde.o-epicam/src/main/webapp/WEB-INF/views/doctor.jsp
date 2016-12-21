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
		String listrdv = (String)session.getAttribute("listrdv");
		String listrdvmq = (String)session.getAttribute("listrdvmq");
		%>
  
  <button class="w3-panel w3-text-shadow-black w3-center" style="margin: 10px;" onclick="exploratorySearch();">Recherchez d'avantage</button>
  <section class="w3-responsive" id="dataSection">
  <h2>Liste des rendez-vous pris avec les patients ce jour </h2>
  <table class="w3-table w3-striped w3-bordered w3-hoverable w3-small">
    <tr>
      <th>N°</th>
      <th>Name</th>
      <th>Age</th>
      <th>Sexe</th>
      <th>Téléphone</th>
      <th>Date RDV</th>
      <th>Honoré</th>
      <th>Editer</th>
      <th>Consulter</th>
    </tr>
    <% 
    	
    	if(listrdv!=null && listrdv.length()>0){
		String[] parts = listrdv.split(";");
			for (int i = 0; i < parts.length; i++) {
				String dataPart=parts[i];
				%>
			<tr>
				<%	String[] part1 = dataPart.split(",");	%>
				<td><%=i+1 %></td>
				<td><%=part1[0] %></td>
				<td><%=part1[1] %></td>
				<td><%=part1[2] %></td>
				<td><%=part1[3] %></td>
				<td><%=part1[4] %></td>
				<td><%=part1[5] %></td>
				<td><a href="#">Editer</a></td>
				<td><a href="#">Consulter</a></td>
				<td></td>
			</tr>
			
		<%
			}
		}
		%>
    </table>
    
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
	
	<script type="text/javascript">
		var token = 0;
		function exploratorySearch(){
			
			var listrdvmq = '<%= session.getAttribute("listrdvmq") %>';
			var part=listrdvmq.split(";");
			var i = 0;
			
			var tobeshow="<h2>Liste des patients ayant raté leurs rendez-vous </h2>";
			tobeshow+= "<table class='w3-table w3-striped w3-bordered w3-hoverable w3-small'><tr>";
			tobeshow+= "<th>Name</th><th>Age</th><th>Sexe</th><th>Téléphone</th><th>Date RDV</th><th>Honoré</th>";
			tobeshow+="<th>Editer</th><th>Consulter</th></tr>";
			console.log("Les données contenues dans listrdv : "+listrdvmq);
			console.log("Les données splitées : "+part);
			var len = part.length;
			if(token<len){
				i=token;
				token=token+5;
			for (; i < token; ) {
				var dataPart=part[i].split(",");
				tobeshow +="<tr>";
				tobeshow +="<td>"+ dataPart[0] + "</td>";
				tobeshow +="<td>"+ dataPart[1] + "</td>";
				tobeshow +="<td>"+ dataPart[2] + "</td>";
				tobeshow +="<td>"+ dataPart[3] + "</td>";
				tobeshow +="<td>"+ dataPart[4] + "</td>";
				tobeshow +="<td>"+ dataPart[5] + "</td>";
				tobeshow+="<td><a href='#'>Editer</a></td>";
				tobeshow+="<td><a href='#'>Consulter</a></td>";
				tobeshow +="</tr>"
			    i++;
			}
			}
			else{
				token=0;
			}
			tobeshow += "</table>";
			
			document.getElementById("dataSection").innerHTML = tobeshow;
		}
	</script>
	
</html>

