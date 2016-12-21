package test;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Tests {
	
	public static void main(String[] args)  {
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date date;
	    Date date1;
	    Date date2;
	    Date date3;
	    
	    String chaine = "papa et maman";
	    
	    
	    try {
	        date1 = dateFormat.parse("04/12/2013");
	        date2 = dateFormat.parse("04/12/2014");
	        date3 = dateFormat.parse("18/11/2016");
	        date = dateFormat.parse(new SimpleDateFormat("dd/MM/yyyy").format(new Date()));

	        
//	        if(date1.compareTo(date2)==0){System.out.println("The two dates are equals");}
//	        else System.out.println("The two dates are differents");
//
//	        if(date1.after(date2)){System.out.println("Date is lower than date 1");}
//	        if(date1.before(date2)){System.out.println("Date 1 is greater than date");}
//	        
//	        if(date.after(date2)){System.out.println("*** Date is lower than date 1");}
//	        if(date1.before(date2)){System.out.println("Date 1 is greater than date");}
//	        
//	        
//	        System.out.println(date1.toString());
//	        String output = dateFormat.format(date1); 
//	        System.out.println(output); 
	        

	        if(date3.compareTo(date)==0){System.out.println("The two dates are equals");}
	        else System.out.println("The two dates are differents");

	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
		
	}
	
}
