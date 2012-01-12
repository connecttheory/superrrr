  function setNavi( $c, $i ) {
  	var title = $i.attr( 'alt' );
  	$('#title').text( title );

  	var current = $c.triggerHandler( 'currentPosition' );
  	$('#pagenumber span').text( current+1 );

  	var $prev = ($i.is(':first-child')) ? $c.children().last() : $i.prev();
  	var small = $prev.attr('src').split('/large/').join('/small/');
  	$('#prev').html('<img width="100" height="75" src="'+small+'" />');

  	var $next = $i.next();
  	var small = $next.attr('src').split('/large/').join('/small/');
  	$('#next').html('<img width="100" height="75" src="'+small+'" />');
  }
  $(function() {
  	$("#carousel").carouFredSel({
  		items: 1,
  		prev: '#prev',
  		next: '#next',
  		pagination: {
  			container: '#pager span',
  			anchorBuilder: function( nr, $img ) {
  				var small = $img.attr('src').split('/large/').join('/small/');
  				return '<a href="#" title="Go to image '+nr+'.">'+nr+'<img width="100" height="75" src="'+small+'" /></a>';
  			}
  		},
  		scroll: {
  			onBefore: function( $oI, $nI ) {
  				setNavi( $(this), $nI );
  			}
  		},
  		onCreate: function( $vI ) {
  			setNavi( $(this), $vI );
  		}
  	});
  });	

