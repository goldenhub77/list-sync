$(document).on("turbolinks:load", () => {
  const dateTimeHidden = $("#js-list-due-date");
  const dateTimeString = dateTimeHidden.val() || null;
  const dueDateInput = $("#js-date-time-view");
  var formattedViewTime = "";

  dueDateInput.on("keydown keyup", (event) => {
    event.preventDefault();
  });

  if (dateTimeString != null) {
    formattedViewTime = moment(dateTimeString).local().format('MM/DD/YYYY hh:mm A');
  }

  $("#list-date-picker").datetimepicker({
    format: 'MM/DD/YYYY hh:mm A',
    defaultDate: false,
    useCurrent: false
  });

  dueDateInput.val(formattedViewTime);
  dateTimeHidden.val(moment(formattedViewTime).local().format());

  $("#list-date-picker").on("dp.change", (event) => {
    formattedTime = moment(event.date).local().format();
    dateTimeHidden.val(formattedTime);
  });

  $("#clear-list-date").on("click", (event) => {
    event.preventDefault();
    dueDateInput.val("");
    dateTimeHidden.val("");
  });
});
