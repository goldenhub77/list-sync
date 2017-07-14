$(document).ready( () => {
  let dates = $(".js-item-date-completed");
  let humanDateTags = $(".js-item-human-date");

  for (i = 0; i < dates.length; i++) {
    if (dates[i].value != "") {
      humanDateTags[i].innerHTML = moment(dates[i].value).format("MM/DD/YYYY hh:mm A");
    }else{
      null
    }
  }

  $(".js-item-completed").change((event) => {
    event.delegateTarget.form.elements[4].value = moment().format();
    event.currentTarget.form.submit();
  });
});
