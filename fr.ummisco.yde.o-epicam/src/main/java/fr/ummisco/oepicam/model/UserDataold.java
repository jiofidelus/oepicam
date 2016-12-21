package fr.ummisco.oepicam.model;



import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.swrlapi.parser.SWRLParseException;
import org.swrlapi.sqwrl.SQWRLQueryEngine;
import org.swrlapi.sqwrl.SQWRLResult;
import org.swrlapi.sqwrl.exceptions.SQWRLException;

//@Component
public class UserDataold {

//	//Find informations by users
	public List<String> findUserData(SQWRLQueryEngine queryEngine)
	{
		
	
		List<String> listData = new ArrayList<String>();
		String data = "'{";
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
			data += "\"KeyFacts\":\""+userData.getLiteral("KeyFacts").getString()+"\",";
			data += "\"SymptomsDiagnosis\":\""+userData.getLiteral("SymptomsDiagnosis").getString()+"\",";
			data += "\"Treatment\":\""+userData.getLiteral("Treatment").getString()+"\",";
			data += "\"WhoAtRisk\":\""+userData.getLiteral("WhoAtRisk").getString()+"\"}'";
		}
		} catch (SQWRLException e) {
			e.printStackTrace();
		}
		return listData;
	}
	
}
