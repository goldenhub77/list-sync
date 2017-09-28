$(document).ready( () => {
  const dateTimeHidden = $("#js-list-due-date");
  const dueDateInput = $("#js-date-time-view");
  let dateTimeString = dateTimeHidden.val() || null;
  let formattedViewTime = "";

  dueDateInput.on("keydown keyup", (event) => {
    event.preventDefault();
  });

  if (dateTimeString !== null) {
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
    if (dueDateInput.val() !== "") {
      formattedTime = moment(dueDateInput.val(),'MM/DD/YYYY hh:mm A').local().format();
    }else {
      formattedTime = null;
    }
    dateTimeHidden.val(formattedTime);
  });
});
