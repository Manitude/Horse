$(document).ready(function() {

});
function hideBreadcrumb() {
    $(".breadcrumb").hide();
}
// pay-now page exclusive:start
jQuery('#roommate_remind_me_later').on('click', function(){
    $("#invitation_alert").hide();
});

jQuery('#roommate_denied').on('click', function(){
    var host = $('#host_id').text();
    if (host){
        jQuery.ajax({
            url: '/roommate_request_response',
            data: {
                response: 'roommate_denied',
                host_id: host
            },
            method: 'POST',
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},

            success: function(){
                $("#invitation_alert").hide();
                $("#invitation_denial").show();
            },
            failure: function(error){
                console.log(error);
                alert("Something went wrong, Please try again later.");
            },
            error: function(error){
                console.log(error);
                alert("Oops! there was an error, Please reload the page and try again.");
            }
        });
    }
});

jQuery('#roommate_accepted').on('click', function(){
    var host = $('#host_id').text();
    if (host){
        jQuery.ajax({
            url: '/roommate_request_response',
            data: {
                response: 'roommate_accepted',
                host_id: host
            },
            method: 'POST',
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},

            success: function(){
                $("#invitation_alert").hide();
                $("#invitation_acceptance").show();
            },
            failure: function(error){
                console.log(error);
                alert("Something went wrong, Please try again later.");
            },
            error: function(error){
                console.log(error);
                alert("Oops! there was an error, Please reload the page and try again.");
            }
        });
    }
});

jQuery('#solo_accepted').on('click', function(){
    var host = $('#host_id').text();
    if (host){
        jQuery.ajax({
            url: '/roommate_request_response',
            data: {
                response: 'solo_accepted',
                host_id: host
            },
            method: 'POST',
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},

            success: function(){
                $("#invitation_alert").hide();
                $("#invitation_acceptance").show();
            },
            failure: function(error){
                console.log(error);
                alert("Something went wrong, Please try again later.");
            },
            error: function(error){
                console.log(error);
                alert("Oops! there was an error, Please reload the page and try again.");
            }
        });
    }
});

jQuery('#group_accepted').on('click', function(){
    var host = $('#host_id').text();
    if (host){
        jQuery.ajax({
            url: '/roommate_request_response',
            data: {
                response: 'group_accepted',
                host_id: host
            },
            method: 'POST',
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},

            success: function(){
                $("#invitation_alert").hide();
                $("#invitation_acceptance").show();
            },
            failure: function(error){
                console.log(error);
                alert("Something went wrong, Please try again later.");
            },
            error: function(error){
                console.log(error);
                alert("Oops! there was an error, Please reload the page and try again.");
            }
        });
    }

});

// pay-now page exclusive:end
jQuery(document).ready(function($) {
      $('a[rel*=facebox]').facebox()
})

$('[data-toggle=tooltip]').tooltip();

jQuery('#add_roommate').on('click', function(){
	$("#same_id_alert").hide();
    var val = $.trim($("#search_email_id").val());
    if(val){
        jQuery.ajax({
        url: '/search_roommate',
        data: {
        email_id: val
        },
        method: 'POST',
		  beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},

        success: function(result){
            if (result === 'invitation_sent'){
                $("#modal_close").click();
                $("div[id^=alert]").hide();
                $('#invitation_alert').show();
                // $('#alert_content').text(' An invitation has been send to '+val+' to join us!');
                // close the modal and show a div to show an invitation has been sent!
            }
            else if (result === 'request_sent'){
                $("#modal_close").click();
                $("div[id^=alert]").hide();
                $('#request_alert').show();
                // $('#alert_content').text(' Now we wait for '+val+' to confirm this request.');
                // close the modal and show a div to show an request has been sent!
            }
            else if (result === 'no_information'){
                $("#modal_close").click();
                $("div[id^=alert]").hide();
                $('#fill_information').show();
                // close the modal and show a div to show an request has been sent!
            }
            else{
                // open an alert asking user to enter his roommate's id not his
                $("#search_email_id").val('');
                $("#same_id_alert").show();
            }
        },
        failure: function(error){
            console.log(error);
            alert("Something went wrong, Please try again later.");
        },
        error: function(error){
            console.log(error);
            alert("Oops! there was an error, Please reload the page and try again.");
        }
        });
    }
    else{
        $("#null_id_alert").show();
    }
});

