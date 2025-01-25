package com.example.relojwidget;
import com.example.relojwidget.R;
import android.app.PendingIntent;
import android.content.Intent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.widget.RemoteViews;
import android.content.SharedPreferences;
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

            // Crear RemoteViews para actualizar el widget
            RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_layout);

            // Configurar el botón para abrir la actividad de configuración
            Intent configIntent = new Intent(context, WidgetConfigActivity.class);
            configIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId);
            configIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

            PendingIntent configPendingIntent = PendingIntent.getActivity(
                    context,
                    appWidgetId,
                    configIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE
            );
            views.setOnClickPendingIntent(R.id.time_zone_button, configPendingIntent);

            // Actualizar el widget con la hora actual
            updateAppWidget(context, appWidgetManager, appWidgetId, timeZone);

            // Enviar la actualización al widget
            appWidgetManager.updateAppWidget(appWidgetId, views);
        }
    }

    public static void updateAppWidget(Context context, AppWidgetManager appWidgetManager, int appWidgetId, String timeZone) {
        // Crear RemoteViews
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_layout);

        // Formatear la hora con la zona horaria seleccionada
        SimpleDateFormat sdf = new SimpleDateFormat("hh:mm a", Locale.getDefault());
        sdf.setTimeZone(TimeZone.getTimeZone(timeZone));
        String currentTime = sdf.format(new Date());

        // Actualizar el texto del TextView en el widget
        views.setTextViewText(R.id.time_display, currentTime);

        // Actualizar el widget con las nuevas vistas
        appWidgetManager.updateAppWidget(appWidgetId, views);
    }


}
