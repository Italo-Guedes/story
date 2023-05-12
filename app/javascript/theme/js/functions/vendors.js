'use strict';
import $ from 'jquery'
import autosize from 'autosize'

$( document ).on('turbolinks:load', function() {
// $(document).ready(function () {

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
          url: url,
          dataType: 'json',
          delay: 250,
          data: function (params) {
            var query = {
              pgq: params.term,
              select2: true
            }
            // Query parameters will be ?pgq=[term]&select2=true
            return query;
          }
        },
        allowClear: true,
        placeholder: placeholder,
        width: '100%',
        dropdownParent: select2parent,
        language: 'pt-BR',
      });
    });
  }

  // Autofocus on select2 search on open
  $(document).on('select2:open', () => {
    document.querySelector('.select2-search__field').focus();
  });

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
    $('[data-toggle="tooltip"]').tooltip({ boundary: 'window' });
  }

  if($('a[data-toggle!="popover"], b[title], span[title]')[0]) {
    $('a[data-toggle!="popover"], b[title], span[title]').tooltip({ boundary: 'window' });
  }
});