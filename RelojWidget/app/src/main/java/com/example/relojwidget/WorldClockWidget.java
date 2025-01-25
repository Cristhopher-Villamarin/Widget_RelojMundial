package com.example.relojwidget;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.widget.RemoteViews;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

public class WorldClockWidget extends AppWidgetProvider {

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        // Iterar sobre todos los widgets que necesiten actualización
        for (int appWidgetId : appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId);
        }
    }

    private void updateAppWidget(Context context, AppWidgetManager appWidgetManager, int appWidgetId) {
        // Crear una vista remota para el widget
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_layout);

        // Crear el formato de fecha y hora
        SimpleDateFormat sdf = new SimpleDateFormat("hh:mm a", Locale.getDefault());

        // Configurar la zona horaria
        sdf.setTimeZone(TimeZone.getTimeZone("America/New_York")); // Cambiar por la zona deseada

        // Obtener la hora actual en la zona configurada
        String currentTime = sdf.format(new Date());

        // Actualizar el texto del widget con la hora
        views.setTextViewText(R.id.time_display, currentTime);

        // Actualizar el widget
        appWidgetManager.updateAppWidget(appWidgetId, views);
    }

}
