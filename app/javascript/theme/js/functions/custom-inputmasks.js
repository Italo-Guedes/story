import $ from 'jquery'
import Inputmask from "inputmask"

$( document ).on('turbolinks:load', function() {
// $(function () {
    Inputmask.extendAliases({
      'br-currency': {
        alias: 'currency',
        digits: 2,
        rightAlign: false,
        removeMaskOnSubmit: true,
        showMaskOnFocus: true,
        showMaskOnHover: false,
        radixPoint: ",",
        groupSeparator: ".",
        allowPlus: false,
        allowMinus: false,
        autoUnmask: true,
        autoGroup: true,
        prefix: "R$ ",
        onUnMask: function (maskedValue, unmaskedValue) {
          return maskedValue.replace('R$ ', '').replace('0$ ', '').replace('.', '').replace(',', '.');
        },
        onBeforeMask: function (value, opts) {
          var new_val = value.replace(",", "").replace(".", ",");
          array = new_val.split(",");
          if (array.length == 2 && array[1].length < 2) {
            array[1] += (array[1].length == 0 ? "00" : "0");
          }
          new_val = array.join(",");
          return new_val;
        }
      }
    });
  
    Inputmask.extendAliases({
      'decimal': {
        autoGroup: true,
        removeMaskOnSubmit: true,
        radixPoint: ",",
        groupSeparator: ".",
        autoUnmask: true,
        autoGroup: true,
        onUnMask: function (maskedValue, unmaskedValue) {
          return maskedValue.replace('.', '').replace(',', '.');
        },
        onBeforeMask: function (value, opts) {
          return value.replace(",", "").replace(".", ",");
        }
      }
    });
  
    Inputmask.extendAliases({
      'percentage': {
        removeMaskOnSubmit: true,
        radixPoint: ",",
        groupSeparator: ".",
        autoUnmask: true,
        autoGroup: true,
        suffix: ' %',
        onUnMask: function (maskedValue, unmaskedValue) {
          return maskedValue.replace('.', '').replace(',', '.').replace(' %', '');
        },
        onBeforeMask: function (value, opts) {
          return value.replace(",", "").replace(".", ",");
        }
      }
    });
  
    Inputmask.extendAliases({
      'cpf': {
        mask: "999.999.999-99",
        greedy: false,
        autoUnmask: true,
        removeMaskOnSubmit: true
      }
    });
  
    Inputmask.extendAliases({
      'cnpj': {
        alias: 'cpf',
        mask: "99.999.999/9999-99"
      }
    });
  
    Inputmask.extendAliases({
      'phone': {
        mask: ["(99) 9999-9999", "(99) 99999-9999"],
        showMaskOnHover: false
      }
    });
  
    Inputmask.extendDefinitions({
      'A': {
        validator: "[A-Za-z]",
        cardinality: 1,
        casing: "upper" //auto uppercasing
      },
      'B': {
        validator: "[A-Za-z0-9]",
        cardinality: 1,
        casing: "upper" //auto uppercasing
      }
    });
  
    Inputmask.extendAliases({
        'br-datetime': {
            alias: 'datetime',
            inputFormat: 'dd/mm/yyyy HH:MM',
            showMaskOnFocus: true,
            showMaskOnHover: false
        }
    });
  
    Inputmask.extendAliases({
        'br-date': {
            alias: 'br-datetime',
            inputFormat: 'dd/mm/yyyy'
        }
    });
  
    Inputmask().mask(document.querySelectorAll("input"));

    $("input[inputmask='br-currency']").each(function () {
      Inputmask('br-datetime').mask(this);
      $(this).val($(this).val()); // Reset value
    });
  
    Inputmask('br-datetime').mask(document.querySelectorAll("input[inputmask='br-datetime']"));
    Inputmask('br-date').mask(document.querySelectorAll("input[inputmask='br-date']"));
});