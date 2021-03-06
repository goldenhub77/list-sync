$(document).ready( () => {
  var $searchBtn = $("#js-global-search-btn");
  var $globalSearch = $('#js-global-search-input');
  var options = {
    getValue: (element) => {
      return element.title || element.name;
    },
    url: (phrase) => {
      return "/autocomplete?q=" + phrase;
    },
    categories: [
      {
        listLocation: "lists",
        header: "<strong><em>Lists</em></strong>"
      },
      {
        listLocation: "users",
        header: "<strong><em>Users</em></strong>"
      }
    ],
    list: {
      maxNumberOfElements: 10,
      onClickEvent: () => {
        let currentData = $globalSearch.getSelectedItemData();
        // $searchBtn.click();
        window.location.href = currentData.url;
      }
    }
  };
  $globalSearch.easyAutocomplete(options);
    //workaround to fix styling issue of search input after intializing easyAutocomplete
  $('div.easy-autocomplete').removeAttr('style');

  $globalSearch.val(localStorage.q);

  $globalSearch.on('change', (event) => {
    localStorage.setItem('q', $globalSearch.val());
  });
});
