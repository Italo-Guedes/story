import flatpickr from "flatpickr";
import 'flatpickr/dist/flatpickr.css';

$(function() {
  flatpickr("[data-datePicker]", {
    enableTime: false,
    dateFormat: "d/m/Y",
  });
  
  flatpickr("[data-dateTimePicker]", {
    enableTime: true,
    dateFormat: "d/m/Y H:i",
  });
});