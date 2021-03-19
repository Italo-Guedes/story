import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import ptBRLocale from '@fullcalendar/core/locales/pt-br';
// import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';

$( document ).on('turbolinks:load', function() {
// $(function () {
  if ($('#full-calendar-plugin')[0]) {
    var defaultView = 'dayGridMonth';
    if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
      defaultView = 'listWeek';
    } //IF MOBILE CHANGE VIEW TO AGENDA DAY
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
      plugins: [ dayGridPlugin, listPlugin ],
      dayMaxEventRows: true, // for all non-TimeGrid views
      initialView: defaultView,
      headerToolbar: {
        // left: 'prev,next today',
        left: 'prev,next',
        center: 'title',
        right: 'dayGridMonth,listWeek'
      }
    });
    window.calendar.render();
  }
});