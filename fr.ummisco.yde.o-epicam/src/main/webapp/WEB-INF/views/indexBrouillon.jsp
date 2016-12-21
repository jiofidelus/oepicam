<!DOCTYPE html>
<html ng-app="o-epicam">
<head>
	<title>O-EPICAM</title>
	<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<!-- 	<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script> -->
<!-- 	<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css"> -->
<!-- 	<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css"> -->

<!-- 	<script type="text/javascript" src="../../oepicam/resources/angular.js"></script> -->
<!-- 	<link rel="stylesheet" href="../../oepicam/resources/w3.css"> -->
	
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
				<input class="w3-input" id="searchInput" type="search" placeholder="Keywords to filter your results">
			</section>
			<br>
			
			
<!-- ***********************************************  -->
<!-- 		Inference results						  -->
<!-- ************************************************ -->
			
			<section class="w3-container" id="data">
				<%String user = (String)request.getAttribute("user"); %>
				My JSON String is as Response : <p id="userData"> <%=user%></p><br>
			</section>

		<section class="w3-container" ng-controller="Controller">
			<ul class="w3-ul w3-hoverable w3-small">
			  <li ng-repeat="x in data">
<!-- 			    <a href='{{x.url}}'>{{ x.KeyFacts}}</a><br> -->
<!-- 			    <a href='{{x.url}}'>{{ x.KeyFacts}}</a><br> -->
<!-- 			    <a href='#'>{{ x.SymptomsDiagnosis}}</a><br> -->
			<p>    {{ x.KeyFacts}}</a><br></p>			    
			<p>    {{ x.SymptomsDiagnosis}}</a><br> </p>			    
			<p>    {{ x.Treatment}}</a><br>	</p>			    
			<p>    {{ x.WhoAtRisk}}</a><br>	</p>			    
			  </li>
			</ul>
		</section>

<!-- 		<section class="w3-container" id="data"> -->
<!-- 			<h1>where are my data ?</h1> -->
<%-- 			<%out.println("Let's shows some data"); %> --%>
<%-- 			<%out.println(request.getAttribute("user").toString()); %>		 --%>
<!-- 		</section> -->
		
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
					<form class="w3-panel">
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
		
		<footer class="w3-container w3-display-bottommiddle w3-light-blue">
			<p>&copy; 2016 UMMISCO. All Rights Reserved. </p>
		</footer>
		
		
	<script type="text/javascript">
	//Angular JS code to get data from server
// 		var app = angular.module('o-epicam', []);
// 		var myJSONtext;
// 		app.controller('Controller', function($scope, $http) {
// 			$scope.data = myJSONtext = document.getElementById("userData").innerHTML;
// 			//initialize the document to null, to prepare the display of data
// 			document.getElementById("userData").innerHTML = "";
// 		});
// 	//Now, let's display data in a list
// 		searchResult(data);
	
// 		function searchResult(data){
// 			var out = "<ul class='w3-ul w3-hoverable w3-small'>";
// 			var i;
// 			for(i=0; i<data.lenght; i++){
// 				out+="<li><a href="+data[i].url+">"+data[i].display+"</a></li><br>"+
// 				"<li><a href="+data[i].url+">"+data[i].url+"</a></li><br>"+
// 				"<li>"+data.description+"</li>";
// 			}
// 			document.getElementById("searchResults").innerHTML = out;
// 			document.getElementById("data").innerHTML=data.id+"<br>"+data.content;
// 		}


// 			myJSONtext = (document.getElementById("userData").innerHTML).replace(/'/g, ' ');
	</script>	
	
	</body>

	
</html>

<!-- var myJSONString = JSON.stringify(myJSON); -->
<!-- var myEscapedJSONString = myJSONString.replace(/\\n/g, "\\n") -->
<!--                                       .replace(/\\'/g, "\\'") -->
<!--                                       .replace(/\\"/g, '\\"') -->
<!--                                       .replace(/\\&/g, "\\&") -->
<!--                                       .replace(/\\r/g, "\\r") -->
<!--                                       .replace(/\\t/g, "\\t") -->
<!--                                       .replace(/\\b/g, "\\b") -->
<!--                                       .replace(/\\f/g, "\\f"); -->

