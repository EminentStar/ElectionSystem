package net.javabugs.web.common.utils;

import java.util.Calendar;

import org.joda.time.DateTime;

public class VsDateTimeFormatter {

	private static String pattern = "yyyy-MM-dd HH:mm:ss";

	public static String getFormattedDateTime(String strDateTime) {
		if( strDateTime == null || strDateTime.equals("") ) {
			return null;
		}
		DateTime dateTime = new DateTime(strDateTime);
		
		return dateTime.toString(pattern);
	}
	
	public static String getFormattedNowDateTime() {
		Calendar cal = Calendar.getInstance();
	    String dateString, timeString;

	    dateString = String.format("%04d%02d%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH));
	    timeString = String.format("%02d%02d%02d", cal.get(Calendar.HOUR_OF_DAY), cal.get(Calendar.MINUTE), cal.get(Calendar.SECOND));

	    return dateString + timeString;
	}
}
