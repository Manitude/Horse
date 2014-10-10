// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery_ujs
//= require jquery
//= require jquery.ui.all
//= require_tree .

$(document).ready(function() {
	$('#furnish_detail label').css("color", "darkgrey");
	$('#furnish_detail select').attr('disabled', true);
});

require.config({
          paths: {
			  'fuelux': 'http://www.fuelcdn.com/fuelux/2.6.0/',
              'jquery': 'http://code.jquery.com/jquery-1.11.0.min'
			    }
    });
require(['fuelux/wizard']);

$('#furnishing').on('change', function() {
	if((this.value == "Fully-furnished") || this.value == "Semi-furnished"){
		$('#furnish_detail label').css("color", "black");
		$('#furnish_detail select').attr('disabled', false);
	}
	else{
		$('#furnish_detail label').css("color", "darkgrey");
		$('#furnish_detail select').attr('disabled', true);
	}
});

$('#btnWizardSkip').on('click', function() {
  $('#next').trigger("click");
});
$('#MyWizard').on('stepclick', function(e, data) {
  console.log('step' + data.step + ' clicked');
  if(data.step===1) {
  }
});

$('form#landlord_bank_detail_id').submit(function() {
    var bank_detail = $(this).serialize();
    $.ajax({
        url: $(this).attr('action'), //sumbits it to the given url of the form
        data: { bank_details:  bank_detail
        },
        dataType: "JSON", // you want a difference between normal and ajax-calls, and json is standard
	    success: function(json){
	    	alert("in 2");
	    	$('#next').trigger("click");
	    },
	    failure: function(error){
	        console.log(error);
	        alert("failure:::::Something went wrong, Please report this problem.");
	    },
	    error: function(error){
	        console.log(error);
	        alert("error::::::Something went wrong, Please report this problem.");
	    }
    });
//    return false; // prevents normal behaviour
});

$('form#user_detail_id').submit(function() {
	alert("this is user_detail_id!!");
    var user_details = $(this).serialize();
    $.ajax({
        url: $(this).attr('action'), //sumbits it to the given url of the form
        data: user_details,
        dataType: "JSON", // you want a difference between normal and ajax-calls, and json is standard
	    success: function(json){
	    	alert("in 2");
	    	$('#next').trigger("click");
	    },
	    failure: function(error){
	        console.log(error);
	        alert("failur:::::Something went wrong, Please report this problem.");
	    },
	    error: function(error){
	        console.log(error);
	        alert("error::::::Something went wrong, Please report this problem.");
	    }
    });
//    return false; // prevents normal behaviour
});