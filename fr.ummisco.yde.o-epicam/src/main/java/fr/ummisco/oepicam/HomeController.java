package fr.ummisco.oepicam;

import java.io.File;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.drools.compiler.lang.dsl.DSLMapParser.keyword_key_return;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyCreationException;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.swrlapi.factory.SWRLAPIFactory;
import org.swrlapi.parser.SWRLParseException;
import org.swrlapi.sqwrl.SQWRLQueryEngine;
import org.swrlapi.sqwrl.SQWRLResult;
import org.swrlapi.sqwrl.exceptions.SQWRLException;

import fr.ummisco.oepicam.model.DeciderData;
import fr.ummisco.oepicam.model.DoctorData;
import fr.ummisco.oepicam.model.PatientData;
import fr.ummisco.oepicam.model.User;
import fr.ummisco.oepicam.model.UserAuth;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private PatientData patientData;
	private DoctorData doctorData;
	private DeciderData deciderData; 
	private User user;

	OWLOntologyManager ontologyManager;
	OWLOntology ontology;
	SQWRLQueryEngine queryEngine;
	
	/**
	 * Index page
	 */

//	/wtpwebapps/fr.ummisco.yde.o-epicam/resources
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String home(HttpServletRequest request){
		this.init();
//		String mainPath = System.getProperty("catalina.base");
		
//		System.getProperty("catalina.base")+File.separator+"mydata"+File.separator+filename;
		return "home";
	}
	
//	webapp/resources/epicam_v2.owl
	
	//Helpers methods 
	public void init() {
		System.out.println("\n\nINFO : Initialization before querying "
				+ "the knowledge base*******\n*****\n****");
		patientData = new PatientData();
		doctorData = new DoctorData();
		user = new User();
		deciderData = new DeciderData();
		ontologyManager = OWLManager.createOWLOntologyManager();
		try {
//			ontology = ontologyManager.loadOntologyFromOntologyDocument(new File("/opt/epicam_v2.owl"));
			ontology = ontologyManager.loadOntologyFromOntologyDocument(new File("/home/these/these/workspace_these/"
			+ "o-epicam/fr.ummisco.yde.o-epicam/src/main/webapp/resources/epicam_v2.owl"));
		 queryEngine = SWRLAPIFactory.createSQWRLQueryEngine(ontology);
		} catch (OWLOntologyCreationException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 */

	//Permet aux utilisateurs de s'authentifier avant d'accéder à l'information
	@RequestMapping(value="/authenticate", method=RequestMethod.POST)
	public String authenticate(HttpServletRequest request){
		this.init();
		String page="home";
		HttpSession session = request.getSession();
		String login = request.getParameter("login");
		String passwd = request.getParameter("passwd");
		if(login==null || login.equals("") || passwd==null || passwd.equals("")){
			page = "index";
		}
		else{
			//Vérifie si l'utilisateur est dans la base de connaissances
			String infoAuth = user.authentication(queryEngine, login, passwd);
			String[] parts = infoAuth.split("-");
			String auth = parts[0]; 
			String niveau = parts[1]; 
			if(auth.equals("true")){
				UserAuth userAuth = new UserAuth(login, passwd, niveau);
				session.setAttribute("user", userAuth);
			}
		}
		return "home";
	}
	
	//Searching data
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String search(HttpServletRequest request, HttpSession session){
		String page="home";
		String find = "rendez-vous";
		this.init();
		UserAuth user = (UserAuth)session.getAttribute("user");
		String login = user.getLogin();
		String passwd = user.getPasswd();
		String level = user.getLevel();
		
		String keyWord = request.getParameter("search");
		if(keyWord.toLowerCase().contains(find.toLowerCase()) && session.getAttribute("user")!=null){
			//Ici, il s'agit du patient
			if(level.equals("0")){
				String data = patientData.listNextRDV(queryEngine, login, passwd, level);
				session.setAttribute("data", data);
				page="patient";
			}
			//Ici, il s'agit du médecin
			if(level.equals("1")){
				System.out.println("*********************************************************************************************************\n\n");
				String data = doctorData.listRDVDuJour(queryEngine, login, passwd, level);
				String data1 = doctorData.listRDVManque(queryEngine, login, passwd, level);
				session.setAttribute("listrdv", data);
				session.setAttribute("listrdvmq", data1);
				page="doctor";
			}
//			Ici, il s'agit du décideur
			if(level.equals("3")){
				String data = deciderData.statPatientRdv(queryEngine, login, passwd, level);
				String[] parts = data.split("-");
				String rdvManque=parts[0];
				String rdvHonore=parts[1];
				String nbRDV=parts[2];
				String nbRDVManque=parts[3];
				String nbRDVHonore=parts[4];
				String tauxRespectRDV=parts[5];
				session.setAttribute("rdvManque", rdvManque);
				session.setAttribute("rdvHonore", rdvHonore);
				session.setAttribute("nbRDV", nbRDV);
				session.setAttribute("nbRDVManque", nbRDVManque);
				session.setAttribute("nbRDVHonore", nbRDVHonore);
				session.setAttribute("tauxRespectRDV", tauxRespectRDV);
				page="decider";
			}
		}
		else page = "home";
		
		return page;
	}


	@RequestMapping(value="/index", method=RequestMethod.GET)
	public String index(HttpServletRequest request){
		this.init();
		List<String> user = patientData.findUserData(queryEngine);
		System.out.println("Result of test request is :"+user);
		request.setAttribute("user", user);
		return "index";
	}
	
//	@RequestMapping(value="/doctorData", method=RequestMethod.GET)
//	public String test(HttpServletRequest request){
//		this.init();
//		String login = 
//		List<String> user = doctorData.loadPatientData(queryEngine, login, passwd);
//				findUserData(queryEngine);
//		System.out.println("Result of test request is :"+user);
//		request.setAttribute("user", user);
//		return "doctorData";
//	}
	
	
}
