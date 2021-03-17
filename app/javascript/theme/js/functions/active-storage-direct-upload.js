import $ from 'jquery'
import Rails from "@rails/ujs"
var Swal = require('sweetalert2');

$(function () {
  addEventListener("direct-upload:error", function(event) {
    event.preventDefault();
    debugger;
    
    $('button[data-disable-with]').each(function () {
      Rails.enableElement(this);
      $(this).removeAttr('disabled');
    });

    Swal.fire({
      title: 'Atenção',
      text: 'Houve um erro ao enviar os anexos. Recarregue a página e tente novamente',
      type: 'warning',
      confirmButtonText: 'Ok'
    });
  });
});