jQuery('#submit_review').on('click', function(){
    jQuery.ajax({
                url: '/submit_review',
                data: {
                rating: $('input[name=rating]:checked').val(),
                review: $('#review_content').val()
                },
                method: 'POST',
                beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},

                success: function(status){
                    if (status === 'success'){
                        $('#review_success_alert').show();
                    }
                    else{
                        $("#review_failure_alert").show();
                    }
                },
                failure: function(error){
                    console.log(error);
                    alert("Something went wrong, Please try again later.");
                },
                error: function(error){
                    console.log(error);
                    alert("Oops! there was an error, Please reload the page and try again.");
                }
    });
});

jQuery('#quit_roommate').on('click', function(){
    
});

jQuery('#reset_bank_details').on('click', function(){
    $('input[type=text]').val('');
});

jQuery('#edit_detail').on('click', function(){
    $('#details').hide();
    $('#edit_details').show();
    $('#edit_detail').hide();
});


function operateFormatter(value, row, index) {
        return [
            '<a style="padding-right:5%;" class="like" href="javascript:void(0)" title="Send a Reminder">',
                '<i class="glyphicon glyphicon-envelope"></i>',
            '</a>',
            '<a style="padding-right:5%;" class="edit ml10" href="javascript:void(0)" title="Pay their Rent">',
                '<i class="glyphicon glyphicon-usd"></i>',
            '</a>',
            '<a class="remove ml10" href="javascript:void(0)" title="Remove">',
                '<i class="glyphicon glyphicon-remove"></i>',
            '</a>'
        ].join('');
    }

    window.operateEvents = {
        'click .like': function (e, value, row, index) {
            alert('You click like icon, row: ' + row.email_id);
            // send a mail to row.email_id
        },
        'click .edit': function (e, value, row, index) {
            alert('You click edit icon, row: ' + JSON.stringify(row));
            // make a payment for row.email_id
        },
        'click .remove': function (e, value, row, index) {
            alert('You click remove icon, row: ' + JSON.stringify(row));
            // remove this user from rm_list
        }
    };
function rentStatusFormatter(value, row) {
    if (value !== null && value !== undefined){
        var yy = value.substring(0, 4);
        var mm = value.substring(5, 7);

        var today = new Date();
        var mm1 = today.getMonth()+1; //January is 0!
        var yyyy1 = today.getFullYear();

        if (yy == yyyy1 && mm == mm1){
            return '<span class="label label-success">Paid</span>';
        }
        else{
            return '<span class="label label-danger">Not Paid</span>';
        }
    }
    return '<span class="label label-danger">Not Paid</span>';
}
function purposeFormatter(value, row) {
    if (value == 'rent'){
        return '<span>Rent</span>';
    }
    else{
        return '<span class="glyphicon glyphicon-random" title="On behalf of roommate">&nbsp;Rent</span>';
    }
}
function dateFormatter(value, row) {
    if (value !== null && value !== undefined){
        var yyyy = value.substring(0, 4);
        var mm = value.substring(5, 7);
        var dd = value.substring(8, 10);
        var date = dd+'/'+mm+'/'+yyyy;
        return '<span>'+date+'</span>';
    }
}
function statusFormatter(value, row) {
    if (row !== null && row !== undefined){
        if (row.pending == true){
            return '<span class="label label-warning">Pending</span>';
        }
        var due_date = row.payment_due_date.substring(0, row.payment_due_date.length - 1).replace("T"," ");
        var payment_date = row.payment_done_at.substring(0, row.payment_done_at.length - 1).replace("T"," ");

        if(due_date > payment_date){
            return '<span class="label label-success">Successful</span>';
        }
        else{
            return '<span class="label label-danger">Late</span>';
        }    

    }
}