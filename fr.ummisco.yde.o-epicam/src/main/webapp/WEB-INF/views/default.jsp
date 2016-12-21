<!DOCTYPE html>
<html >
<head>
	<title>O-EPICAM</title>
	<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">	
	 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/w3.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/appml.js"></script>
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
				<p id="userData" style="visibility: hidden;"> <%=user%></p><br>
			</section>

<!-- 		<section class="w3-container" ng-controller="Controller"> -->
<!-- 			<ul class="w3-ul w3-hoverable w3-small"> -->
<!-- 			  <li ng-repeat="x in data"> -->
<!-- 				<p>    {{x.KeyFacts}}<br></p>			     -->
<!-- 				<p>    {{x.SymptomsDiagnosis}}<br> </p>			     -->
<!-- 				<p>    {{x.Treatment}}<br>	</p>			     -->
<!-- 				<p>    {{x.WhoAtRisk}}<br>	</p> -->
<!-- 			  </li> -->
<!-- 			</ul> -->
<!-- 		</section> -->

<!-- 		<h1>Ouf !!!</h1> -->
<!-- 		<section class="w3-container" ng-controller="Controller"> -->
<!-- 			<ul class="w3-ul w3-hoverable w3-small"> -->
<!-- 			  <li ng-repeat="x in data"> -->
<!-- 			  Data is here -->
<!-- 			    <a href='{{x.KeyFacts}}'>{{x.KeyFacts}}</a><br>   -->
<!-- 			    <a href='{{x.SymptomsDiagnosis}}'>{{x.SymptomsDiagnosis}}</a><br>   -->
<!-- 			    <a href='{{x.WhoAtRisk}}'>{{x.WhoAtRisk}}</a><br>   -->
<!-- 			  </li> -->
<!-- 			</ul> -->
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
		
<!-- 		<footer class="w3-container w3-display-bottommiddle w3-light-blue"> -->
		<footer class="w3-container w3-light-blue">
			<p>&copy; 2016 UMMISCO. All Rights Reserved. </p>
		</footer>
		
<!-- 		Let's try with appml.js -->



<!-- <h1>EPICAM data</h1> -->
<!-- 	<div appml-data="dataObj"> -->
<!-- 		<div appml-repeat="records"> -->
<!-- 			<p>{{KeyFacts}}</p> -->
<!-- 			<p>{{SymptomsDiagnosis}}</p> -->
<!-- 			<p>{{Treatment}}</p> -->
<!-- 			<p>{{WhoAtRisk}}</p> -->
<!-- 		</div> -->
<!-- 	</div> -->


		
		<script type="text/javascript">

			var x = document.getElementById("userData");
			var myJSONtext = x.innerHTML;
			myJSONtext = myJSONtext.replace(/'/g, ' ');
			myJSONtext = myJSONtext.replace(/\\n/g, " ");
			x.innerHTML=myJSONtext;
			console.log(myJSONtext);
			
			console.log(myJSONtext.KeyFacts);
			
// 			var dataObj = JSON.parse(myJSONtext.toString());
// 			console.log(dataobj);
			
			
// // 			var dataObj = JSON.parse(myJSONtext);
// 			x.style.visibility = "visible";
// 			x.innerHTML=myJSONtext;

		
		
		</script>
		
		
		
		
		
		
	<script type="text/javascript">
	//Angular JS code to get data from server
// 		var app = angular.module('o-epicam', []);
// 		var myJSONtext;
// 		app.controller('Controller', function($scope, $http) {
// 			myJSONtext = document.getElementById("userData").innerHTML;
// 			JSON.parse($scope.data);
// 			$scope.data = (document.getElementById("userData").innerHTML).replace(/'/g, ' ');
// 		});
// 		document.getElementById("userData").innerHTML = "";
// // // 	//Now, let's display data in a list
// 		searchResult(data);
	
// 		function searchResult(data){
// 			var out = "<ul class='w3-ul w3-hoverable w3-small'>";
// 			var i;
// // 			for(i=0; i<data.lenght; i++){
// // 				out+="<li><a href="+data[i].url+">"+data[i].display+"</a></li><br>"+
// // 				"<li><a href="+data[i].url+">"+data[i].url+"</a></li><br>"+
// 				"<li>"+data.description+"</li>";
// // 			}
// // 			console.log("La valeur de out est : "+out);
// // // 			document.getElementById("searchResults").innerHTML = out;
// // 			console.log(data+", "+data.id+", "+data.content);
// // 			document.getElementById("data").innerHTML=data.id+"<br>"+data.content;
// 		}
	</script>	
	
	</body>

	
</html>

