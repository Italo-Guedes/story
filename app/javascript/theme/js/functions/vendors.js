'use strict';
import $ from 'jquery'
import autosize from 'autosize'

$(document).ready(function () {

  /*------------------------------------------------
      Autosize Textarea (Autosize)
  ------------------------------------------------*/
  if($('.textarea-autosize')[0]) {
    autosize($('.textarea-autosize'));
  }

  /*------------------------------------------------
      Select 2
  ------------------------------------------------*/
  if($('select.select2')[0]) {
    var select2parent = $('.select2-parent')[0] ? $('.select2-parent') : $('body');

    $('select.select2:not(.select-ajax)').select2({
      dropdownAutoWidth: true,
      width: '100%',
      dropdownParent: select2parent,
      language: 'pt-BR'
    });

    $("select.select2.select-ajax").each(function(){
      var jElement = $(this);
      var url = jElement.data().url
      if(!url) throw new Error('Select2 via ajax: attributo data-url não pode ficar em branco')

      var placeholder = jElement.data().placeholder
      if(!placeholder) throw new Error('Select2 via ajax: attributo data-placeholder não pode ficar em branco')

      jElement.select2({
        ajax: {
          url: url + "?select2=true",
          dataType: 'json',
          delay: 250,
        },
        allowClear: true,
        placeholder: placeholder,
        width: '100%',
        dropdownParent: select2parent,
        language: 'pt-BR',
      });
    });
  }

  /*------------------------------------------------
      Popovers (Bootstrap)
  -------------------------------------------------*/
  if($('[data-toggle="popover"]')[0]) {
      $('[data-toggle="popover"]').popover();
  }


  /*------------------------------------------------
      Tooltip (Bootstrap)
  -------------------------------------------------*/
  if($('[data-toggle="tooltip"]')[0]) {
      $('[data-toggle="tooltip"]').tooltip();
  }

  if($('a[data-toggle!="popover"], b[title], span[title]')[0]) {
    $('a[data-toggle!="popover"], b[title], span[title]').tooltip();
  }


  // /*------------------------------------------------
  //     Calendar Widget
  // ------------------------------------------------*/
  // if($('.widget-calendar__body')[0]) {
  //     $('.widget-calendar__body').fullCalendar({
  //         contentHeight: 'auto',
  //         theme: false,
  //         buttonIcons: {
  //             prev: ' zmdi zmdi-long-arrow-left',
  //             next: ' zmdi zmdi-long-arrow-right'
  //         },
  //         header: {
  //             right: 'next',
  //             center: 'title, ',
  //             left: 'prev'
  //         },
  //         defaultDate: '2016-08-12',
  //         editable: true,
  //         events: [
  //             {
  //                 title: 'Dolor Pellentesque',
  //                 start: '2016-08-01',
  //                 className: 'bg-cyan'
  //             },
  //             {
  //                 title: 'Purus Nibh',
  //                 start: '2016-08-07',
  //                 className: 'bg-amber'
  //             },
  //             {
  //                 title: 'Amet Condimentum',
  //                 start: '2016-08-09',
  //                 className: 'bg-green'
  //             },
  //             {
  //                 title: 'Tellus',
  //                 start: '2016-08-12',
  //                 className: 'bg-blue'
  //             },
  //             {
  //                 title: 'Vestibulum',
  //                 start: '2016-08-18',
  //                 className: 'bg-cyan'
  //             },
  //             {
  //                 title: 'Ipsum',
  //                 start: '2016-08-24',
  //                 className: 'bg-teal'
  //             },
  //             {
  //                 title: 'Fringilla Sit',
  //                 start: '2016-08-27',
  //                 className: 'bg-blue'
  //             },
  //             {
  //                 title: 'Amet Pharetra',
  //                 url: 'http://google.com/',
  //                 start: '2016-08-30',
  //                 className: 'bg-amber'
  //             }
  //         ]
  //     });

  //     //Display Current Date as Calendar widget header
  //     var mYear = moment().format('YYYY');
  //     var mDay = moment().format('dddd, MMM D');
  //     $('.widget-calendar__year').html(mYear);
  //     $('.widget-calendar__day').html(mDay);
  // }

  /*----------------------------------------------------------
      Custom Scrollbars (jquery-scrollbar and ScrollLock)
  -----------------------------------------------------------*/
  // if($('.scrollbar-inner')[0]) {
  //     $('.scrollbar-inner').scrollbar().scrollLock();
  // }


  /*------------------------------------------------
      Tree view - jqTree
  ------------------------------------------------*/
  // var treeviewData = [
  //     {
  //         name: 'node1',
  //         children: [
  //             {
  //                 name: 'node1_1',
  //                 children: [
  //                     { name: 'node1_1_1' },
  //                     { name: 'node1_1_2' },
  //                     { name: 'node1_1_3' }
  //                 ]
  //             },
  //             { name: 'node1_2' },
  //             { name: 'node1_3' }
  //         ]
  //     },
  //     {
  //         name: 'node2',
  //         children: [
  //             { name: 'node2_1' },
  //             { name: 'node2_2' },
  //             { name: 'node2_3' }
  //         ]
  //     },
  //     {
  //         name: 'node3',
  //         children: [
  //             { name: 'node3_1' },
  //             { name: 'node3_2' },
  //             { name: 'node3_3' }
  //         ]
  //     }
  // ];

  // var treeviewSimpleData = [
  //     {
  //         name: 'node1',
  //         children: [
  //             { name: 'node1_1' },
  //             { name: 'node1_2' },
  //             { name: 'node1_3' }
  //         ]
  //     },
  //     {
  //         name: 'node2',
  //         children: [
  //             { name: 'node2_1' },
  //             { name: 'node2_2' },
  //             { name: 'node2_3' }
  //         ]
  //     }
  // ];

  // var treeviewEscapeData = [
  //     {
  //         label: 'node1',
  //         children: [
  //             { name: '<a href="example1.html">node1_1</a>' },
  //             { name: '<a href="example2.html">node1_2</a>' },
  //             '<a href="example3.html">Example </a>'
  //         ]
  //     }
  // ];

  // if($('.treeview')[0]) {
  //     $('.treeview').tree({
  //         data: treeviewData,
  //         closedIcon: $('<i class="zmdi zmdi-plus"></i>'),
  //         openedIcon: $('<i class="zmdi zmdi-minus"></i>')
  //     });
  // }

  // if($('.treeview-expanded')[0]) {
  //     $('.treeview-expanded').tree({
  //         data: treeviewSimpleData,
  //         autoOpen: true,
  //         closedIcon: $('<i class="zmdi zmdi-plus"></i>'),
  //         openedIcon: $('<i class="zmdi zmdi-minus"></i>')
  //     });
  // }

  // if($('.treeview-drag')[0]) {
  //     $('.treeview-drag').tree({
  //         data: treeviewSimpleData,
  //         dragAndDrop: true,
  //         autoOpen: true,
  //         closedIcon: $('<i class="zmdi zmdi-plus"></i>'),
  //         openedIcon: $('<i class="zmdi zmdi-minus"></i>')
  //     });
  // }

  // if($('.treeview-drag')[0]) {
  //     $('.treeview-drag').tree({
  //         data: treeviewSimpleData,
  //         dragAndDrop: true,
  //         autoOpen: true,
  //         closedIcon: $('<i class="zmdi zmdi-plus"></i>'),
  //         openedIcon: $('<i class="zmdi zmdi-minus"></i>')
  //     });
  // }

  // if($('.treeview-escape')[0]) {
  //     $('.treeview-escape').tree({
  //         data: treeviewEscapeData,
  //         autoEscape: false,
  //         autoOpen: true,
  //         closedIcon: $('<i class="zmdi zmdi-plus"></i>'),
  //         openedIcon: $('<i class="zmdi zmdi-minus"></i>')
  //     });
  // }


  /*------------------------------------------------
      Ratings - RateYo!
  ------------------------------------------------*/
  // if($('.rating')[0]) {
  //     $('.rating').each(function () {
  //         var rating = $(this).data('rating');

  //         $(this).rateYo({
  //             rating: rating,
  //             normalFill: '#e9ecef',
  //             ratedFill: '#ffc721'
  //         });
  //     });
  // }
});