/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs-test/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 2);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

$(document).ready(function () {
  var dateTimeHidden = $("#js-list-due-date");
  var dateTimeString = dateTimeHidden.val() || null;
  var dueDateInput = $("#js-date-time-view");
  var formattedViewTime = "";

  dueDateInput.on("keydown keyup", function (event) {
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

  $("#js-list-date-picker").on("dp.change db.show", function (event) {
    formattedTime = moment(dueDateInput.val()).local().format();
    dateTimeHidden.val(formattedTime);
  });
});

/***/ }),
/* 1 */
/***/ (function(module, exports) {

$(document).ready(function () {
  var $searchBtn = $("#js-global-search-btn");
  var $globalSearch = $('#js-global-search-input');
  var options = {
    getValue: function getValue(element) {
      return element.title || element.name;
    },
    url: function url(phrase) {
      return "/autocomplete?q=" + phrase;
    },
    categories: [{
      listLocation: "lists",
      header: "<strong><em>Lists</em></strong>"
    }, {
      listLocation: "users",
      header: "<strong><em>Users</em></strong>"
    }],
    requestDelay: 500,
    list: {
      onClickEvent: function onClickEvent() {
        //possible future use
        var currentData = $globalSearch.getSelectedItemData();
        // $searchBtn.click();
        window.location.href = currentData.url;
      }
    }
  };
  $globalSearch.easyAutocomplete(options);
  //workaround to fix styling issue of search input after intializing easyAutocomplete
  $('div.easy-autocomplete').removeAttr('style');

  $globalSearch.val(localStorage.q);

  // $searchBtn.on('click', (event) => {
  //   executeSearch(event);
  // });

  $globalSearch.on('change', function (event) {
    localStorage.setItem('q', $globalSearch.val());
  });
});

/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
var lists = __webpack_require__(0);
var autocomplete = __webpack_require__(1);

$(document).ready(function () {

  $(".close").on("click", function (event) {
    $(".close").parent().hide("slow");
  });
});

/***/ })
/******/ ]);