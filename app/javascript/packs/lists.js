$(document).on("turbolinks:load", () => {
  $("#list_due_date").on("keydown keyup", (event) => {
    event.preventDefault();
  });

  $("#list_due_date").datetimepicker({
    dateFormat: "mm/dd/yy",
    timeFormat: "hh:mm TT"
  });

  $("#clear-list-date").on("click", (event) => {
    event.preventDefault();
    $("#list_due_date").val("");
  });
});
