/**
 * jquery.undoCountdown.js
 * @version: v1.0.0
 * @author: Sebastian Marulanda http://marulanda.me
 * @see: https://github.com/smarulanda/jquery.undoCountdown
 */

(function($) {

	$.fn.undoCountdown = function(options) {
		
		var defaults = {
			seconds: 5,
			term: 'Undo',
			showCountdown: true,
			url: '',
			onComplete: function() { return true; }
		};

		var settings = $.extend({}, defaults, options);

		return this.each(function() {
			var click_count = 0;
			var $button = $(this);
			var originalContent = $button.html();
			var seconds = settings.seconds;
			var term = settings.term;
			var showCountdown = settings.showCountdown;
			var url = settings.url;
			var interval;

			$button.click(function() {
				if (interval) {
					click_count+=1;
					if(click_count == 2){
						$.get(url);
						$("#calling-modal").modal("hide");
					}else{
						reset();
					}
					
				}
				else {
					click_count+=1;
					update();
					start();
				}
			});

			function start() {
				if (!interval) {
					interval = setInterval(update, 1000);
				}
			}

			function reset() {
				if (interval) {
					$button.html(originalContent);
					clearInterval(interval);
					interval = null;
					seconds = settings.seconds;
				}
			}

			function update() {
				if (showCountdown) {
					$button.html(term + " (" + seconds + ")");
				}
				else {
					$button.html(term);
				}

				if (seconds == 0) {
					settings.onComplete.call();

					if (interval) {
						clearInterval(interval);	
					}
				} 
				else {
					seconds--;
				}
			}

		});

	}

}(jQuery));
