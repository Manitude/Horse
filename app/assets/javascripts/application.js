

$("#skip").click(function(){
	goToProperty();
});


$('#MyWizard').on('stepclick', function(e, data) {
  console.log('step' + data.step + ' clicked');
  if(data.step===1) {
  }
});

$('#bank_details_next').click(function(e) {
	var detail = $('form#landlord_bank_detail_id').serialize();
	e.preventDefault();
    $.ajax({
        url: $('form#landlord_bank_detail_id').attr('action'), //sumbits it to the given url of the form
        data: detail,
        method: 'POST',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType: "html", // you want a difference between normal and ajax-calls, and json is standard
	    
	    success: function(){
	    	goToUser();
	    },
	    error: function(){
	        // console.log(error);
	         alert("Oops! there was an error, Please reload the page and try again.");
	    },
	    failure: function(){
	        // console.log(error);
	        alert("Something went wrong, Please report this problem.");
	    }
	    
    });
//    return false; // prevents normal behaviour
});

$('#user_details_next').click(function(e) {
	var detail = $('form#user_detail_id').serialize();
	e.preventDefault();
    $.ajax({
        url: $('form#user_detail_id').attr('action'), //submits it to the given url of the form
        data: detail,
        method: 'POST',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType: "html", // you want a difference between normal and ajax-calls, and json is standard
        
	    success: function(){
    		goToProperty();
	    },
	    failure: function(){
	        alert("Something went wrong, Please report this problem.");
	    },
	    error: function(){
	        alert("Oops! there was an error, Please reload the page and try again.");
	    }
    });
//    return false; // prevents normal behaviour
});

function goToUser() {
    $('*[data-target="#step1"]').removeClass('active');
	$('*[data-target="#step1"]').addClass('badge');
	$('*[data-target="#step2"]').removeClass('badge');
	$('*[data-target="#step2"]').addClass('active');
    $('#step1').hide();
    $('#step2').show();
}

function goToProperty() {
	$('*[data-target="#step2"]').removeClass('active');
	$('*[data-target="#step2"]').addClass('badge');
	$('*[data-target="#step3"]').removeClass('badge');
	$('*[data-target="#step3"]').addClass('active');
    $('#step2').hide();
    $('#step3').show();
}