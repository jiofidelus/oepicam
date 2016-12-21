package fr.ummisco.oepicam.model;



import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;
import org.swrlapi.parser.SWRLParseException;
import org.swrlapi.sqwrl.SQWRLQueryEngine;
import org.swrlapi.sqwrl.SQWRLResult;
import org.swrlapi.sqwrl.exceptions.SQWRLException;

//@Component
public class PatientData {
	
	Helper helper = new Helper();

//	//Find informations by users
	public List<String> findUserData(SQWRLQueryEngine queryEngine)
	{
		List<String> listData = new ArrayList<String>();
		String data = "";
		SQWRLResult userData;
		//Create and execute query
		try {
		queryEngine.createSQWRLQuery("userData", "Disease(?d) "
				+ "^ tb_KeyFacts(?d, ?KeyFacts) ^ tb_SymptomsDiagnosis(?d, ?SymptomsDiagnosis) ^ "
				+ "tb_Treatment(?d, ?Treatment) ^ tb_WhoAtRisk(?d, ?WhoAtRisk) "
				+ "-> sqwrl:select(?KeyFacts, ?SymptomsDiagnosis, ?Treatment, ?WhoAtRisk)");
		} 
		catch (SWRLParseException e) {
			e.printStackTrace();
			}
		catch (SQWRLException e) {
			e.printStackTrace();
			}
		//loop to get data
		try {
			userData = queryEngine.runSQWRLQuery("userData");
		while (userData.next()) {
			listData.add(userData.getLiteral("KeyFacts").getString());
			listData.add(userData.getLiteral("SymptomsDiagnosis").getString());
			listData.add(userData.getLiteral("Treatment").getString());
			listData.add(userData.getLiteral("WhoAtRisk").getString());
		}
		} catch (SQWRLException e) {
			e.printStackTrace();
		}
		
		return listData;
	}
	
	
	//Find patient rendez-vous

	//List all rdv of patients
	public String listRDV(SQWRLQueryEngine queryEngine, 
			String login, String passwd, String level) {
		List<String> listData = new ArrayList<String>();
		SQWRLResult patientData;
		String data = "";
		try{
		//Get informations for doctors
		
		String request = "Personnel(?pers)^personnel_login(?pers, \""+login+"\")^personnel_passwd(?pers, \""+passwd+"\")^"
				+ "Patient(?p)^RendezVous(?rdv)^hasRDV(?rdv, ?p)^patient_nom(?p, ?nom)^patient_age(?p, ?age)^"
				+ "patient_sexe(?p, ?sexe)^patient_telephoneUn(?p, ?telephone)^rendezVous_dateRendezVous(?rdv, ?datardv)^"
				+ "rendezVous_honore(?rdv, ?honore) -> sqwrl:select(?nom, ?age, ?sexe, ?telephone, ?datardv, ?honore)";
		
		queryEngine.createSQWRLQuery("patientData", request);
		patientData = queryEngine.runSQWRLQuery("patientData");


		while (patientData.next()) {
			data+=(patientData.getLiteral("nom").getString()+",");
			data+=(patientData.getLiteral("age").getString()+",");
			data+=(patientData.getLiteral("sexe").getString()+",");
			data+=(patientData.getLiteral("telephone").getString()+",");
			data+=(patientData.getLiteral("datardv").getString()+",");
			data+=(patientData.getLiteral("honore").getString()+";");
			/////
		}
		
		System.out.println("******************************List of patient data*********************************************");
		String[] parts = data.split(";");
		for (int i = 0; i < parts.length; i++) {
			System.out.println(parts[i]);
		}
		
		}catch(SQWRLException e){e.printStackTrace();}
		catch(SWRLParseException e){e.printStackTrace();}
		return data;
	}
	
	//Find next patient rdv
	//List all rdv of patients
		public String listNextRDV(SQWRLQueryEngine queryEngine, 
				String login, String passwd, String level) {
			List<String> listData = new ArrayList<String>();
			SQWRLResult patientData;
			String data = "";
			try{
			//Get informations for patient			
			String request = "Personnel(?pers)^personnel_login(?pers, \""+login+"\")^personnel_passwd(?pers, \""+passwd+"\")^"
					+ "Patient(?p)^RendezVous(?rdv)^hasRDV(?rdv, ?p)^rendezVous_dateRendezVous(?rdv, ?datardv)-> sqwrl:select(?datardv)";
			
			queryEngine.createSQWRLQuery("patientData", request);
			patientData = queryEngine.runSQWRLQuery("patientData");

			Date now = new Date();
			while (patientData.next()) {
				//Compares the dates and retain all rendez-vous of the day
				String daterdv=(patientData.getLiteral("datardv").getString());
				if(helper.after(daterdv)){
					data+=(patientData.getLiteral("datardv").getString()+",");
				}
				/////
			}
			
			System.out.println("******************************List of patient data*********************************************");
			String[] parts = data.split(";");
			for (int i = 0; i < parts.length; i++) {
				System.out.println(parts[i]);
			}
			
			}catch(SQWRLException e){e.printStackTrace();}
			catch(SWRLParseException e){e.printStackTrace();}
			return data;
		}
}
