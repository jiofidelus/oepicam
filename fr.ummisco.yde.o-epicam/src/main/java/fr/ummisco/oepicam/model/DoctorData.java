package fr.ummisco.oepicam.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.swrlapi.parser.SWRLParseException;
import org.swrlapi.sqwrl.SQWRLQueryEngine;
import org.swrlapi.sqwrl.SQWRLResult;
import org.swrlapi.sqwrl.exceptions.SQWRLException;


public class DoctorData {

	Helper helper = new Helper();
	//The doctor filtering
	public List<String> loadPatientData(SQWRLQueryEngine queryEngine, 
			String login, String passwd) {
		List<String> listData = new ArrayList<String>();
		String data="";
		SQWRLResult doctorData;
		try{
		//Get informations for doctors
		queryEngine.createSQWRLQuery("doctorData", "Personnel(?pers) ^ personnel_login(?pers,"+"\""+login+ "\") ^ "
				+ "personnel_passwd(?p, )"+"\""+passwd+"\""
				+ "Patient(?p) ^ RendezVous(?rdv) ^ hasRDV(?rdv, ?p) ^ patient_nom(?p, ?nom) ^ "
				+ "patient_age(?p, ?age) ^ patient_sexe(?p, ?sexe) ^ patient_telephoneUn(?p, ?telephone) ^ "
				+ "rendezVous_dateRendezVous(?rdv, ?datardv) ^ rendezVous_honore(?rdv, ?honore) "
				+ "-> sqwrl:select(?nom, ?age, ?sexe, ?telephone, ?datardv, ?honore)");
		doctorData = queryEngine.runSQWRLQuery("doctorData");

		while (doctorData.next()) {
			listData.add("Nom : "+doctorData.getLiteral("nom").getString());
			listData.add("age : "+doctorData.getLiteral("age").getString());
			listData.add("sexe : "+doctorData.getLiteral("sexe").getString());
			listData.add("telephone : "+doctorData.getLiteral("telephone").getString());
			listData.add("datardv : "+doctorData.getLiteral("datardv").getString());
			listData.add("honore : "+doctorData.getLiteral("honore").getString());
			/////
		}
		}catch(SQWRLException e){e.printStackTrace();}
		catch(SWRLParseException e){e.printStackTrace();}
		return listData;
	}
	
	//List all rdv of patients
	public String listRDVDuJour(SQWRLQueryEngine queryEngine, 
			String login, String passwd, String level) {
		List<String> listData = new ArrayList<String>();
		SQWRLResult doctorData;
		String data = "";
		try{
		//Get informations for doctors
		
		String request = "Personnel(?pers)^personnel_login(?pers, \""+login+"\")^personnel_passwd(?pers, \""+passwd+"\")^"
				+ "Patient(?p)^RendezVous(?rdv)^hasRDV(?rdv, ?p)^patient_nom(?p, ?nom)^patient_age(?p, ?age)^"
				+ "patient_sexe(?p, ?sexe)^patient_telephoneUn(?p, ?telephone)^rendezVous_dateRendezVous(?rdv, ?datardv)^"
				+ "rendezVous_honore(?rdv, ?honore) -> sqwrl:select(?nom, ?age, ?sexe, ?telephone, ?datardv, ?honore)";
		
		queryEngine.createSQWRLQuery("doctorData", request);
		doctorData = queryEngine.runSQWRLQuery("doctorData");

//		Date now = new Date();
		while (doctorData.next()) {
//			//Compares the dates and retain all rendez-vous of the day
			String daterdv=(doctorData.getLiteral("datardv").getString().trim());
			if(helper.today(daterdv)){
				data+=(doctorData.getLiteral("nom").getString()+",");
				data+=(doctorData.getLiteral("age").getString()+",");
				data+=(doctorData.getLiteral("sexe").getString()+",");
				data+=(doctorData.getLiteral("telephone").getString()+",");
				data+=(doctorData.getLiteral("datardv").getString()+",");
				data+=(doctorData.getLiteral("honore").getString()+";");
			}
//			/////
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
	//List all rdv of patients
	public String listRDVManque(SQWRLQueryEngine queryEngine, 
			String login, String passwd, String level) {
		List<String> listData = new ArrayList<String>();
		SQWRLResult doctorData;
		String data = "";
		try{
		//Get informations for doctors
		
		String request = "Personnel(?pers)^personnel_login(?pers, \""+login+"\")^personnel_passwd(?pers, \""+passwd+"\")^"
				+ "Patient(?p)^RendezVous(?rdv)^hasRDV(?rdv, ?p)^patient_nom(?p, ?nom)^patient_age(?p, ?age)^"
				+ "patient_sexe(?p, ?sexe)^patient_telephoneUn(?p, ?telephone)^rendezVous_dateRendezVous(?rdv, ?datardv)^"
				+ "rendezVous_honore(?rdv, ?honore)^rendezVous_honore(?rdv, \"Non\") -> sqwrl:select(?nom, ?age, ?sexe, "
				+ "?telephone, ?datardv, ?honore)";
		
		queryEngine.createSQWRLQuery("doctorData", request);
		doctorData = queryEngine.runSQWRLQuery("doctorData");

		Date now = new Date();
		while (doctorData.next()) {
			//Compares the dates and retain all rendez-vous of the day
			String daterdv=(doctorData.getLiteral("datardv").getString());
			if(helper.before(daterdv)){
				data+=(doctorData.getLiteral("nom").getString()+",");
				data+=(doctorData.getLiteral("age").getString()+",");
				data+=(doctorData.getLiteral("sexe").getString()+",");
				data+=(doctorData.getLiteral("telephone").getString()+",");
				data+=(doctorData.getLiteral("datardv").getString()+",");
				data+=(doctorData.getLiteral("honore").getString()+";");
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
