// Define the `nui` module
var nui = angular.module('nui', []);

// Define the `PhoneListController` controller on the `phonecatApp` module
nui.controller('nuiController', function nuiController( $scope, $document, $window ) {
	
	$scope.submitEnter = function(event) {
		var username = $("#username").val();
		var password = $("#password").val();
		
        if( username != '' && password != '' ) {	
			$.post('http://bubble_login/bubble_login:LoginServer', JSON.stringify({
				username: $("#username").val(),
				password: $("#password").val()
			}));
		} else {
			$.post('http://bubble_login/bubble_login:LoginErrorServer', JSON.stringify({}));
		}
	}	
	
	$scope.submitLeave = function(event) {		
        $.post('http://bubble_login/bubble_login:LeaveServer', JSON.stringify({}));
    }	
	
    window.addEventListener('message', function(event) {		
        if ( event.data.type == 'EnableGuiLogin' ) {					
            document.body.style.display = event.data.StatusJs ? "block" : "none"; // If data 'StatusJs' is enable, change css to 'block'			
        }		
    });
	
});


/*NOTIFY*/

$(function () {
    var icons = {
        "system" : "fas fa-info-circle",
        "info" : "fas fa-question-circle",
        "success" : "fas fa-check-circle",
        "error" : "fas fa-times-circle",
        "warning" : "fas fa-exclamation-triangle",
        "sms" : "fas fa-comment"
    };

    var colours = {
        "system" : "#95a5a6",
        "info" : "#0feff2",
        "success" : "#3ab629",
        "error" : "#cf2727",
        "warning" : "#f1c40f",
        "sms" : "#d046d5"
    };

    window.addEventListener('message', function (event) {
        if (event.data.action == 'notification') {
            var number = Math.floor((Math.random() * 1000) + 1);
            $('.notify-wrapper').append(`
            <div class="notify-div wrapper-${number}" style="border-bottom: 1px solid ${colours[event.data.type]}; display:none">
                <div class="align-items-baseline notify-title">
                    <h5 class="text-uppercase notify-title-text" style="color: ${colours[event.data.type]}">${event.data.title}</h5>
                </div>
            <p class="text-break notify-main-text">${event.data.message}</p>
            </div>`)
            $(`.wrapper-${number}`).fadeIn("slow");
            setTimeout(function () {
                $(`.wrapper-${number}`).fadeOut( "slow", function () {
                    $(`.wrapper-${number}`).remove()
                })
            }, event.data.time)
            var ui = document.querySelector('.notify-wrapper');
            if (event.data.position === 'left') {
                ui.style.right = '82.5%';
            }
            if (event.data.position === 'right') {
                ui.style.right = '1%';
            }
        }
    })
})