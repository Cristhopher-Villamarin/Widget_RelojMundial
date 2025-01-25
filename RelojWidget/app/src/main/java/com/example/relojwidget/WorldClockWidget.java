package com.example.relojwidget;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.SharedPreferences;
import android.widget.RemoteViews;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

public class WorldClockWidget extends AppWidgetProvider {

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        for (int appWidgetId : appWidgetIds) {
            // Recuperar la zona horaria desde SharedPreferences
            SharedPreferences prefs = context.getSharedPreferences("WidgetPrefs", Context.MODE_PRIVATE);
            String timeZone = prefs.getString("timeZone_" + appWidgetId, "UTC");

            // Actualizar el widget con la hora actual y el país seleccionado
            updateAppWidget(context, appWidgetManager, appWidgetId, timeZone);
        }
    }

    public static void updateAppWidget(Context context, AppWidgetManager appWidgetManager, int appWidgetId, String timeZone) {
        // Crear RemoteViews
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_layout);

        // Formatear la hora con la zona horaria seleccionada
        SimpleDateFormat sdf = new SimpleDateFormat("hh:mm a", Locale.getDefault());
        sdf.setTimeZone(TimeZone.getTimeZone(timeZone));
        String currentTime = sdf.format(new Date());

        // Extraer el nombre del país desde la zona horaria
        String country = getCountryFromTimeZone(timeZone);

        // Actualizar el texto del TextView en el widget
        views.setTextViewText(R.id.time_display, currentTime); // Actualizar la hora
        views.setTextViewText(R.id.country_display, country); // Actualizar el país

        // Actualizar el widget con las nuevas vistas
        appWidgetManager.updateAppWidget(appWidgetId, views);
    }

    // Función para obtener el nombre del país desde la zona horaria
    private static String getCountryFromTimeZone(String timeZone) {
        // Ejemplo: Para "America/New_York" devuelve "New York, USA"
        if (timeZone.contains("/")) {
            String[] parts = timeZone.split("/");
            return parts[1].replace("_", " ") + ", " + parts[0];
        }
        return timeZone;
    }
}
