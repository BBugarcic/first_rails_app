/*$(document).ready(function() {
  var scrollCurrent = 0;
  $(document).scroll(function() {
    scrollCurrent = $(this).scrollTop();
    if(scrollCurrent > 80) {
      $(".bg-color-change").css("background-color", "#a6a6a6" );
    } else {
      $(".bg-color-change").css("background-color", "#FFFFFF" );
    }
  });

});*/

var tStart = 100 // Start transition 100px from top
  , tEnd = 500   // End at 500px
  , cStart = [255, 255, 255]  // Gold
  , cEnd = [139, 139, 139]   // Lime
  , cDiff = [cEnd[0] - cStart[0], cEnd[1] - cStart[1], cEnd[1] - cStart[0]];

$(document).ready(function(){
    $(document).scroll(function() {
        var p = ($(this).scrollTop() - tStart) / (tEnd - tStart); // % of transition
        p = Math.min(1, Math.max(0, p)); // Clamp to [0, 1]
        var cBg = [Math.round(cStart[0] + cDiff[0] * p), Math.round(cStart[1] + cDiff[1] * p), Math.round(cStart[2] + cDiff[2] * p)];
        $(".bg-color-change").css('background-color', 'rgb(' + cBg.join(',') +')');
    });

    $(".close-offer").click(function() {
      console.log('click');
      $(".fade-out").fadeOut();
    });
});