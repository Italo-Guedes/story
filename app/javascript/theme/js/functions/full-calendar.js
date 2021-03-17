import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import ptBRLocale from '@fullcalendar/core/locales/pt-br';
// import timeGridPlugin from '@fullcalendar/timegrid';
// import listPlugin from '@fullcalendar/list';

$(function () {
  if ($('#full-calendar-plugin')[0]) {
    var events = [];
    if (typeof fullCalendarFetchEvents === 'function') {
      events = fullCalendarFetchEvents;
    }
    if (typeof fullCalendarJsonFeed === 'string') {
      events = fullCalendarJsonFeed;
    }
    window.calendar = new Calendar($('#full-calendar-plugin')[0], {
      locale: ptBRLocale,
      events: events,
      plugins: [ dayGridPlugin ],
      dayMaxEventRows: true, // for all non-TimeGrid views
      initialView: 'dayGridMonth',
      headerToolbar: {
        right: 'prev,next',
        center: 'title',
        left: 'today'
        // right: 'dayGridMonth,timeGridWeek,listWeek'
      }
    });
    window.calendar.render();
  }
});