jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", (($(window).height() - this.outerHeight()) / 2) + $(window).scrollTop() + "px");
    this.css("left", (($(window).width() - this.outerWidth()) / 2) + $(window).scrollLeft() + "px");
    return this;
}

$(document).ready(function() {
	//form interger for set as default
	$('.valSetCustomThumb').click(function() {
	  var $value = $(this)
	});
	
	//fb
	$('.fb-like-form').submit(function() {
		$.post($(this).attr("action"), $(this).serialize(), null, "script");
		
		return false;
	});

	//visible / invisible
	$('.black-box.button').click(function() {
	  $(this).parent().find('.fval').val(1);
	  $(this).before('<div class="fnotice_js">Saved</div>').prev().fadeOut(2000);
	  $(this).parents('.form_imgselect').submit();
	});
	
	$('.white-box.button').click(function() {
	  $(this).parent().find('.fval').val(2);
	  $(this).before('<div class="fnotice_js">Saved</div>').prev().fadeOut(2000);
	  $(this).parents('.form_imgselect').submit();
	});
	
	// layout form setup
	$('.defaultLayout').click(function() {
	  $(this).parent().find('.layoutVal').val(1);
	  $(this).before('<div class="fnotice_js">Saved</div>').prev().fadeOut(2000);
	  $(this).parents('.form_imgselect').submit();
	});
	
	$('.layout2').click(function() {
	  $(this).parent().find('.layoutVal').val(2);
	  $(this).before('<div class="fnotice_js">Saved</div>').prev().fadeOut(2000);
	  $(this).parents('.form_imgselect').submit();
	});
		
	$('.layout3').click(function() {
	  $(this).parent().find('.layoutVal').val(3);
	  $(this).before('<div class="fnotice_js">Saved</div>').prev().fadeOut(2000);
	  $(this).parents('.form_imgselect').submit();
	});
	// end layout form setup
	
	$('.form_imgselect').submit(function() {
		$.post($(this).attr("action"), $(this).serialize(), null, "script");
		//var $frow = $(this).find('.field').parents('.row');
		return false;
	});
	
	
	//visible/invisible in projects show
	$('.visible-form .visible').click(function() {
		$(this).parent().find('#project_visible.isvisible').val(1);
		$(this).parent().before('<div class="fnotice_js">Saved</div>').prev().fadeOut(2000);
		$(this).parents('.form_imgselect').submit();
	});
	$('.visible-form .invisible').click(function() {
		$(this).parent().find('#project_visible.isvisible').val(0);
		$(this).parent().before('<div class="fnotice_js">Saved</div>').prev().fadeOut(2000);
		$(this).parents('.form_imgselect').submit();
	});
	// END visible/invisible in projects show
	
	$('.form_proj').submit(function() {
		$.post($(this).attr("action"), $(this).serialize(), null, "script");
		var $frow = $(this).find('.field').parents('.row');
		/*var $update_val = $(this).find('.field').val();*/
		
		var $update_fields = $(this).find('.field');
		$updated_val ="";
		$update_fields.each(function() {
          $updated_val += this.value + " ";
		});
		
		$frow.prev().find('.fval').html($updated_val);
		$frow.hide();
		$frow.prev().show();
		$frow.prev().before('<div class="fnotice_js">Saved</div>').prev().fadeOut(2000);
		return false;
	});
	
	//form submit when subdomain (for link)
	$('.form_proj.subdomainfrm').submit(function() {
	  $subdomain = $(this).find('.field').val();
	  $(this).find('.fval').html($subdomain + '.' + location.hostname);
	  $('.subdomainLink').attr("href", 'http://' + $subdomain + '.' + location.hostname );
	});
	// end of subdomain link
								 
	$('.fedit').hide();
							
	$('.edit-btn').click(function() {
		$(this).parent().hide();
		$(this).parent().next().show();
	});
	
	/*when the field edit is cancel*/
	$('.fcancel').click(function() {
		$(this).closest('.fedit').hide();
		$(this).closest('.fedit').prev().show();
		return false;
	});
	
	/*when the field edit is saved*/
	$('.fsave').click(function() {
		var thetext = $(this).prev().val();
		/*
		$form = $(this).closest('form');
		$.post($form.attr("action"), $form.serialize(), null, "script");
		*/
		$(this).closest('.fedit').prev().find('.fval').html(thetext);
		$(this).closest('.fedit').hide();
		$(this).closest('.fedit').prev().show();
		return false;
	});
	
});