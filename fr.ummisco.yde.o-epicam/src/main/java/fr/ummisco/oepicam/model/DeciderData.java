package fr.ummisco.oepicam.model;

import org.swrlapi.parser.SWRLParseException;
import org.swrlapi.sqwrl.SQWRLQueryEngine;
import org.swrlapi.sqwrl.SQWRLResult;
import org.swrlapi.sqwrl.exceptions.SQWRLException;


public class DeciderData {
	
	Helper helper=new Helper();
	
	public String findDeciderData(SQWRLQueryEngine queryEngine, 
			String login, String passwd) {
		String data = "'{";
		try{
//		Compte le nombre de patients
		queryEngine.createSQWRLQuery("stat1","Patient(?p) -> sqwrl:count(?p)");
		//Stratifie les patients par tranche d'âge
		//Moins de 15 ans
		queryEngine.createSQWRLQuery("stat2","Patient(?p) ^ patient_age(?p, ?age) ^ "
				+ "swrlb:lessThan(?age, \"15\") -> sqwrl:count(?p)");
		//Entre 15 et 40 ans
		queryEngine.createSQWRLQuery("stat3","Patient(?p) ^ patient_age(?p, ?age) ^ "
				+ "swrlb:lessThan(?age, \"40\")^swrlb:greaterThan(?age, \"15\") -> sqwrl:count(?p)");
		//Plus de 40 ans
		queryEngine.createSQWRLQuery("stat4","Patient(?p) ^ patient_age(?p, ?age) ^ "
				+ "swrlb:greaterThan(?age, \"40\") -> sqwrl:count(?p)");
		//Statistiques des patients / sexe
		queryEngine.createSQWRLQuery("stat5", "Patient(?p) ^ patient_sexe(?p, ?sexe) ^ "
				+ "swrlb:equal(?sexe, \"Female\") -> sqwrl:count(?p)");
		//Exécution des requêtes des statistiques
		SQWRLResult stat1 = queryEngine.runSQWRLQuery("stat1");
		SQWRLResult stat2 = queryEngine.runSQWRLQuery("stat2");
		SQWRLResult stat3 = queryEngine.runSQWRLQuery("stat3");
		SQWRLResult stat4 = queryEngine.runSQWRLQuery("stat4");
		SQWRLResult stat5 = queryEngine.runSQWRLQuery("stat5");
		
		//get results

		while (stat1.next()) {
			data += "\"NB patients\":\""+stat1.getLiteral("count(?p)").getInt()+"\",";
		}
		while (stat2.next()) {
			data += "\"NB patients < 15\":\""+stat2.getLiteral("count(?p)").getInt()+"\",";
		}
		while (stat3.next()) {
			data += "\"NB patients 15 - 40\":\""+stat3.getLiteral("count(?p)").getInt()+"\",";
		}
		while (stat4.next()) {
			data += "\"NB patients > 40\":\""+stat4.getLiteral("count(?p)").getInt()+"\",";
		}
		while (stat5.next()) {
			data += "\"NB patients femmes\":\""+stat5.getLiteral("count(?p)").getInt()+"\"";
		}
		}catch(SQWRLException e){e.printStackTrace();}
		catch(SWRLParseException e){e.printStackTrace();}
		return data;
	}
	
	//Fréquentation du CDT
	public String findRDVPatient (SQWRLQueryEngine queryEngine, 
			String login, String passwd){

		String data = "";
		try{
//		Statistiques sur la venu au RDV des patients. Important dans le cadre des supervisions
		queryEngine.createSQWRLQuery("stat6","RendezVous(?rdv) ^ "
				+ "rendezVous_dateRendezVous(?rdv, ?dateRDV) ^ rendezVous_honore(?rdv, ?honore) "
				+ "-> sqwrl:select(?dateRDV, ?honore) ^ sqwrl:orderBy(?honore)");
		SQWRLResult stat6 = queryEngine.runSQWRLQuery("stat6");
		while (stat6.next()) {
			data += stat6.getLiteral("dateRDV").getInt()+",";
			data += stat6.getLiteral("honore").getInt()+";";
		}
		}catch(SWRLParseException e){e.printStackTrace();}
		catch(SQWRLException e){e.printStackTrace();}
		return data;
	}
	
	//Stats on patient rdv

	//Fréquentation du CDT
	public String statPatientRdv (SQWRLQueryEngine queryEngine, 
			String login, String passwd, String level){
		String data = "";
		int nbRDVManque =0;
		int nbRDVHonore =0;
		int nbRDV =0;
		int tauxRespectRDV=0;
		String dateRDVManque="";
		String dateRDVHonore="";
		try{
			queryEngine.createSQWRLQuery("stat6","RendezVous(?rdv) ^ rendezVous_honore(?rdv, \"Non\") "
					+ "^ rendezVous_dateRendezVous(?rdv, ?daterdv) -> sqwrl:count(?rdv) ^ sqwrl:select(?daterdv)"
					+ "^ sqwrl:orderByDescending(?rdv)");
			queryEngine.createSQWRLQuery("stat7","RendezVous(?rdv) ^ rendezVous_honore(?rdv, \"Oui\") "
					+ "^ rendezVous_dateRendezVous(?rdv, ?daterdv) -> sqwrl:count(?rdv) ^ sqwrl:select(?daterdv)"
					+ "^ sqwrl:orderByDescending(?rdv)");
			SQWRLResult stat6 = queryEngine.runSQWRLQuery("stat6");
			SQWRLResult stat7 = queryEngine.runSQWRLQuery("stat7");

			while (stat6.next()) {
				nbRDVManque+= stat6.getLiteral(0).getInt();
				data+= stat6.getLiteral(0).getInt()+"," ;
				data+= stat6.getLiteral(1).getString()+";";				
			}
			data+="-";
			while (stat7.next()) {
				nbRDVHonore+= stat7.getLiteral(0).getInt();
				data+= stat7.getLiteral(0).getInt()+"," ;
				data+= stat7.getLiteral(1).getString()+";";				
			}
			//A smal statistics on these datadata
			nbRDV = nbRDVHonore + nbRDVManque;
			tauxRespectRDV = (nbRDVHonore*100/nbRDV);
			data+="-";
			data+=nbRDV;
			data+="-";
			data+=nbRDVManque;
			data+="-";
			data+=nbRDVHonore;
			data+="-";
			data+=tauxRespectRDV;
			
		}catch(SWRLParseException e){e.printStackTrace();}
		catch(SQWRLException e){e.printStackTrace();}
		return data;
	}
}
