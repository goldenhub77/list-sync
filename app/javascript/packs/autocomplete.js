$(document).ready( () => {
  let $globalSearch = $('#js-global-search-input');

  let options = {
    getValue: (element) => {
      return element.title || element.name;
    },
    url: (phrase) => {
      return "/autocomplete?q=" + phrase;
    },
    categories: [
      {
        listLocation: "lists",
        header: "<strong>Lists</strong>"
      },
      {
        listLocation: "users",
        header: "<strong>Users</strong>"
      }
    ],
    list: {
      onChooseEvent: () => {
        let url = $globalSearch.getSelectedItemData().url
        $("#js-global-search-btn").click();
    }
  }
};

  $globalSearch.easyAutocomplete(options);
  //workaround to fix styling issue of search input
  $('div.easy-autocomplete').removeAttr('style');
});
