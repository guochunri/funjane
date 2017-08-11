// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

$(document).on('scroll', function () {
  /*===== Welcome#index - 首页导航栏变化 =====*/
	if ($(this).scrollTop() > 125) {
		$('#navbar').addClass('show_bgcolor')
	} else {
		$('#navbar').removeClass('show_bgcolor')
	}

  /*===== Welcome#index - 回到页面顶端 =====*/
  if ($(this).scrollTop() > 2000) {
    $(".goTop").fadeIn(100); //按钮出现时间（画面下移）
  } else {
    $(".goTop").fadeOut(200); //按钮消失时间（画面上移）
  }

  $(".goTop").click(
    function() {
      $('html,body').scrollTop(0);
    });
})
