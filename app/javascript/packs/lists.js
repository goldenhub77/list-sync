$(document).on("turbolinks:load", () => {
  const dateTimeHidden = $("#js-list-due-date");
  const dateTimeString = dateTimeHidden.val() || null;
  const dueDateInput = $("#js-date-time-view");
  var formattedViewTime = "";

  dueDateInput.on("keydown keyup", (event) => {
    event.preventDefault();
  });

  if (dateTimeString != null) {
    formattedViewTime = moment(dateTimeString).format('MM/DD/YYYY hh:mm A');
  }

  $("#js-list-date-picker").datetimepicker({
    useCurrent: false,
    keepInvalid: true,
    showTodayButton: true,
    showClear: true
  });
  dueDateInput.val(formattedViewTime);
  dateTimeHidden.val(dateTimeString);

  $("#js-list-date-picker").on("dp.change db.show", (event) => {
    formattedTime = moment(dueDateInput.val()).local().format();
    dateTimeHidden.val(formattedTime);
  });
});
