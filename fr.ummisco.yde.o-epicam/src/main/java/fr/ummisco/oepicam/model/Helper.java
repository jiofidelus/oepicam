package fr.ummisco.oepicam.model;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Helper {
	
	public boolean today(String daterdv){
		boolean today=false;
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date now;
	    Date date;
	    try {
	    	now = date = dateFormat.parse(new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
	        date = dateFormat.parse(daterdv);
	        if(now.compareTo(date)==0)
	        	today=true;
	        else today=false;
	        
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
		return today;
	}
	
	public boolean after(String daterdv){
		boolean after=false;
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date now = new Date();
	    Date date;
	    try {
	        date = dateFormat.parse(daterdv);
	        if(date.after(now))
	        	after=true;
	        else after=false;
	        
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
		
		return after;
	}
	public boolean before(String daterdv){
		boolean before=false;
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date now = new Date();
	    Date date;
	    try {
	        date = dateFormat.parse(daterdv);
	        if(date.before(now))
	        	before=true;
	        else before=false;
	        
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
		
		return before;
	}
	
}
