package fr.ummisco.oepicam.model;

import java.util.ArrayList;
import java.util.List;

import org.swrlapi.parser.SWRLParseException;
import org.swrlapi.sqwrl.SQWRLQueryEngine;
import org.swrlapi.sqwrl.SQWRLResult;
import org.swrlapi.sqwrl.exceptions.SQWRLException;


public class User {

	//The doctor filtering
	public String authentication(SQWRLQueryEngine queryEngine, 
			String login, String passwd) {

		
		
		System.out.println("\n\n------------------Entrée dans la méthode d'authentification--------"+queryEngine+"------------------------------\n\n");
		String user="";
		boolean userAuthenticated=false;
		 String  niveau="0";
		SQWRLResult userAuth=null;
		try{
		//Get informations for doctors
			System.out.println("\n\n-------Début de l'exécution de la requête-------------------------------------------------\n\n");
			queryEngine.createSQWRLQuery("userAuth", 
					"personnel_login(?p, "+"\""+login+"\") ^ personnel_passwd(?p,"+"\""+passwd+"\")"
							+ "^personnel_niveau(?p, ?niveau) -> sqwrl:select(true, ?niveau)");
//			queryEngine.createSQWRLQuery("userAuth", "personnel_login(?p, "+login+") ^ personnel_passwd(?p, "+passwd+") -> sqwrl:select(true)");
		userAuth = queryEngine.runSQWRLQuery("userAuth");
		System.out.println(userAuth+" \n\n------------Fin de l'exécution de la requête--------------------------------------------\n\n");

		while (userAuth.next()) {
			userAuthenticated = userAuth.getLiteral(0).getBoolean() ;
			  niveau  = userAuth.getLiteral(1).getString();
		}
		}catch(SQWRLException e){e.printStackTrace();}
		catch(SWRLParseException e){e.printStackTrace();}

		user=userAuthenticated+"-"+niveau;
		return user;
	}
	//Un peu de stats
	
}
