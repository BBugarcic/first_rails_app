var tStart = 100 // Start transition 100px from top
  , tEnd = 500   // End at 500px
  , cStart = [255, 255, 255]  // white
  , cEnd = [139, 139, 139]   // gray
  , cDiff = [cEnd[0] - cStart[0], cEnd[1] - cStart[1], cEnd[1] - cStart[0]];

var refreshRating = function() {
  $('.rating').raty( { path: '/assets', scoreName: 'comment[rating]' });
  $('.rated').raty({ path: '/assets',
      readOnly: true,
      score: function() {
          return $(this).attr('data-score');
      }
  });
};

$(document).on('turbolinks:load', function(){

    $(document).scroll(function() {
        var p = ($(this).scrollTop() - tStart) / (tEnd - tStart); // % of transition
        p = Math.min(1, Math.max(0, p)); // Clamp to [0, 1]
        var cBg = [Math.round(cStart[0] + cDiff[0] * p), Math.round(cStart[1] + cDiff[1] * p), Math.round(cStart[2] + cDiff[2] * p)];
        $(".bg-color-change").css('background-color', 'rgb(' + cBg.join(',') +')');
    });

    refreshRating();

    $(".close-offer").click(function() {
      $(".fade-out").fadeOut();
    });

    if (!$("#error_explanation").hasClass("alert")) {
      $("#error_explanation").addClass("alert alert-danger");
      $("#error_explanation h2").css("display", "none");
      //$("#error_explanation ul").css("list-style", "none");
    }

    $(".alert").fadeOut(8000);

    // elevateZoom
    $(".img-zoom").elevateZoom({
      zoomWindowWidth: 350,
      zoomWindowHeight: 300,
      zoomWindowPosition: 6,
			zoomWindowFadeIn: 500,
			zoomWindowFadeOut: 500,
			lensFadeIn: 500,
			lensFadeOut: 500
    });

});
